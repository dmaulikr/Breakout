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
      return ball;
    }
  }
  
  return nil;
}

//------------------------------------------------------------------------------
@end
