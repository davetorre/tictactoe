//
//  GameMaster.m
//  TicTacToe
//
//  Created by David Torre on 6/1/14.
//  Copyright (c) 2014 David Torre. All rights reserved.
//

#import "GameMaster.h"
#import "CPUPlayer.h"
#import "HumanPlayer.h"
#import "Constants.h"

@interface GameMaster ()
@property (strong, nonatomic) HumanPlayer *humanPlayer;
@property (strong, nonatomic) CPUPlayer *cpuPlayer;
@end

@implementation GameMaster

- (HumanPlayer *)humanPlayer
{
    if (!_humanPlayer) {
        _humanPlayer = [[HumanPlayer alloc] initAsPlayer:TTT_X];
    }
    return _humanPlayer;
}

- (CPUPlayer *)cpuPlayer
{
    if (!_cpuPlayer) {
        _cpuPlayer = [[CPUPlayer alloc] initAsPlayer:TTT_O];
    }
    return _cpuPlayer;
}

- (BOOL)requestMoveInGame:(TicTacToeGame *)game atLocation:(CGPoint)location
{
    if (![game isOver] && [[game playerAtLocation:location] isEqualToString:TTT_EMPTY]) {
        
        [self.humanPlayer makeMoveInGame:game atLocation:location];
        
        if (![game isOver]) {
            [self.cpuPlayer makeMoveInGame:game];
        }
        
        return TRUE;
    } else {
        return FALSE;
    }
}

@end
