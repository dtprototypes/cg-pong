//
//  PlayfieldScene.h
//  Pong
//
//  Created by Michael Koukoullis on 8/07/13.
//  Copyright (c) 2013 Michael Koukoullis. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "TuioClient.h"

@interface PlayfieldScene : SKScene <SKPhysicsContactDelegate, TuioCursorListener>

- (BOOL)isPointOnLeftEdge:(CGPoint)point;
- (BOOL)isPointOnRightEdge:(CGPoint)point;
- (void)serveBallLeftwards;
- (void)serveBallRightwards;
- (void)reset;

@end
