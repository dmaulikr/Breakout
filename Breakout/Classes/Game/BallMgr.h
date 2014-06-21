//
//  BallMgr.h
//  Breakout
//
//  Created by 筒井 啓太 on 2014/06/21.
//  Copyright (c) 2014年 keitanxkeitan. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CCNode;
@class Ball;

@interface BallMgr : NSObject
{
 @private
  NSMutableArray* ballList_;
}

- (id)init;
- (void)createBalls;
- (Ball *)activateOne:(CCNode *)parentNode;

@end
