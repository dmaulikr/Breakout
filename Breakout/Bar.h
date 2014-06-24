//
//  Bar.h
//  Breakout
//
//  Created by 筒井 啓太 on 2014/06/21.
//  Copyright 2014年 keitanxkeitan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

#import "GameDef.h"

@interface Bar : CCSprite {
 @private
  float vel_;
}

- (id)initWithTeam:(Team)team;
- (void)accRight;
- (void)accLeft;
- (float)vel;
- (float)maxVel;
- (BOOL)checkIfCriticalHit:(CGPoint)pos;

@end
