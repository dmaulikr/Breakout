//
//  GameScene.h
//  Breakout
//
//  Created by 筒井 啓太 on 2014/06/21.
//  Copyright 2014年 keitanxkeitan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@class BlockMgr;
@class BallMgr;
@class BarMgr;

@interface GameScene : CCScene <CCPhysicsCollisionDelegate> {
 @private
  BlockMgr*       blockMgr_;
  BallMgr*        ballMgr_;
  BarMgr*         barMgr_;
  CCPhysicsNode*  physicsNode_;
}

+ (GameScene *)scene;
- (id)init;

@end
