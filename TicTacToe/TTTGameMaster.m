//
//  GameMaster.m
//  TicTacToe
//
//  Created by David Torre on 6/1/14.
//  Copyright (c) 2014 David Torre. All rights reserved.
//

#import "TTTGameMaster.h"
#import "TTTCPUPlayer.h"
#import "TTTHumanPlayer.h"
#import "TTTConstants.h"

@interface TTTGameMaster ()
@property (strong, nonatomic) TTTHumanPlayer *humanPlayer;
@property (strong, nonatomic) TTTCPUPlayer *cpuPlayer;
@end

@implementation TTTGameMaster

- (TTTHumanPlayer *)humanPlayer
{
    if (!_humanPlayer) {
        _humanPlayer = [[TTTHumanPlayer alloc] initAsPlayer:TTT_X];
    }
    return _humanPlayer;
}

- (TTTCPUPlayer *)cpuPlayer
{
    if (!_cpuPlayer) {
        _cpuPlayer = [[TTTCPUPlayer alloc] initAsPlayer:TTT_O];
    }
    return _cpuPlayer;
}

- (BOOL)requestMoveInGame:(TTTGame *)game atLocation:(CGPoint)location
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
