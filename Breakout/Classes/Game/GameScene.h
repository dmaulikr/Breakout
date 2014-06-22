//
//  GameScene.h
//  Breakout
//
//  Created by 筒井 啓太 on 2014/06/21.
//  Copyright 2014年 keitanxkeitan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "cocos2d-ui.h"

@class BlockMgr;
@class BallMgr;
@class BarMgr;
@class Field;

@interface GameScene : CCScene <CCPhysicsCollisionDelegate> {
 @private
  BlockMgr*       blockMgr_;
  BallMgr*        ballMgr_;
  BarMgr*         barMgr_;
  Field*          field_;
  CCPhysicsNode*  physicsNode_;
  BOOL            hasWave2Done_;
  BOOL            hasWave3Done_;
  BOOL            isFinished_;
  CCButton*       resetButton0_;
  CCButton*       resetButton1_;
  CCTime          elapsedTimme_;
  CCLabelTTF*     countLabel0_;
  CCLabelTTF*     countLabel1_;
}

+ (GameScene *)scene;
- (id)init;

@end
