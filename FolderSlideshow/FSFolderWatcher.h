//
//  FSFolderWatcher.h
//  FolderSlideshow
//
//  Created by Juan Ignacio Sánchez Lara on 28/04/14.
//  Copyright (c) 2014 juanignaciosl. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol FSFolderWatcherDelegate <NSObject>

- (void) newFileAtPath: (NSString*) path;

@end

@interface FSFolderWatcher : NSObject

- (id) initWithFolder: (NSString*) folder andDelegate: (NSObject<FSFolderWatcherDelegate>*) delegate;
- (void) checkFolder;

@end
