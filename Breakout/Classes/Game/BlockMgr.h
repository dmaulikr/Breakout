//
//  BlockMgr.h
//  Breakout
//
//  Created by 筒井 啓太 on 2014/06/21.
//  Copyright (c) 2014年 keitanxkeitan. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CCNode;

@interface BlockMgr : NSObject
{
 @private
  NSMutableArray* alfaBlockList_;
  NSMutableArray* bravoBlockList_;
  int             alfaBlockNum_;
  int             bravoBlockNum_;
}

- (id)init;
- (void)createBlocks:(CCNode *)parentNode;
- (int)alfaBlockNum;
- (int)bravoBlockNum;
- (int)blockNum;
- (int)brokenBlockNum;
- (void)decreaseAlfaBlockNum;
- (void)decreaseBravoBlockNum;

@end
