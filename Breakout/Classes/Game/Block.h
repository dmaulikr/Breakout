//
//  Block.h
//  Breakout
//
//  Created by 筒井 啓太 on 2014/06/21.
//  Copyright 2014年 keitanxkeitan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

#import "GameDef.h"

@class BlockMgr;

@interface Block : CCSprite {
 @private
  enum
  {
    kTypeNum  = 6,
  };
  
  Team      team_;
  int       index_;
  int       type_;
  BOOL      isFadeRequest_;
  BlockMgr* parentMgr_;
}

- (id)initWithTeam:(Team)team Index:(int)index ParentMgr:(BlockMgr *)parentMgr;
- (void)fade;

@end
