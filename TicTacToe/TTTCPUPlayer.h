//
//  CPUPlayer.h
//  TicTacToe
//
//  Created by David Torre on 5/12/14.
//  Copyright (c) 2014 David Torre. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TTTGame.h"

@interface TTTCPUPlayer : NSObject

- (id)initAsPlayer:(NSString *)player;

- (void)makeMoveInGame:(TTTGame *)game;

@end
