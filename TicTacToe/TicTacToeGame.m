//
//  TicTacToeGame.m
//  TicTacToe
//
//  Created by David Torre on 5/12/14.
//  Copyright (c) 2014 David Torre. All rights reserved.
//

#import "TicTacToeGame.h"
#import "Constants.h"

@interface TicTacToeGame ()
@property (strong, nonatomic) NSMutableArray *board;
@end

@implementation TicTacToeGame

- (id)initWithRows:(int)rows columns:(int)columns
{
    self = [super init];
    
    if (self) {
        self.numRows = rows;
        self.numColumns = columns;
    }
    
    return self;
}

- (NSMutableArray *)board
{
    if (!_board) {
        _board = [[NSMutableArray alloc] initWithCapacity:self.numRows];
        
        for (int x = 0; x < self.numRows; x++) {
            _board[x] = [[NSMutableArray alloc] initWithCapacity:self.numColumns];
            for (int y = 0; y < self.numColumns; y++) {
                _board[x][y] = TTT_EMPTY;
            }
        }
    }
    return _board;
}

- (NSString *)playerAtLocation:(CGPoint)location
{
    return self.board[(int)location.x][(int)location.y];;
}

- (void)markLocation:(CGPoint)location with:(NSString *)player
{
    self.board[(int)location.x][(int)location.y] = player;
}

- (void)eraseLocation:(CGPoint)location
{
    self.board[(int)location.x][(int)location.y] = TTT_EMPTY;
}

- (NSMutableArray *)possibleMoves
{
    NSMutableArray *locations = [[NSMutableArray alloc] init];
    for (int x = 0; x < 3; x++) {
        for (int y = 0; y < 3; y++) {
            if ([self.board[x][y] isEqualToString:TTT_EMPTY]) {
                CGPoint location = CGPointMake(x, y);
                NSValue *locationObject = [NSValue value:&location
                                             withObjCType:@encode(CGPoint)];
                [locations addObject:locationObject];
            }
        }
    }
    return locations;
}

- (BOOL)hasDiagonals
{
    return ((self.numRows == self.numColumns) && (self.numRows % 2 == 1));
}

- (NSArray *)winningLines
{
    NSMutableArray *winningLines = [[NSMutableArray alloc] init];
    
    // winning rows
    for (int row = 0; row < self.numRows; row++) {
        [winningLines addObject:self.board[row]];
    }
    
    // winning columns
    for (int column = 0; column < self.numColumns; column++) {
        NSMutableArray *winningColumn = [[NSMutableArray alloc] init];
        for (int row = 0; row < self.numRows; row++) {
            [winningColumn addObject:self.board[row][column]];
        }
        [winningLines addObject:winningColumn];
    }
    
    // winning diagonals
    if ([self hasDiagonals]) {
        NSMutableArray *winningDiagonal1 = [[NSMutableArray alloc] init];
        NSMutableArray *winningDiagonal2 = [[NSMutableArray alloc] init];
        for (int row = 0; row < self.numRows; row++) {
            [winningDiagonal1 addObject:self.board[row][row]];
            [winningDiagonal2 addObject:self.board[row][self.numColumns - 1 - row]];
        }
        [winningLines addObject:winningDiagonal1];
        [winningLines addObject:winningDiagonal2];
    }
    
    return winningLines;
}

- (BOOL)isOver
{
    for (NSArray *line in [self winningLines]) {
        int xCount = 0;
        int oCount = 0;
        
        for (int i = 0; i < [line count]; i++) {
            if ([line[i] isEqualToString:TTT_X]) xCount++;
            if ([line[i] isEqualToString:TTT_O]) oCount++;
        }
        if (xCount == [line count]) {
            self.score = 10;
            return TRUE;
        }
        if (oCount == [line count]) {
            self.score = -10;
            return TRUE;
        }
    }
    
    if (![[self possibleMoves] count]) {
        self.score = 0;
        return TRUE;
    } else {
        return FALSE;
    }
}

- (void)shiftRight
{
    for (int row = 0; row < self.numRows; row++) {
        NSString *lastObject = self.board[row][self.numColumns - 1];
        for (int column = self.numColumns - 1; column > 0; column--) {
            self.board[row][column] = self.board[row][column - 1];
        }
        self.board[row][0] = lastObject;
    }
}

@end
