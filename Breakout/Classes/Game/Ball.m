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
const float kRotVelKd = 0.98f;
const float kBallVel = 18.f;
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

  // モーション
  motionStreak_ = [CCMotionStreak streakWithFade:0.5f minSeg:1.f width:self.spriteFrame.rect.size.width color:[CCColor whiteColor] textureFilename:@"Ball.png"];
  
  return self;
}

//------------------------------------------------------------------------------

- (void)initialize:(CGPoint)pos Vel:(CGPoint)vel
{
  vel_ = vel;
  velOffset_ = CGPointMake(0.f, 0.f);
  rotVelDeg_ = 0.f;
  isFadeRequest_ = NO;
  
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
    // 補正値適用
    vel_ = CGPointAdd(vel_, velOffset_);
    velOffset_ = CGPointMake(0.f, 0.f);
    
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
    vel_ = CGPointScale(normalizedVel, kBallVel);
  }

  // 位置更新
  [self setPosition:ccp(self.position.x + vel_.x, self.position.y + vel_.y)];
  
  // モーション
  motionStreak_.position = self.position;
}

//------------------------------------------------------------------------------

- (void)informCollisionBegin:(CCPhysicsCollisionPair *)pair Node:(CCNode *)node
{
  // 補正値更新
  const CGPoint normal = pair.contacts.normal;
  const float dot = CGPointDot(vel_, normal);
  CGPoint velOffset = CGPointScale(normal, -dot * 2);
  velOffset_ = CGPointAdd(velOffset_, velOffset);
  
  // NSLog(@"normal: (%f, %f)", normal.x, normal.y);
  
  // 対ブロック
  if ([node isMemberOfClass:[Block class]])
  {
    Block* block = (Block *)node;
    [block fade];
    
    // モーションブラーの色が当たったブロックの色に変わる
    motionStreak_.color = block.color;
  }
  // 対バー
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

- (void)fade
{
  if (isFadeRequest_)
  {
    return;
  }
  
  isFadeRequest_ = YES;
  
  const CCActionFadeOut* fadeOut = [CCActionFadeOut actionWithDuration:0.25f];
  const CCActionRemove* remove = [CCActionRemove action];
  [self runAction:[CCActionSequence actionWithArray:@[fadeOut, remove]]];
  [motionStreak_ removeFromParent];
}

//------------------------------------------------------------------------------

- (CCMotionStreak *)motionStreak
{
  return motionStreak_;
}

//------------------------------------------------------------------------------
@end
