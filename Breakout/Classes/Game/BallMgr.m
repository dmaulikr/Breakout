//
//  BallMgr.m
//  Breakout
//
//  Created by 筒井 啓太 on 2014/06/21.
//  Copyright (c) 2014年 keitanxkeitan. All rights reserved.
//

#import "BallMgr.h"
#import "Ball.h"
#import "GameDef.h"
#import "GameScene.h"

#import "cocos2d.h"

@implementation BallMgr

//------------------------------------------------------------------------------

- (id)init
{
  self = [super init];
  if (!self) return nil;
  
  ballList_ = [[NSMutableArray alloc] init];
  
  return self;
}

//------------------------------------------------------------------------------

- (void)createBalls
{
  for (int i = 0; i < kBallNum; ++i)
  {
    Ball* ball = [[Ball alloc] init];
    [ballList_ addObject:ball];
  }
}

//------------------------------------------------------------------------------

- (Ball*)activateOne:(CCNode *)parentNode
{
  for (Ball* ball in ballList_)
  {
    if (![ball parent])
    {
      [parentNode addChild:ball];
      [parentNode addChild:ball.motionStreak];
      return ball;
    }
  }
  
  return nil;
}

//------------------------------------------------------------------------------

- (void)activateAndInitializeTwo:(CCNode *)parentNode
{
  const CGSize size = [[CCDirector sharedDirector] viewSize];
  const CGPoint pos = ccp(size.width / 2, size.height / 2);
  
  Ball* ball0 = [self activateOne:parentNode];
  [ball0 initialize:pos Vel:ccp(0.f, -10.f)];
  
  Ball* ball1 = [self activateOne:parentNode];
  [ball1 initialize:pos Vel:ccp(0.f, 10.f)];
}

//------------------------------------------------------------------------------

- (void)activateAndInitializeFour:(CCNode *)parentNode
{
  const CGSize size = [[CCDirector sharedDirector] viewSize];
  const CGPoint pos = ccp(size.width / 2, size.height / 2);
  
  Ball* ball0 = [self activateOne:parentNode];
  [ball0 initialize:pos Vel:ccp(10.f, -14.f)];
  
  Ball* ball1 = [self activateOne:parentNode];
  [ball1 initialize:pos Vel:ccp(-10.f, -14.f)];
  
  Ball* ball2 = [self activateOne:parentNode];
  [ball2 initialize:pos Vel:ccp(10.f, 14.f)];
  
  Ball* ball3 = [self activateOne:parentNode];
  [ball3 initialize:pos Vel:ccp(-10.f, 14.f)];
  
}

//------------------------------------------------------------------------------

- (void)fadeAll
{
  for (Ball* ball in ballList_)
  {
    [ball fade];
  }
}

//------------------------------------------------------------------------------
@end
