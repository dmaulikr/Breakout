//
//  Bar.m
//  Breakout
//
//  Created by 筒井 啓太 on 2014/06/21.
//  Copyright 2014年 keitanxkeitan. All rights reserved.
//

#import "Bar.h"
#import "GameScene.h"


@implementation Bar

//------------------------------------------------------------------------------

const float kBarWidth = 120.f;
const float kBarHeight = 12.f;

//------------------------------------------------------------------------------

const float kVel = 16.f;
const float kAcc = 5.f;
const float kKd = 0.75f;

//------------------------------------------------------------------------------

- (id)initWithTeam:(Team)team
{
  self = [super initWithImageNamed:@"Bar.png"];
  if (!self) return nil;
  
  const GameScene* scene = (GameScene*)[[CCDirector sharedDirector] runningScene];
  
  vel_ = 0.f;
  CGPoint pos;
  pos.x = scene.contentSize.width / 2;
  pos.y = (team == kAlfa) ?
          kBlockHeight * (kTeamBlockRowNum + 2) + kBarHeight / 2 :
          scene.contentSize.height - ((kBlockHeight * (kTeamBlockRowNum + 2)) + kBarHeight / 2);
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
    const GameScene* scene = (GameScene*)[[CCDirector sharedDirector] runningScene];
    const float maxPosX = scene.contentSize.width - (kBarWidth / 2);
    const float minPosX = kBarWidth / 2;
    if (posX > maxPosX) posX = maxPosX;
    else if (posX < minPosX) posX = minPosX;
    
    [self setPosition:ccp(posX, self.position.y)];
  }
}

//------------------------------------------------------------------------------
@end
