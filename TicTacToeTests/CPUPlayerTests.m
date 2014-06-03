//
//  CPUPlayerTests.m
//  TicTacToe
//
//  Created by David Torre on 6/2/14.
//  Copyright (c) 2014 David Torre. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "TicTacToeGame.h"
#import "CPUPlayer.h"
#import "Constants.h"

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

- (void)testTwoCPUPlayersShouldTie
{
    TicTacToeGame *game = [[TicTacToeGame alloc] initWithRows:3 columns:3];
    CPUPlayer *player1 = [[CPUPlayer alloc] initAsPlayer:TTT_X];
    CPUPlayer *player2 = [[CPUPlayer alloc] initAsPlayer:TTT_O];
    
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
    
    XCTAssertEqual(game.score, 0, @"Two CPUPlayers should tie.");
    XCTAssertEqual([[game possibleMoves] count], 0, @"Board should be full.");
}

- (void)testIfCPUPlayer2PlaysEdgeCPUPlayer1ShouldWin
{
    TicTacToeGame *game = [[TicTacToeGame alloc] initWithRows:3 columns:3];
    CPUPlayer *player1 = [[CPUPlayer alloc] initAsPlayer:TTT_X];
    CPUPlayer *player2 = [[CPUPlayer alloc] initAsPlayer:TTT_O];
    
    CGPoint topLeftCorner = CGPointMake(0, 0);
    CGPoint leftEdge = CGPointMake(1, 0);
    
    [game markLocation:topLeftCorner with:TTT_X];
    [game markLocation:leftEdge with:TTT_O];
    
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
    
    XCTAssertEqual(game.score, 10, @"CPUPlayer1 should win.");
}

@end
