//
//  Ball.m
//  Breakout
//
//  Created by 筒井 啓太 on 2014/06/21.
//  Copyright 2014年 keitanxkeitan. All rights reserved.
//

#import "Ball.h"
#import "GameScene.h"
#import "Block.h"
#import "Bar.h"

#import "BPGeometry.h"


@implementation Ball

//------------------------------------------------------------------------------

const float kMaxRotVelDeg = 30.f;
const float kRotVelKd = 0.96f;
const float kBallVel = 14.f;
const float kAccByRot = 1.f;
const float kRotAccDeg = 30.f;

//------------------------------------------------------------------------------

- (id)init
{
  self = [super initWithImageNamed:@"Ball.png"];
  if (!self) return nil;
  
  // 物理
  self.physicsBody = [CCPhysicsBody bodyWithCircleOfRadius:self.spriteFrame.rect.size.height / 2 andCenter:ccp(self.spriteFrame.rect.size.width / 2, self.spriteFrame.rect.size.height / 2)];
  self.physicsBody.collisionType = @"Ball";
  
  return self;
}

//------------------------------------------------------------------------------

- (void)initialize:(CGPoint)pos Vel:(CGPoint)vel
{
  vel_ = vel;
  rotVelDeg_ = 0.f;
  
  self.position = pos;
}

//------------------------------------------------------------------------------

- (void)update:(CCTime)delta
{
  // 回転速度更新
  {
    // ダンパ
    rotVelDeg_ *= kRotVelKd;
    
    // クランプ
    if (rotVelDeg_ > kMaxRotVelDeg) rotVelDeg_ = kMaxRotVelDeg;
    else if ( rotVelDeg_ < -kMaxRotVelDeg) rotVelDeg_ = -kMaxRotVelDeg;
  }
  
  // 速度更新
  {
    // 回転による加速
    CGPoint accByRot;
    {
      CGPoint accDir = CGPointMake(-vel_.y, vel_.x);
      accDir = CGPointNormalize(accDir);
      
      const float rotRate = rotVelDeg_ / kMaxRotVelDeg;
      const float acc = kAccByRot * rotRate;
      
      accByRot = CGPointMake(accDir.x * acc, accDir.y * acc);
    }
    
    // 加速
    vel_ = CGPointAdd(vel_, accByRot);
    
    // 速度調整
    const CGPoint normalizedVel = CGPointNormalize(vel_);
    vel_ = CGPointMake(normalizedVel.x * kBallVel, normalizedVel.y * kBallVel);
  }

  // 位置更新
  [self setPosition:ccp(self.position.x + vel_.x, self.position.y + vel_.y)];
}

//------------------------------------------------------------------------------

- (void)informCollisionBegin:(CCPhysicsCollisionPair *)pair Node:(CCNode *)node
{
  const CGPoint normal = pair.contacts.normal;
  const float dot = CGPointDot(vel_, normal);
  vel_.x += -normal.x * dot * 2;
  vel_.y += -normal.y * dot * 2;
  
  if ([node isMemberOfClass:[Block class]])
  {
    Block* block = (Block *)node;
    [block removeFromParent];
  }
  else if ([node isMemberOfClass:[Bar class]])
  {
    Bar* bar = (Bar *)node;
    const CGPoint barVel = ccp(bar.vel, 0.f);
    const float dot = CGPointDot(barVel, normal);
    const CGPoint barVelNormal = CGPointScale(normal, dot);
    const CGPoint barVelVertical = CGPointSubtract(barVel, barVelNormal);
    const double cross = CGPointCross(normal, barVelVertical);
    const double magnitude = CGPointMagnitude(barVelVertical);
    const double barVelRate = magnitude / [bar maxVel];
    const float rotAccDeg = kRotAccDeg * (barVelRate * barVelRate);
    if (cross > 0.f) rotVelDeg_ += rotAccDeg;
    else if (cross < 0.f) rotVelDeg_ -= rotAccDeg;
  }
}

//------------------------------------------------------------------------------


@end
