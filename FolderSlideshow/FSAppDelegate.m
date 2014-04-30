//
//  FSAppDelegate.m
//  FolderSlideshow
//
//  Created by Juan Ignacio Sánchez Lara on 28/04/14.
//  Copyright (c) 2014 juanignaciosl. All rights reserved.
//

#import "FSAppDelegate.h"
#import "FSFolderWatcher.h"
#import "FSFolderSlideshowMainWindow.h"

@implementation FSAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{    
    FSFolderSlideshowMainWindow *mainWindow = (FSFolderSlideshowMainWindow *) self.window;
    
    CGDisplayCapture(kCGDirectMainDisplay);
    int windowLevel = CGShieldingWindowLevel();
    [mainWindow setLevel: windowLevel];
    [mainWindow setFrame: [[NSScreen mainScreen] frame] display:YES];
    
    [[FSFolderWatcher alloc] initWithFolder: @"/Users/juanignaciosl/Pictures/AutoBackup/2014-04-29" andDelegate: mainWindow];
}

@end
