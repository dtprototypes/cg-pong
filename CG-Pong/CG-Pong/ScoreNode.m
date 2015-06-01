//
//  ScoreNode.m
//  Pong
//
//  Created by Michael Koukoullis on 1/08/13.
//  Copyright (c) 2013 Michael Koukoullis. All rights reserved.
//

#import "ScoreNode.h"

@interface ScoreNode ()
@end

@implementation ScoreNode

- (id)init
{
    return [self initWithName:@"score"];
}

- (id)initWithName:(NSString *)name
{
    self = [super init];
    
    if (self) {
        self.name = name;
        self.count = 0;
        self.fontSize = 150;
        [self updateText];
    }
    
    return self;
}

- (void)increment
{
    self.count += 1;
    [self updateText];
    
    SKAction *scoreSound = [SKAction playSoundFileNamed:@"score.wav" waitForCompletion:NO];
    [self runAction:scoreSound];
}

- (void)reset
{
    self.count = 0;
    [self updateText];
}

- (void)updateText
{
    self.text = [NSString stringWithFormat:@"%ld", (long)self.count];
}

@end
