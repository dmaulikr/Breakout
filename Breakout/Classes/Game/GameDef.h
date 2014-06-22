//
//  GameDef.h
//  Breakout
//
//  Created by 筒井 啓太 on 2014/06/21.
//  Copyright (c) 2014年 keitanxkeitan. All rights reserved.
//

#ifndef Breakout_GameDef_h
#define Breakout_GameDef_h

typedef enum : NSInteger
{
  kAlfa,
  kBravo,
  kNum
} Team;

enum
{
  kTeamBlockRowNum = 3,
  kTeamBlockColNum = 24,
  kTeamBlockNum = kTeamBlockRowNum * kTeamBlockColNum,
};

enum
{
  kBallNum = 10,
};

extern const float kBlockWidth;
extern const float kBlockHeight;
extern const float kBarWidth;
extern const float kBarHeight;

#endif
