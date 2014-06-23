//
//  GameScene.m
//  Breakout
//
//  Created by 筒井 啓太 on 2014/06/21.
//  Copyright 2014年 keitanxkeitan. All rights reserved.
//

#import "GameScene.h"
#import "BlockMgr.h"
#import "BallMgr.h"
#import "Ball.h"
#import "BarMgr.h"
#import "Field.h"
#import "GameDef.h"

#import "OALSimpleAudio.h"

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
  
  // サウンド
  [[OALSimpleAudio sharedInstance] preloadBg:@"Bgm.mp3"];
  [[OALSimpleAudio sharedInstance] preloadEffect:@"Bar.mp3"];
  [[OALSimpleAudio sharedInstance] preloadEffect:@"Block.mp3"];
  [[OALSimpleAudio sharedInstance] preloadEffect:@"Fanfare.mp3"];
  [[OALSimpleAudio sharedInstance] preloadEffect:@"Ready.mp3"];
  
  // 物理
  physicsNode_ = [CCPhysicsNode node];
  physicsNode_.gravity = ccp(0.f, 0.f);
//  physicsNode_.debugDraw = YES;
  physicsNode_.collisionDelegate = self;
  [self addChild:physicsNode_];
  
  // 背景
  CCSprite* background = [CCSprite spriteWithImageNamed:@"Background.png"];
  background.position = ccp(self.contentSize.width / 2, self.contentSize.height / 2);
  [physicsNode_ addChild:background];
  
  // リセットボタン
  resetButton0_ = [CCButton buttonWithTitle:@"[Reset]" fontName:@"Verdana-Bold" fontSize:18.f];
  resetButton0_.positionType = CCPositionTypeNormalized;
  resetButton0_.position = ccp(0.5f, 0.04f);
  [resetButton0_ setTarget:self selector:@selector(onResetButtonClicked:)];
  [self addChild:resetButton0_];
  
  resetButton1_ = [CCButton buttonWithTitle:@"[Reset]" fontName:@"Verdana-Bold" fontSize:18.f];
  resetButton1_.positionType = CCPositionTypeNormalized;
  resetButton1_.position = ccp(0.5f, 0.96f);
  resetButton1_.rotation = 180.f;
  [resetButton1_ setTarget:self selector:@selector(onResetButtonClicked:)];
  [self addChild:resetButton1_];
  
  // 左右ラベル
  CCLabelTTF* alfaRight = [CCLabelTTF labelWithString:@">>" fontName:@"Verdana-Bold" fontSize:18.f];
  alfaRight.positionType = CCPositionTypeNormalized;
  alfaRight.position = ccp(0.9f, 0.04f);
  [self addChild:alfaRight];
  CCLabelTTF* alfaLeft = [CCLabelTTF labelWithString:@"<<" fontName:@"Verdana-Bold" fontSize:18.f];
  alfaLeft.positionType = CCPositionTypeNormalized;
  alfaLeft.position = ccp(0.1f, 0.04f);
  [self addChild:alfaLeft];
  CCLabelTTF* bravoRight = [CCLabelTTF labelWithString:@">>" fontName:@"Verdana-Bold" fontSize:18.f];
  bravoRight.positionType = CCPositionTypeNormalized;
  bravoRight.position = ccp(0.9f, 0.96f);
  [self addChild:bravoRight];
  CCLabelTTF* bravoLeft = [CCLabelTTF labelWithString:@"<<" fontName:@"Verdana-Bold" fontSize:18.f];
  bravoLeft.positionType = CCPositionTypeNormalized;
  bravoLeft.position = ccp(0.1f, 0.96f);
  [self addChild:bravoLeft];

  // メインフィールド
  field_ = [[Field alloc] init];
  [field_ createField:physicsNode_];
  
  // ブロック
  blockMgr_ = [[BlockMgr alloc] init];
  [blockMgr_ createBlocks:physicsNode_];
  
  // ボール
  ballMgr_ = [[BallMgr alloc] init];
  [ballMgr_ createBalls];
  
  // バー
  barMgr_ = [[BarMgr alloc] init];
  [barMgr_ createBars:physicsNode_];
  
  hasWave2Done_ = NO;
  hasWave3Done_ = NO;
  isFinished_ = NO;
  
  elapsedTimme_ = 0.f;
  
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

