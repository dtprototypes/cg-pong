//
//  PlayerNode.m
//  Pong
//
//  Created by Michael Koukoullis on 31/07/13.
//  Copyright (c) 2013 Michael Koukoullis. All rights reserved.
//

#import "PlayerNode.h"
#import "PaddleNode.h"
#import "ScoreNode.h"

@interface PlayerNode ()

@property TuioClient *tuioClient;
@property int uniqueID;
@property PaddleNode *leftPaddle;
@property PaddleNode *rightPaddle;

@end

@implementation PlayerNode

- (id)init
{
    return [self initOnLeftSide];
}

- (id)initOnLeftSide
{
    self = [super init];
    if (self) {
        self.name = @"leftPlayer";
        self.leftPaddle = [[PaddleNode alloc] initWithName:@"leftPaddle"];
        [self addChild:self.leftPaddle];
        ScoreNode *score = [[ScoreNode alloc] initWithName:@"leftScore"];
        [self addChild:score];
        
        self.tuioClient = [[TuioClient alloc]initWithPortNumber:3333];
        self.tuioClient.tuioCursorDelegate = self;
    }
    return self;
}

- (id)initOnRightSide
{
    self = [super init];
    if (self) {
        self.name = @"rightPlayer";
        self.rightPaddle = [[PaddleNode alloc] initWithName:@"rightPaddle"];
        [self addChild:self.rightPaddle];
        ScoreNode *score = [[ScoreNode alloc] initWithName:@"rightScore"];
        [self addChild:score];
        
        self.tuioClient = [[TuioClient alloc]initWithPortNumber:3333];
        self.tuioClient.tuioCursorDelegate = self;

    }
    return self;
}

- (void)positionOnLeftSide
{
    SKNode *paddle = [self childNodeWithName:@"leftPaddle"];
    paddle.position = CGPointMake(100, CGRectGetMidY(self.parent.frame));
    
    SKNode *score = [self childNodeWithName:@"leftScore"];
    score.position = CGPointMake((CGRectGetMidX(self.parent.frame) - 200), self.parent.frame.size.height - 150);
}

- (void)positionOnRightSide
{
    SKNode *paddle = [self childNodeWithName:@"rightPaddle"];
    paddle.position = CGPointMake(self.parent.frame.size.width - 100, CGRectGetMidY(self.parent.frame));
    
    SKNode *score = [self childNodeWithName:@"rightScore"];
    score.position = CGPointMake((CGRectGetMidX(self.parent.frame) + 200), self.parent.frame.size.height - 150);

}

#pragma mark Tuio delegate

- (void) tuioCursorAdded: (TuioCursor*) newCursor{
    if (self.uniqueID < 0){
        self.uniqueID = newCursor.uniqueID;
        NSLog(@"setting id %i", self.uniqueID);

    }

}
- (void) tuioCursorUpdated: (TuioCursor*) updatedCursor{

    float movePoint;
    float scale = 0.9;
    if (updatedCursor.position.y > updatedCursor.originalPosition.y)
        movePoint = updatedCursor.position.y - updatedCursor.originalPosition.y;
    else
        movePoint = -(updatedCursor.originalPosition.y - updatedCursor.position.y);

    float fullScreenWidth = [self.tuioClient getFullscreenWidth];
    
    if (updatedCursor.position.x > fullScreenWidth/2){
        NSLog(@"paddle position x %f y %f", self.leftPaddle.position.x, self.leftPaddle.position.y);

        self.uniqueID = updatedCursor.uniqueID;
        CGPoint newPosition = CGPointMake(self.leftPaddle.position.x, self.leftPaddle.position.y + (movePoint * scale));
        
        if ([self.leftPaddle withinParentFrame:newPosition])
            self.leftPaddle.position = newPosition;
        
        
    } else {
        NSLog(@"paddle position x %f y %f", self.rightPaddle.position.x, self.rightPaddle.position.y);

        CGPoint newPosition = CGPointMake(self.rightPaddle.position.x, self.rightPaddle.position.y + (movePoint * scale));
        
        if ([self.rightPaddle withinParentFrame:newPosition])
            self.rightPaddle.position = newPosition;
    }
    
}
- (void) tuioCursorRemoved: (TuioCursor*) deadCursor{
    
}
- (void) tuioCursorFrameFinished{
}

#pragma mark Tuio object delegate

- (void) tuioObjectAdded: (TuioObject*) newObject{
    NSLog(@"tuioObjectAdded %f", newObject.position.y);

}
- (void) tuioObjectUpdated: (TuioObject*) updateObject{
    NSLog(@"tuioObjectAdded %f", updateObject.position.y);

}
- (void) tuioObjectRemoved: (TuioObject*) deadObject{
}



@end
