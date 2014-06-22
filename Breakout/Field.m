//
//  Field.m
//  Breakout
//
//  Created by 筒井 啓太 on 2014/06/22.
//  Copyright (c) 2014年 keitanxkeitan. All rights reserved.
//

#import "Field.h"
#import "GameScene.h"

#import "cocos2d.h"

@implementation Field

//------------------------------------------------------------------------------

- (void)createField:(CCNode *)parentNode
{
  const GameScene* scene = (GameScene*)[[CCDirector sharedDirector] runningScene];
  
  CCNode* bottom = [CCNode node];
  bottom.physicsBody = [CCPhysicsBody bodyWithRect:CGRectMake(-50.f, -100.f, scene.contentSize.width + 100.f, 100.f) cornerRadius:0.f];
  bottom.physicsBody.collisionType = @"Background";
  bottom.physicsBody.type = CCPhysicsBodyTypeStatic;
  [parentNode addChild:bottom];
  
  CCNode* right = [CCNode node];
  right.physicsBody = [CCPhysicsBody bodyWithRect:CGRectMake(scene.contentSize.width, -50.f, 100.f, scene.contentSize.height + 100.f) cornerRadius:0.f];
  right.physicsBody.collisionType = @"Background";
  right.physicsBody.type = CCPhysicsBodyTypeStatic;
  [parentNode addChild:right];
  
  CCNode* top = [CCNode node];
  top.physicsBody = [CCPhysicsBody bodyWithRect:CGRectMake(-50.f, scene.contentSize.height, scene.contentSize.width + 100.f, 100.f) cornerRadius:0.f];
  top.physicsBody.collisionType = @"Background";
  top.physicsBody.type = CCPhysicsBodyTypeStatic;
  [parentNode addChild:top];
  
  CCNode* left = [CCNode node];
  left.physicsBody = [CCPhysicsBody bodyWithRect:CGRectMake(-100.f, -50.f, 100.f, scene.contentSize.height + 100.f) cornerRadius:0.f];
  left.physicsBody.collisionType = @"Background";
  left.physicsBody.type = CCPhysicsBodyTypeStatic;
  [parentNode addChild:left];
}

//------------------------------------------------------------------------------
@end
