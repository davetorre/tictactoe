//
//  TicTacToeGameTests.m
//  TicTacToe
//
//  Created by David Torre on 6/2/14.
//  Copyright (c) 2014 David Torre. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "TTTGame.h"
#import "TTTConstants.h"

@interface GameTests : XCTestCase
@property (strong, nonatomic) TTTGame *game;
@end

@implementation GameTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.game = [[TTTGame alloc] initWithRows:3 columns:3];
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)fillGame:(TTTGame *)game withMoves:(NSArray *)moves
{
    int i = 0;
    
    for (int row = 0; row < game.numRows; row++) {
        for (int column = 0; column < game.numColumns; column++) {
            [game markLocation:CGPointMake(row, column) with:moves[i]];
            i++;
        }
    }
}

- (void)testPossibleMoves
{
    NSArray *moves = @[TTT_X, TTT_O, TTT_X,
                       TTT_X, TTT_O, TTT_O,
                       TTT_O, TTT_X, TTT_EMPTY];
    
    CGPoint emptySpace = CGPointMake(2, 2);
    
    [self fillGame:self.game withMoves:moves];

    NSArray *possibleMoves = [self.game possibleMoves];
    XCTAssertEqual([possibleMoves count], 1, @"There should be one possible move.");
   
    NSValue *moveObject = possibleMoves[0];
    CGPoint move;
    [moveObject getValue:&move];
    XCTAssertTrue([self.game playerAtLocation:move] == [self.game playerAtLocation:emptySpace],
                  @"Possible move should be correct.");
}

- (void)testGameIsOverDraw
{
    NSArray *moves = @[TTT_X, TTT_O, TTT_X,
                       TTT_X, TTT_O, TTT_O,
                       TTT_O, TTT_X, TTT_X];
    
    [self fillGame:self.game withMoves:moves];
    
    XCTAssertTrue([self.game isOver], @"Drawn game should be over.");
    XCTAssertEqual(self.game.score, 0, @"Score for drawn game should be 0.");
}

- (void)testGameIsOverXWins
{
    NSArray *moves = @[TTT_X, TTT_O, TTT_X,
                       TTT_X, TTT_X, TTT_O,
                       TTT_O, TTT_O, TTT_X];
    
    [self fillGame:self.game withMoves:moves];
    
    XCTAssertTrue([self.game isOver], @"X-won game should be over.");
    XCTAssertEqual(self.game.score, 10, @"Score for X-won game should be 10.");
}

- (void)testGameIsNotYetOver
{
    NSArray *moves = @[TTT_X, TTT_O, TTT_X,
                       TTT_X, TTT_O, TTT_O,
                       TTT_O, TTT_X, TTT_EMPTY];
    
    [self fillGame:self.game withMoves:moves];
    
    XCTAssertFalse([self.game isOver], @"Game with empty locations should not be over.");
}

- (void)testShiftRight
{
    NSArray *moves = @[TTT_X, TTT_O, TTT_X,
                       TTT_X, TTT_O, TTT_O,
                       TTT_O, TTT_X, TTT_EMPTY];
    
    [self fillGame:self.game withMoves:moves];
    
    [self.game shiftRight];
    
    NSMutableArray *expected = [@[@[TTT_X, TTT_X, TTT_O],
                                  @[TTT_O, TTT_X, TTT_O],
                                  @[TTT_EMPTY, TTT_O, TTT_X]] mutableCopy];
    
    XCTAssertTrue([self.game.board isEqualToArray:expected], @"Shift right should work.");
}

@end
