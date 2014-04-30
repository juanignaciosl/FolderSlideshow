//
//  FSFolderWatcher.m
//  FolderSlideshow
//
//  Created by Juan Ignacio Sánchez Lara on 28/04/14.
//  Copyright (c) 2014 juanignaciosl. All rights reserved.
//

#include <sys/types.h>
#include <dirent.h>
#import "FSFolderWatcher.h"

FSFolderWatcher * folderWatcherRef;

void callbackFunction(ConstFSEventStreamRef streamRef,
                      void *clientCallBackInfo,
                      size_t numEvents,
                      void *eventPaths,
                      const FSEventStreamEventFlags eventFlags[],
                      const FSEventStreamEventId eventIds[]) {
    NSLog(@"Callbacked");
    int i;
    char **paths = eventPaths;
    
    // printf("Callback called\n");
    for (i=0; i<numEvents; i++) {
        /* flags are unsigned long, IDs are uint64_t */
        printf("Change %llu in %s, flags %u\n", eventIds[i], paths[i], eventFlags[i]);
        [folderWatcherRef checkFolder];
    }
}


@interface FSFolderWatcher()

@property (strong, nonatomic, readonly) NSString *folder;
@property (strong, nonatomic, readonly) NSObject<FSFolderWatcherDelegate> *delegate;
@property (strong, nonatomic) NSMutableArray *pictures;

@end

@implementation FSFolderWatcher

- (id)initWithFolder:(NSString *)folder andDelegate: (NSObject<FSFolderWatcherDelegate>*) delegate {
    self = [super init];
    if(self) {
        folderWatcherRef = self;
        _folder = folder;
        _delegate = delegate;
        _pictures = [[NSMutableArray alloc] init];
        
        [self checkFolder];
        [self startWatching];
    }
    return self;
}

- (void) checkFolder {
    struct dirent **names = NULL;
    int n = scandir([self.folder cStringUsingEncoding: NSUTF8StringEncoding], &names, NULL, NULL);
    if (n < 0) {
        perror("scandir");
    } else {
        while (n--) {
            struct dirent * name = names[n];
            NSString *file = [NSString stringWithUTF8String: name->d_name];
            if(![file hasPrefix: @"."] && ![_pictures containsObject: file]) {
                NSLog(@"New file: %@d", file);
                [_pictures addObject: file];
                [_delegate newFileAtPath: [NSString stringWithFormat: @"%@/%@", _folder, file]];
            }
            free(names[n]);
        }
        
        free(names);
    }
}

- (void) startWatching {
    CFStringRef path = (__bridge CFStringRef) self.folder;
    
    CFArrayRef pathsToWatch = CFArrayCreate(NULL, (const void **) &path, 1, NULL);
    void *callBackInfo = NULL;
    FSEventStreamRef stream;
    CFAbsoluteTime latency = 3.0;
    
    stream = FSEventStreamCreate(NULL, &callbackFunction, callBackInfo, pathsToWatch, kFSEventStreamEventIdSinceNow, latency, kFSEventStreamCreateFlagNone);
    
    FSEventStreamScheduleWithRunLoop(stream, CFRunLoopGetCurrent(), kCFRunLoopDefaultMode);
    
    FSEventStreamStart(stream);
}

@end
