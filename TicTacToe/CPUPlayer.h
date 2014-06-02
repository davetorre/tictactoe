//
//  CPUPlayer.h
//  TicTacToe
//
//  Created by David Torre on 5/12/14.
//  Copyright (c) 2014 David Torre. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TicTacToeGame.h"

@interface CPUPlayer : NSObject

- (id)initAsPlayer:(NSString *)player;

- (void)makeMoveInGame:(TicTacToeGame *)game;

@end
