//
//  Paddle.h
//  Pong
//
//  Created by Michael Koukoullis on 17/07/13.
//  Copyright (c) 2013 Michael Koukoullis. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "TuioClient.h"

@interface PaddleNode : SKSpriteNode

@property (nonatomic, readonly) float speed;
//@property (nonatomic, strong) TuioClient *tuioClient;

- (id)initWithName:(NSString *)name;
- (CGPoint)normalisePoint:(CGPoint)point;
- (BOOL)withinParentFrame:(CGPoint)point;


@end
