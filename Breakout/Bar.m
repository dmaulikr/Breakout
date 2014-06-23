//
//  Bar.m
//  Breakout
//
//  Created by 筒井 啓太 on 2014/06/21.
//  Copyright 2014年 keitanxkeitan. All rights reserved.
//

#import "Bar.h"


@implementation Bar

//------------------------------------------------------------------------------

const float kBarWidth = 120.f;
const float kBarHeight = 12.f;

//------------------------------------------------------------------------------

const float kVel = 6.f;
const float kAcc = 0.9f;
const float kKd = 0.91f;

//------------------------------------------------------------------------------

- (id)initWithTeam:(Team)team
{
  self = [super initWithImageNamed:@"Bar.png"];
  if (!self) return nil;
  
  const CGSize size = [[CCDirector sharedDirector] viewSize];
  
  vel_ = 0.f;
  CGPoint pos;
  pos.x = size.width / 2;
  pos.y = (team == kAlfa) ?
          kBlockHeight * (kTeamBlockRowNum + 2) + kBarHeight / 2 + kMarginBottomTop :
          size.height - ((kBlockHeight * (kTeamBlockRowNum + 2)) + kBarHeight / 2 + kMarginBottomTop);
  self.position = pos;
  
  // 物理
  self.physicsBody = [CCPhysicsBody bodyWithRect:self.spriteFrame.rect cornerRadius:0.f];
  self.physicsBody.collisionType = @"Bar";
  self.physicsBody.type = CCPhysicsBodyTypeStatic;
  
  return self;
}

//------------------------------------------------------------------------------

- (void)accRight
{
  vel_ += kAcc;
}

//------------------------------------------------------------------------------

- (void)accLeft
{
  vel_ -= kAcc;
}

//------------------------------------------------------------------------------

- (float)vel
{
  return vel_;
}

//------------------------------------------------------------------------------

- (float)maxVel
{
  return kVel;
}

//------------------------------------------------------------------------------

- (void)update:(CCTime)delta
{
  // 速度更新
  {
    // ダンパ
    vel_ *= kKd;
  
    // クランプ
    if (vel_ > kVel) vel_ = kVel;
    else if (vel_ < -kVel) vel_ = -kVel;
  }
  
  // 位置更新
  {
    float posX = self.position.x + vel_;
    
    // クランプ
    const CGSize size = [[CCDirector sharedDirector] viewSize];
    const float maxPosX = size.width - (kBarWidth / 2);
    const float minPosX = kBarWidth / 2;
    if (posX > maxPosX) posX = maxPosX;
    else if (posX < minPosX) posX = minPosX;
    
    [self setPosition:ccp(posX, self.position.y)];
  }
}

//------------------------------------------------------------------------------
@end
