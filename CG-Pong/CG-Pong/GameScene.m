//
//  GameScene.m
//  CG-Pong
//
//  Created by Andy So on 4/6/15.
//  Copyright (c) 2015 cg. All rights reserved.
//

#import "GameScene.h"
#import "PlayfieldScene.h"

@implementation GameScene

-(void)didMoveToView:(SKView *)view {
    /* Setup your scene here */
    [self setFullscreen];

    PlayfieldScene *playfield = [[PlayfieldScene alloc] init];
    
    SKView *spriteView = (SKView*) self.view;

    [spriteView presentScene:playfield];
    
}

- (void)setFullscreen {
    NSApplication *app = [NSApplication sharedApplication];
    NSWindow *window = [app windows][0];
    
    [window makeKeyAndOrderFront:nil];
    [window setLevel:NSScreenSaverWindowLevel];

    // Change the window style to borderless
    window.styleMask = NSBorderlessWindowMask;
    
    // Set the window frame to dual full screen
    NSRect frame = [window frame];
    frame = [self getFullscreenCanvas];
    
    [window setFrame: frame display: YES animate: YES];
    window.alphaValue = 1.0;
}

- (NSRect)getFullscreenCanvas {

    uint32_t maximum = 12;
    CGDirectDisplayID* displays = (CGDirectDisplayID*) calloc(maximum, sizeof(uint32_t));
    uint32_t total;
    CGError err = CGGetOnlineDisplayList(maximum, displays, &total);
    
    // iterate through all "online" displays and capture their global screen-space boundary
    CGRect canvasBounds;
    if (kCGErrorSuccess == err) {
        for (size_t index = 0; index < total; index++) {
            CGRect displayBounds = CGDisplayBounds(displays[index]);
            if (0 == index) {
                canvasBounds = displayBounds;
            }
            else {
                canvasBounds = CGRectUnion(canvasBounds, displayBounds);
            }
        }
    }
    
    // return output NSRect...setFullscreen
    return NSRectFromCGRect(canvasBounds);
}

-(void)mouseDown:(NSEvent *)theEvent {
     /* Called when a mouse click occurs */
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end
