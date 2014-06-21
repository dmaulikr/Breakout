//
//  InvisibleButton.h
//  Breakout
//
//  Created by 筒井 啓太 on 2014/06/21.
//  Copyright 2014年 keitanxkeitan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@class Bar;

@interface InvisibleButton : CCNode {
 @private
  BOOL  isHold_;
  Bar*  bar_;
  BOOL  isRight_;
}

- (id)init;
- (void)setBarForRight:(Bar *)bar;
- (void)setBarForLeft:(Bar *)bar;

@end
