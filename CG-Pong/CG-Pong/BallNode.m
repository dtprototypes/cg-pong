//
//  BallNode.m
//  Pong
//
//  Created by Michael Koukoullis on 15/07/13.
//  Copyright (c) 2013 Michael Koukoullis. All rights reserved.
//

#import "BallNode.h"
#import "NodeCategories.h"
#import "RandomHelper.h"

float const kMagnitude = 2800;


@implementation BallNode

- (id)init
{
    return [self initWithRadius:35];
}

- (id)initWithRadius:(float)radius
{
    self = [super init];
    if (self) {
        CGMutablePathRef pathRef = CGPathCreateMutable();
        CGPathAddArc(pathRef, NULL, 0,0, radius, 0, M_PI*2, YES);
        self.path = pathRef;
        self.fillColor = [SKColor whiteColor];
        self.strokeColor = [SKColor blueColor];
        self.userInteractionEnabled = YES;
        self.name = @"ball";
        
        self.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:(radius)];
        self.physicsBody.categoryBitMask = ballCategory;
        self.physicsBody.contactTestBitMask = playfieldCategory | paddleCategory;
        self.physicsBody.collisionBitMask = emptyCategory;
        self.physicsBody.linearDamping = 0;
        self.physicsBody.angularDamping = 0;
        self.physicsBody.affectedByGravity = NO;
        self.physicsBody.usesPreciseCollisionDetection = YES;
        

    }
    
    return self;
}

- (void)resetPosition
{
    self.position = CGPointMake(CGRectGetMidX(self.scene.frame), CGRectGetMidY(self.scene.frame));
}

- (void)serveLeftwards
{
    [self resetPosition];
    CGFloat direction = skRand(M_PI + M_PI_4, M_PI + M_PI_2 + M_PI_4);
    CGFloat magnitude = skRand(kMagnitude, kMagnitude);
    [self setVelocityWithRadians:direction Magnitude:magnitude];
}

- (void)serveRightwards
{
    [self resetPosition];
    CGFloat direction = skRand(M_PI_4, M_PI_2 + M_PI_4);
    CGFloat magnitude = skRand(kMagnitude, kMagnitude);
    [self setVelocityWithRadians:direction Magnitude:magnitude];
}

- (void)reflectVerticalVelocity
{
    CGFloat x = self.physicsBody.velocity.dx;
    CGFloat y = -1 * self.physicsBody.velocity.dy;
    self.physicsBody.velocity = CGVectorMake(x,y);
    [self playBounceSound];

}

- (void)setVelocityWithRadians:(float)radians Magnitude:(float)magnitude
{
    CGFloat horizontalVelocity = magnitude * sin(radians);
    CGFloat verticalVelocity = magnitude * cos(radians);
    self.physicsBody.velocity = CGVectorMake(horizontalVelocity, verticalVelocity);
}

- (void)playBounceSound {
    SKAction *bounceSound = [SKAction playSoundFileNamed:@"bounce.wav" waitForCompletion:NO];
    [self runAction:bounceSound];
}


#if TARGET_OS_IPHONE

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self serveRightwards];
}

#endif

#pragma mark Mouse delegate

- (void)mouseUp:(NSEvent *)theEvent {
    [self serveRightwards];

}

@end
