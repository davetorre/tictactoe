//
//  CPUPlayerTests.m
//  TicTacToe
//
//  Created by David Torre on 6/2/14.
//  Copyright (c) 2014 David Torre. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "TTTGame.h"
#import "TTTCPUPlayer.h"
#import "TTTConstants.h"

@interface CPUPlayerTests : XCTestCase

@end

@implementation CPUPlayerTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (TTTGame *)playTwoCPUPlayerGame:(TTTGame *)game
{
    TTTCPUPlayer *player1 = [[TTTCPUPlayer alloc] initAsPlayer:TTT_X];
    TTTCPUPlayer *player2 = [[TTTCPUPlayer alloc] initAsPlayer:TTT_O];
    
    int turn = 1;
    
    while (![game isOver]) {
        if (turn == 1) {
            [player1 makeMoveInGame:game];
            turn = 2;
        } else {
            [player2 makeMoveInGame:game];
            turn = 1;
        }
    }
    
    return game;
}

- (void)testTwoCPUPlayersShouldTie
{
    TTTGame *game = [[TTTGame alloc] initWithRows:3 columns:3];
    
    game = [self playTwoCPUPlayerGame:game];
    
    XCTAssertEqual(game.score, 0, @"Two CPUPlayers should tie.");
    XCTAssertEqual([[game possibleMoves] count], 0, @"Board should be full.");
}

- (void)testIfCPUPlayer2PlaysEdgeCPUPlayer1ShouldWin
{
    TTTGame *game = [[TTTGame alloc] initWithRows:3 columns:3];
    
    CGPoint topLeftCorner = CGPointMake(0, 0);
    CGPoint leftEdge = CGPointMake(1, 0);
    
    [game markLocation:topLeftCorner with:TTT_X];
    [game markLocation:leftEdge with:TTT_O];
    
    game = [self playTwoCPUPlayerGame:game];
    
    XCTAssertEqual(game.score, 10, @"CPUPlayer1 should win.");
}

@end
