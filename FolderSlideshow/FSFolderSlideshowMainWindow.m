//
//  FSImageView.m
//  FolderSlideshow
//
//  Created by Juan Ignacio Sánchez Lara on 28/04/14.
//  Copyright (c) 2014 juanignaciosl. All rights reserved.
//

#import "FSFolderSlideshowMainWindow.h"

@interface FSFolderSlideshowMainWindow()

@property (nonatomic) int currentImageIndex;
@property (strong, nonatomic) NSMutableArray *imagePaths;
@property (strong, nonatomic) NSTimer* timer;

@end

@implementation FSFolderSlideshowMainWindow

- (id)initWithContentRect:(NSRect)contentRect styleMask:(NSUInteger)aStyle backing:(NSBackingStoreType)bufferingType defer:(BOOL)flag {
    self = [super initWithContentRect:contentRect styleMask:aStyle backing:bufferingType defer:flag];
    if(self) {
        _currentImageIndex = 0;
        _imagePaths = [[NSMutableArray alloc] init];
        _timer = [NSTimer scheduledTimerWithTimeInterval: 1 target:self selector:@selector(changeImage) userInfo:nil repeats:YES];
    }
    return self;
}

- (void)newFileAtPath:(NSString *)path {    
    [self.imagePaths addObject: path];
}
- (void) changeImage {
    if(_imagePaths.count > 0) {
        _currentImageIndex = (_currentImageIndex + 1) % _imagePaths.count;
        
        [self.imageView setImage: [[NSImage alloc] initWithContentsOfFile: [_imagePaths objectAtIndex: _currentImageIndex]]];
    }
}

@end
