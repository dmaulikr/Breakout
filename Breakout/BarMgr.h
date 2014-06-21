//
//  BarMgr.h
//  Breakout
//
//  Created by 筒井 啓太 on 2014/06/21.
//  Copyright (c) 2014年 keitanxkeitan. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Bar;
@class InvisibleButton;
@class CCNode;

@interface BarMgr : NSObject
{
 @private
  Bar*              alfaBar_;
  Bar*              bravoBar_;
  InvisibleButton*  alfaRightButton_;
  InvisibleButton*  alfaLeftButton_;
  InvisibleButton*  bravoRightButton_;
  InvisibleButton*  bravoLeftButton_;
}

- (id)init;
- (void)createBars:(CCNode *)parentNode;

@end
