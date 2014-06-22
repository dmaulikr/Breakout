//
//  BlockMgr.m
//  Breakout
//
//  Created by 筒井 啓太 on 2014/06/21.
//  Copyright (c) 2014年 keitanxkeitan. All rights reserved.
//

#import "BlockMgr.h"
#import "Block.h"
#import "GameDef.h"

#import "cocos2d.h"

@implementation BlockMgr

//------------------------------------------------------------------------------

- (id)init
{
  self = [super init];
  if (!self) return nil;
  
  alfaBlockList_ = [[NSMutableArray alloc] init];
  bravoBlockList_ = [[NSMutableArray alloc] init];
  alfaBlockNum_ = 0;
  bravoBlockNum_ = 0;
  
  return self;
}

//------------------------------------------------------------------------------

- (void)createBlocks:(CCNode *)parentNode
{
  for (int i = 0; i < kTeamBlockNum; ++i)
  {
    Block* block = [[Block alloc] initWithTeam:kAlfa Index:i ParentMgr:self];
    [parentNode addChild:block];
    [alfaBlockList_ addObject:block];
  }
  alfaBlockNum_ = kTeamBlockNum;
  
  for (int i = 0; i < kTeamBlockNum; ++i)
  {
    Block* block = [[Block alloc] initWithTeam:kBravo Index:i ParentMgr:self];
    [parentNode addChild:block];
    [bravoBlockList_ addObject:block];
  }
  bravoBlockNum_ = kTeamBlockNum;
}

//------------------------------------------------------------------------------

- (int)alfaBlockNum
{
  return alfaBlockNum_;
}

//------------------------------------------------------------------------------

- (int)bravoBlockNum
{
  return bravoBlockNum_;
}

//------------------------------------------------------------------------------

- (int)blockNum
{
  return alfaBlockNum_ + bravoBlockNum_;
}

//------------------------------------------------------------------------------

- (int)brokenBlockNum
{
  return kTeamBlockNum * 2 - self.blockNum;
}

//------------------------------------------------------------------------------

- (void)decreaseAlfaBlockNum
{
  --alfaBlockNum_;
}

//------------------------------------------------------------------------------

- (void)decreaseBravoBlockNum
{
  --bravoBlockNum_;
}

//------------------------------------------------------------------------------
@end
