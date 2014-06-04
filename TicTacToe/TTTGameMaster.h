//
//  GameMaster.h
//  TicTacToe
//
//  Created by David Torre on 6/1/14.
//  Copyright (c) 2014 David Torre. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TTTGame.h"

@interface TTTGameMaster : NSObject

- (BOOL)requestMoveInGame:(TTTGame *)game atLocation:(CGPoint)location;

@end
