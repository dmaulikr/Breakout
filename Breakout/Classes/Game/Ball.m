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

#import "BPGeometry.h"


@implementation Ball

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
}

//------------------------------------------------------------------------------


@end
