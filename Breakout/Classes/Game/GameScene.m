//
//  GameScene.m
//  Breakout
//
//  Created by 筒井 啓太 on 2014/06/21.
//  Copyright 2014年 keitanxkeitan. All rights reserved.
//

#import "GameScene.h"
#import "BlockMgr.h"
#import "BallMgr.h"
#import "Ball.h"
#import "BarMgr.h"

//------------------------------------------------------------------------------
#pragma mark - GameScene
//------------------------------------------------------------------------------

@implementation GameScene

//------------------------------------------------------------------------------
#pragma mark - Create & Destroy
//------------------------------------------------------------------------------

+ (GameScene *)scene
{
  return [[self alloc] init];
}

//------------------------------------------------------------------------------

- (id)init
{
  srand((unsigned)time(NULL));
  
  self = [super init];
  if (!self) return nil;
  
  // 物理
  physicsNode_ = [CCPhysicsNode node];
  physicsNode_.gravity = ccp(0.f, 0.f);
//  physicsNode_.debugDraw = YES;
  physicsNode_.collisionDelegate = self;
  [self addChild:physicsNode_];
  
  // 背景
  CCSprite* background = [CCSprite spriteWithImageNamed:@"Background.png"];
  background.position = ccp(self.contentSize.width / 2, self.contentSize.height / 2);
  background.physicsBody = [CCPhysicsBody bodyWithPolylineFromRect:background.spriteFrame.rect cornerRadius:0.f];
  background.physicsBody.collisionType = @"Background";
  [physicsNode_ addChild:background];
  
  // ブロック
  blockMgr_ = [[BlockMgr alloc] init];
  [blockMgr_ createBlocks:physicsNode_];
  
  // ボール
  ballMgr_ = [[BallMgr alloc] init];
  [ballMgr_ createBalls];
  Ball* ball = [ballMgr_ activateOne:physicsNode_];
  [ball initialize:ccp(self.contentSize.width / 2, self.contentSize.height / 2) Vel:ccp(-10.f, -10.f)];
  
  // バー
  barMgr_ = [[BarMgr alloc] init];
  [barMgr_ createBars:physicsNode_];
  
  return self;
}

//------------------------------------------------------------------------------

- (void)dealloc
{
  // clean up code goes here
}

//------------------------------------------------------------------------------
# pragma mark - Enter & Exit
//------------------------------------------------------------------------------

- (void)onEnter
{
  // always call super onEnter first
  [super onEnter];
}

//------------------------------------------------------------------------------

- (void)onExit
{
  // always call super onExit last
  [super onExit];
}

//------------------------------------------------------------------------------

- (BOOL)ccPhysicsCollisionBegin:(CCPhysicsCollisionPair *)pair Ball:(CCNode *)nodeA Block:(CCNode *)nodeB
{
  Ball* ball = (Ball*)nodeA;
  [ball informCollisionBegin:pair Node:nodeB];
  return NO;
}

//------------------------------------------------------------------------------

- (BOOL)ccPhysicsCollisionBegin:(CCPhysicsCollisionPair *)pair Ball:(CCNode *)nodeA Background:(CCNode *)nodeB
{
  Ball* ball = (Ball*)nodeA;
  [ball informCollisionBegin:pair Node:nodeB];
  return YES;
}

//------------------------------------------------------------------------------

- (BOOL)ccPhysicsCollisionBegin:(CCPhysicsCollisionPair *)pair Ball:(CCNode *)nodeA Bar:(CCNode *)nodeB
{
  Ball* ball = (Ball*)nodeA;
  [ball informCollisionBegin:pair Node:nodeB];
  return NO;
}

//------------------------------------------------------------------------------
@end
