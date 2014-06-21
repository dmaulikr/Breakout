//
//  InvisibleButton.m
//  Breakout
//
//  Created by 筒井 啓太 on 2014/06/21.
//  Copyright 2014年 keitanxkeitan. All rights reserved.
//

#import "InvisibleButton.h"
#import "Bar.h"


@implementation InvisibleButton

//------------------------------------------------------------------------------

- (id)init
{
  self = [super init];
  if (!self) return nil;
  
  self.userInteractionEnabled = YES;
  isHold_ = NO;
  bar_ = nil;
  isRight_ = YES;
  
  return self;
}

//------------------------------------------------------------------------------

- (void)setBarForRight:(Bar *)bar
{
  bar_ = bar;
  isRight_ = YES;
}

//------------------------------------------------------------------------------

- (void)setBarForLeft:(Bar *)bar
{
  bar_ = bar;
  isRight_ = NO;
}

//------------------------------------------------------------------------------

- (void)update:(CCTime)delta
{
  if (isHold_)
  {
    isRight_ ? [bar_ accRight] : [bar_ accLeft];
  }
}

//------------------------------------------------------------------------------

- (void)touchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
  isHold_ = YES;
}

//------------------------------------------------------------------------------

- (void)touchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
  isHold_ = NO;
}

//------------------------------------------------------------------------------

- (void)touchCancelled:(UITouch *)touch withEvent:(UIEvent *)event
{
  isHold_ = NO;
}

//------------------------------------------------------------------------------
@end
