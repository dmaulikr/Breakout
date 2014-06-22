//
//  BarMgr.m
//  Breakout
//
//  Created by 筒井 啓太 on 2014/06/21.
//  Copyright (c) 2014年 keitanxkeitan. All rights reserved.
//

#import "BarMgr.h"
#import "Bar.h"
#import "InvisibleButton.h"
#import "GameScene.h"

#import "cocos2d.h"

@implementation BarMgr

//------------------------------------------------------------------------------

- (id)init
{
  self = [super init];
  if (!self) return nil;
  
  return self;
}

//------------------------------------------------------------------------------

- (void)createBars:(CCNode *)parentNode
{
  // バー
  alfaBar_ = [[Bar alloc] initWithTeam:kAlfa];
  [parentNode addChild:alfaBar_];
  bravoBar_ = [[Bar alloc] initWithTeam:kBravo];
  [parentNode addChild:bravoBar_];
  
  // ボタン
  const CGSize size = [[CCDirector sharedDirector] viewSize];
  
  const CGSize buttonSize = CGSizeMake(size.width / 2, size.height / 2);
  alfaRightButton_ = [[InvisibleButton alloc] init];
  [alfaRightButton_ setContentSize:buttonSize];
  alfaRightButton_.position = ccp(size.width / 2, 0.f);
  [alfaRightButton_ setBarForRight:alfaBar_];
  [parentNode addChild:alfaRightButton_];
  
  alfaLeftButton_ = [[InvisibleButton alloc] init];
  [alfaLeftButton_ setContentSize:buttonSize];
  alfaLeftButton_.position = ccp(0.f, 0.f);
  [alfaLeftButton_ setBarForLeft:alfaBar_];
  [parentNode addChild:alfaLeftButton_];
  
  bravoRightButton_ = [[InvisibleButton alloc] init];
  [bravoRightButton_ setContentSize:buttonSize];
  bravoRightButton_.position = ccp(size.width / 2, size.height / 2);
  [bravoRightButton_ setBarForRight:bravoBar_];
  [parentNode addChild:bravoRightButton_];
  
  bravoLeftButton_ = [[InvisibleButton alloc] init];
  [bravoLeftButton_ setContentSize:buttonSize];
  bravoLeftButton_.position = ccp(0.f, size.height / 2);
  [bravoLeftButton_ setBarForLeft:bravoBar_];
  [parentNode addChild:bravoLeftButton_];
}

//------------------------------------------------------------------------------
@end
