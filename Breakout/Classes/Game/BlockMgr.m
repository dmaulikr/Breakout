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
  
  return self;
}

//------------------------------------------------------------------------------

- (void)createBlocks:(CCScene *)scene
{
  for (int i = 0; i < kTeamBlockNum; ++i)
  {
    Block* block = [[Block alloc] initWithTeam:kAlfa Index:i];
    [scene addChild:block];
    [alfaBlockList_ addObject:block];
  }
  
  for (int i = 0; i < kTeamBlockNum; ++i)
  {
    Block* block = [[Block alloc] initWithTeam:kBravo Index:i];
    [scene addChild:block];
    [bravoBlockList_ addObject:block];
  }
}

//------------------------------------------------------------------------------
@end