- (void)update:(CCTime)delta
{
  if (!hasWave2Done_)
  {
    if (blockMgr_.brokenBlockNum >= 30)
    {
      [ballMgr_ activateAndInitializeTwo:physicsNode_];
      hasWave2Done_ = YES;
    }
  }
  
  if (!hasWave3Done_)
  {
    if (blockMgr_.brokenBlockNum >= 90)
    {
      [ballMgr_ activateAndInitializeFour:physicsNode_];
      hasWave3Done_ = YES;
    }
  }
  
  if (!isFinished_)
  {
    BOOL isAlfaLose = NO;
    BOOL isBravoLose = NO;
    if (blockMgr_.alfaBlockNum == 0)
    {
      isAlfaLose = YES;
    }
    if (blockMgr_.bravoBlockNum == 0)
    {
      isBravoLose = YES;
    }
  
    if (isAlfaLose || isBravoLose)
    {
      [ballMgr_ fadeAll];
      
      NSString* alfaString;
      NSString* bravoString;
      
      if (isAlfaLose && !isBravoLose)
      {
        // Bravo の勝ち
        alfaString = @"You Lose";
        bravoString = @"You Win";
      }
      else if (!isAlfaLose && isBravoLose)
      {
        // Alfa の勝ち
        alfaString = @"You Win";
        bravoString = @"You Lose";
      }
      else
      {
        // 引き分け
        alfaString = @"Draw";
        bravoString = @"Draw";
      }
      
      CCLabelTTF* alfaLabel = [CCLabelTTF labelWithString:alfaString fontName:@"Verdana-Bold" fontSize:24.f];
      alfaLabel.positionType = CCPositionTypeNormalized;
      alfaLabel.position = ccp(0.5f, 0.3f);
      [self addChild:alfaLabel];
      CCLabelTTF* bravoLabel = [CCLabelTTF labelWithString:bravoString fontName:@"Verdana-Bold" fontSize:24.f];
      bravoLabel.positionType = CCPositionTypeNormalized;
      bravoLabel.position = ccp(0.5f, 0.7f);
      bravoLabel.rotation = 180.f;
      [self addChild:bravoLabel];
      
      isFinished_ = YES;

      [[OALSimpleAudio sharedInstance] stopBg];
      [[OALSimpleAudio sharedInstance] playEffect:@"Fanfare.mp3"];
    }
  }
  
  if (elapsedTimme_ < 5.f)
  {
    if (elapsedTimme_ < 1.f)
    {
      if (!countLabel0_)
      {
        countLabel0_ = [CCLabelTTF labelWithString:@"Ready" fontName:@"Verdana-Bold" fontSize:18.f];
        countLabel0_.positionType = CCPositionTypeNormalized;
        countLabel0_.position = ccp(0.5f, 0.3f);
        [self addChild:countLabel0_];
        
        countLabel1_ = [CCLabelTTF labelWithString:@"Ready" fontName:@"Verdana-Bold" fontSize:18.f];
        countLabel1_.positionType = CCPositionTypeNormalized;
        countLabel1_.position = ccp(0.5f, 0.7f);
        countLabel1_.rotation = 180.f;
        [self addChild:countLabel1_];
        
        [[OALSimpleAudio sharedInstance] playEffect:@"Ready.mp3"];
      }
    }
    else if (elapsedTimme_ < 2.f)
    {
      if (![countLabel0_.string isEqualToString:@"3"])
      {
        countLabel0_.string = @"3";
        countLabel1_.string = @"3";
      }
    }
    else if (elapsedTimme_ < 3.f)
    {
      if (![countLabel0_.string isEqualToString:@"2"])
      {
        countLabel0_.string = @"2";
        countLabel1_.string = @"2";
      }
    }
    else if (elapsedTimme_ < 4.f)
    {
      if (![countLabel0_.string isEqualToString:@"1"])
      {
        countLabel0_.string = @"1";
        countLabel1_.string = @"1";
      }
    }
    else
    {
      if (![countLabel0_.string isEqualToString:@"Go!"])
      {
        countLabel0_.string = @"Go!";
        countLabel1_.string = @"Go!";
        [ballMgr_ activateAndInitializeTwo:physicsNode_];
        
        [[OALSimpleAudio sharedInstance] playBg:@"Bgm.mp3" loop:YES];
      }
    }
  }
  else
  {
    if (countLabel0_.parent)
    {
      [countLabel0_ removeFromParent];
      [countLabel1_ removeFromParent];
    }
  }
  
  elapsedTimme_ += delta;
}

//------------------------------------------------------------------------------

- (BOOL)ccPhysicsCollisionBegin:(CCPhysicsCollisionPair *)pair Ball:(CCNode *)nodeA Ball:(CCNode *)nodeB
{
  Ball* ball = (Ball*)nodeA;
  [ball informCollisionBegin:pair Node:nodeB];
  return YES;
}

//------------------------------------------------------------------------------

- (BOOL)ccPhysicsCollisionBegin:(CCPhysicsCollisionPair *)pair Ball:(CCNode *)nodeA Block:(CCNode *)nodeB
{
  Ball* ball = (Ball*)nodeA;
  [ball informCollisionBegin:pair Node:nodeB];
  [[OALSimpleAudio sharedInstance] playEffect:@"Block.mp3"];
  return YES;
}

//------------------------------------------------------------------------------

- (BOOL)ccPhysicsCollisionBegin:(CCPhysicsCollisionPair *)pair Ball:(CCNode *)nodeA Background:(CCNode *)nodeB
{
  Ball* ball = (Ball*)nodeA;
  [ball informCollisionBegin:pair Node:nodeB];
  return YES;
}

//------------------------------------------------------------------------------

- (BOOL)ccPhysicsCollisionBegin:(CCPhysicsCollisionPair *)pair Ball:(CCNode *)nodeA Bar:(CCNode *)nodeB
{
  Ball* ball = (Ball*)nodeA;
  [ball informCollisionBegin:pair Node:nodeB];
  [[OALSimpleAudio sharedInstance] playEffect:@"Bar.mp3"];
  return YES;
}

//------------------------------------------------------------------------------

- (void)onResetButtonClicked:(id)sender
{
  [[CCDirector sharedDirector] replaceScene:[GameScene scene] withTransition:[CCTransition transitionFadeWithDuration:0.5f]];
}

//------------------------------------------------------------------------------
@end
