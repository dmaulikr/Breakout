//
//  Block.m
//  Breakout
//
//  Created by 筒井 啓太 on 2014/06/21.
//  Copyright 2014年 keitanxkeitan. All rights reserved.
//

#import "Block.h"
#import "BlockMgr.h"


@implementation Block

//------------------------------------------------------------------------------

const float kBlockWidth = 32.f;
const float kBlockHeight = 20.f;

//------------------------------------------------------------------------------

- (id)initWithTeam:(Team)team Index:(int)index ParentMgr:(BlockMgr *)parentMgr;
{
  const int type = rand() % kTypeNum;
  
  self = [super initWithImageNamed:@"Block.png"];
  if (!self) return nil;
  
  team_ = team;
  index_ = index;
  type_ = type;
  isFadeRequest_ = NO;
  parentMgr_ = parentMgr;
  self.position = [self calcPos:team_ Index:index_];
  if (team == kBravo) self.rotation = 180.f;
  self.color = [self typeToColor:type];
  
  // 物理
  self.physicsBody = [CCPhysicsBody bodyWithRect:self.spriteFrame.rect cornerRadius:0.f];
  self.physicsBody.collisionType = @"Block";
  self.physicsBody.type = CCPhysicsBodyTypeStatic;
  
  return self;
}

//------------------------------------------------------------------------------

- (void)fade
{
  if (isFadeRequest_)
  {
    return;
  }
  
  isFadeRequest_ = YES;
  
  const CCActionFadeOut* fadeOut = [CCActionFadeOut actionWithDuration:0.25f];
  const CCActionRemove* remove = [CCActionRemove action];
  [self runAction:[CCActionSequence actionWithArray:@[fadeOut, remove]]];
  
  if (team_ == kAlfa) [parentMgr_ decreaseAlfaBlockNum];
  else [parentMgr_ decreaseBravoBlockNum];
}

//------------------------------------------------------------------------------

- (CGPoint)calcPos:(Team)team Index:(int)index
{
  const int row = index / kTeamBlockColNum;
  const int col = index % kTeamBlockColNum;
  
  const CGPoint offset = (team == kAlfa) ?
                         ccp(kBlockWidth, -kBlockHeight) :
                         ccp(-kBlockWidth, kBlockHeight);
  
  const CGSize size = [[CCDirector sharedDirector] viewSize];
  
  const CGPoint basePos = (team == kAlfa) ?
                          ccp(kBlockWidth * 0.5f, kBlockHeight * (kTeamBlockRowNum - 0.5f) + kMarginBottomTop) :
                          ccp(size.width - (kBlockWidth * 0.5f), size.height - (kBlockHeight * (kTeamBlockRowNum - 0.5f) + kMarginBottomTop));
  
  CGPoint pos = basePos;
  pos.x += offset.x * col;
  pos.y += offset.y * row;
  
  return pos;
}

//------------------------------------------------------------------------------

- (void)update:(CCTime)delta
{
}

//------------------------------------------------------------------------------

- (CCColor *)typeToColor:(int)type
{
  switch (type) {
    case 0: return [CCColor colorWithCcColor3b:ccc3(46, 204, 113)];
    case 1: return [CCColor colorWithCcColor3b:ccc3(52, 152, 219)];
    case 2: return [CCColor colorWithCcColor3b:ccc3(155, 89, 182)];
    case 3: return [CCColor colorWithCcColor3b:ccc3(241, 196, 15)];
    case 4: return [CCColor colorWithCcColor3b:ccc3(230, 126, 34)];
    case 5: return [CCColor colorWithCcColor3b:ccc3(231, 76, 60)];
    default: return [CCColor whiteColor];
  }
}

//------------------------------------------------------------------------------
@end
