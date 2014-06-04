//
//  HumanPlayer.h
//  TicTacToe
//
//  Created by David Torre on 6/1/14.
//  Copyright (c) 2014 David Torre. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TTTGame.h"

@interface TTTHumanPlayer : NSObject

- (id)initAsPlayer:(NSString *)player;

- (void)makeMoveInGame:(TTTGame *)game atLocation:(CGPoint)location;

@end
