//
//  ScoreNode.h
//  Pong
//
//  Created by Michael Koukoullis on 1/08/13.
//  Copyright (c) 2013 Michael Koukoullis. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface ScoreNode : SKLabelNode

@property (nonatomic, assign) NSInteger count;

- (id)initWithName:(NSString *)name;
- (void)increment;
- (void)reset;

@end
