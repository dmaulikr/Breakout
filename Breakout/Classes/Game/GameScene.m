//
//  GameScene.m
//  Breakout
//
//  Created by 筒井 啓太 on 2014/06/21.
//  Copyright 2014年 keitanxkeitan. All rights reserved.
//

#import "GameScene.h"
#import "BlockMgr.h"

//------------------------------------------------------------------------------
#pragma mark - GameScene
//------------------------------------------------------------------------------

@implementation GameScene

//------------------------------------------------------------------------------
#pragma mark - Create & Destroy
//------------------------------------------------------------------------------

+ (GameScene *)scene
{
  return [[self alloc] init];
}

//------------------------------------------------------------------------------

- (id)init
{
  srand((unsigned)time(NULL));
  
  self = [super init];
  if (!self) return nil;
  
  // 背景
  CCSprite* background = [CCSprite spriteWithImageNamed:@"Background.png"];
  background.position = ccp(self.contentSize.width / 2, self.contentSize.height / 2);
  [self addChild:background];
  
  // ブロック
  blockMgr_ = [[BlockMgr alloc] init];
  [blockMgr_ createBlocks:self];
  
  return self;
}

//------------------------------------------------------------------------------

- (void)dealloc
{
  // clean up code goes here
}

//------------------------------------------------------------------------------
# pragma mark - Enter & Exit
//------------------------------------------------------------------------------

- (void)onEnter
{
  // always call super onEnter first
  [super onEnter];
}

//------------------------------------------------------------------------------

- (void)onExit
{
  // always call super onExit last
  [super onExit];
}

//------------------------------------------------------------------------------
@end
