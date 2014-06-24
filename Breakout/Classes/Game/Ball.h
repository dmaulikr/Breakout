//
//  Ball.h
//  Breakout
//
//  Created by 筒井 啓太 on 2014/06/21.
//  Copyright 2014年 keitanxkeitan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface Ball : CCSprite {
 @private
  CGPoint         vel_;
  CGPoint         velOffset_;
  float           rotVelDeg_;
  BOOL            isFadeRequest_;
  CCMotionStreak* motionStreak_;
  float           boostRate_;
}

- (id)init;
- (void)initialize:(CGPoint)pos Vel:(CGPoint)vel;
- (void)informCollisionBegin:(CCPhysicsCollisionPair *)pair Node:(CCNode *)node;
- (void)fade;
- (CCMotionStreak *)motionStreak;

@end
