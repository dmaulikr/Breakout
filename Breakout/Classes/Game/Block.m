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

const float kWidth = 32.f;
const float kHeight = 20.f;

//------------------------------------------------------------------------------

- (id)initWithTeam:(Team)team Index:(int)index
{
  const int type = rand() % kTypeNum;
  
  self = [super initWithImageNamed:[NSString stringWithFormat:@"Block%02d.png", type]];
  if (!self) return nil;
  
  team_ = team;
  index_ = index;
  type_ = type;
  self.position = [self calcPos:team_ Index:index_];
  if (team == kBravo) self.rotation = 180.f;
  
  return self;
}

//------------------------------------------------------------------------------

- (CGPoint)calcPos:(Team)team Index:(int)index
{
  const int row = index / kTeamBlockColNum;
  const int col = index % kTeamBlockColNum;
  
  const CGPoint offset = (team == kAlfa) ?
                         ccp(kWidth, -kHeight) :
                         ccp(-kWidth, kHeight);
  
  const GameScene* scene = (GameScene*)[[CCDirector sharedDirector] runningScene];
  
  const CGPoint basePos = (team == kAlfa) ?
                          ccp(kWidth * 0.5f, kHeight * (kTeamBlockRowNum - 0.5f)) :
                          ccp(scene.contentSize.width - (kWidth * 0.5f), scene.contentSize.height - (kHeight * (kTeamBlockRowNum - 0.5f)));
  
  CGPoint pos = basePos;
  pos.x += offset.x * col;
  pos.y += offset.y * row;
  
  return pos;
}

//------------------------------------------------------------------------------
@end
