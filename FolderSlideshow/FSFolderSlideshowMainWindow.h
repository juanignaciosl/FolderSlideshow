//
//  FSImageView.h
//  FolderSlideshow
//
//  Created by Juan Ignacio Sánchez Lara on 28/04/14.
//  Copyright (c) 2014 juanignaciosl. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "FSFolderWatcher.h"

@interface FSFolderSlideshowMainWindow : NSWindow<FSFolderWatcherDelegate>

@property (strong) IBOutlet NSImageView *imageView;

@end
