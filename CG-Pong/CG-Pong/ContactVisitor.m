//
//  ContactVisitor.m
//  Pong
//
//  Created by Michael Koukoullis on 29/07/13.
//  Copyright (c) 2013 Michael Koukoullis. All rights reserved.
//

#import "ContactVisitor.h"
#import <objc/runtime.h>
#import "NodeCategories.h"
#import "BallNodeContactVisitor.h"
#import "PaddleNodeContactVisitor.h"
#import "PlayfieldSceneContactVisitor.h"
#import <AVFoundation/AVFoundation.h>


@interface ContactVisitor ()
{
    AVAudioPlayer *_audioPlayer;
}
@end

@implementation ContactVisitor



+ (id)contactVisitorWithBody:(SKPhysicsBody *)body forContact:(SKPhysicsContact *)contact
{
    if ((body.categoryBitMask & ballCategory) !=0) {

        return [[BallNodeContactVisitor alloc] initWithBody:body forContact:contact];
    } else if ((body.categoryBitMask & playfieldCategory) != 0) {

        return [[PlayfieldSceneContactVisitor alloc] initWithBody:body forContact:contact];
    } else if ((body.categoryBitMask & paddleCategory) != 0) {
        
        return [[PaddleNodeContactVisitor alloc] initWithBody:body forContact:contact];
    } else {
        return nil;
    }
}

- (id)initWithBody:(SKPhysicsBody *)body forContact:(SKPhysicsContact *)contact
{
    self = [super init];
    if (self) {
        _contact = contact;
        _body = body;
    }
    return self;
}


- (void)visit:(SKPhysicsBody *)body
{
    
    // Construct URL to sound file
    NSString *path = [NSString stringWithFormat:@"%@/bounce.wav", [[NSBundle mainBundle] resourcePath]];
    NSURL *soundUrl = [NSURL fileURLWithPath:path];
    
    _audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:soundUrl error:nil];
    
    // This will generate strings like "BallNode", "PaddleNode", or "PlayfieldScene"
    NSString *bodyClassName = [NSString stringWithUTF8String:class_getName(body.node.class)];
    
    // This will generate strings like "visitBallNode:", "visitPaddleNode:", or "visitPlayfieldScene"
    NSMutableString *contactSelectorString = [NSMutableString stringWithFormat:@"visit"];
    [contactSelectorString appendString:bodyClassName];
    [contactSelectorString appendString:@":"];

    SEL selector = NSSelectorFromString(contactSelectorString);
    
    if ([self respondsToSelector:selector]) {
        [self performSelector:selector withObject:body];
    }    
}

- (void)playContactSound {
    NSLog(@"contactvisitor play sound");
        [SKAction playSoundFileNamed:@"bounce.wav" waitForCompletion:NO];
//    [_audioPlayer play];
}

@end
