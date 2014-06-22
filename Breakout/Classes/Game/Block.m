//
//  Block.m
//  Breakout
//
//  Created by 筒井 啓太 on 2014/06/21.
//  Copyright 2014年 keitanxkeitan. All rights reserved.
//

#import "Block.h"
#import "GameScene.h"


@implementation Block

//------------------------------------------------------------------------------

const float kBlockWidth = 32.f;
const float kBlockHeight = 20.f;

//------------------------------------------------------------------------------

- (id)initWithTeam:(Team)team Index:(int)index
{
  const int type = rand() % kTypeNum;
  
  self = [super initWithImageNamed:[NSString stringWithFormat:@"Block%02d.png", type]];
  if (!self) return nil;
  
  team_ = team;
  index_ = index;
  type_ = type;
  isFadeRequest_ = NO;
  self.position = [self calcPos:team_ Index:index_];
  if (team == kBravo) self.rotation = 180.f;
  
  // 物理
  self.physicsBody = [CCPhysicsBody bodyWithRect:self.spriteFrame.rect cornerRadius:0.f];
  self.physicsBody.collisionType = @"Block";
  self.physicsBody.type = CCPhysicsBodyTypeStatic;
  
  return self;
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
}

//------------------------------------------------------------------------------

- (CGPoint)calcPos:(Team)team Index:(int)index
{
  const int row = index / kTeamBlockColNum;
  const int col = index % kTeamBlockColNum;
  
  const CGPoint offset = (team == kAlfa) ?
                         ccp(kBlockWidth, -kBlockHeight) :
                         ccp(-kBlockWidth, kBlockHeight);
  
  const GameScene* scene = (GameScene*)[[CCDirector sharedDirector] runningScene];
  
  const CGPoint basePos = (team == kAlfa) ?
                          ccp(kBlockWidth * 0.5f, kBlockHeight * (kTeamBlockRowNum - 0.5f)) :
                          ccp(scene.contentSize.width - (kBlockWidth * 0.5f), scene.contentSize.height - (kBlockHeight * (kTeamBlockRowNum - 0.5f)));
  
  CGPoint pos = basePos;
  pos.x += offset.x * col;
  pos.y += offset.y * row;
  
  return pos;
}

//------------------------------------------------------------------------------

- (void)update:(CCTime)delta
{
}

//------------------------------------------------------------------------------
@end
