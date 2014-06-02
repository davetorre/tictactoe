//
//  HumanPlayer.h
//  TicTacToe
//
//  Created by David Torre on 6/1/14.
//  Copyright (c) 2014 David Torre. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TicTacToeGame.h"

@interface HumanPlayer : NSObject

- (id)initAsPlayer:(NSString *)player;

- (void)makeMoveInGame:(TicTacToeGame *)game atLocation:(CGPoint)location;

@end
