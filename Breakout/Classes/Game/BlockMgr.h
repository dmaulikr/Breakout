//
//  BlockMgr.h
//  Breakout
//
//  Created by 筒井 啓太 on 2014/06/21.
//  Copyright (c) 2014年 keitanxkeitan. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CCScene;

@interface BlockMgr : NSObject
{
 @private
  NSMutableArray*  alfaBlockList_;
  NSMutableArray*  bravoBlockList_;
}

- (id)init;
- (void)createBlocks:(CCScene *)scene;

@end
