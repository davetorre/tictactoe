//
//  TicTacToeGame.m
//  TicTacToe
//
//  Created by David Torre on 5/12/14.
//  Copyright (c) 2014 David Torre. All rights reserved.
//

#import "TicTacToeGame.h"
@interface TicTacToeGame ()
@property (strong, nonatomic) NSMutableArray *board;
@end

@implementation TicTacToeGame

- (id)initWithRows:(int)rows columns:(int)columns turn:(int)turn
{
    self = [super init];
    
    if (self) {
        self.numRows = rows;
        self.numColumns = columns;
        self.turn = turn;
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
                _board[x][y] = @" ";
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
    self.board[(int)location.x][(int)location.y] = @" ";
}

- (NSMutableArray *)possibleMoves
{
    NSMutableArray *locations = [[NSMutableArray alloc] init];
    for (int x = 0; x < 3; x++) {
        for (int y = 0; y < 3; y++) {
            if ([self.board[x][y] isEqualToString:@" "]) {
                CGPoint location = CGPointMake(x, y);
                NSValue *locationObject = [NSValue value:&location
                                             withObjCType:@encode(CGPoint)];
                [locations addObject:locationObject];
            }
        }
    }
    return locations;
}

- (NSArray *)winningLines
{
    return @[@[self.board[0][0], self.board[0][1], self.board[0][2]],
             @[self.board[1][0], self.board[1][1], self.board[1][2]],
             @[self.board[2][0], self.board[2][1], self.board[2][2]],
             @[self.board[0][0], self.board[1][0], self.board[2][0]],
             @[self.board[0][1], self.board[1][1], self.board[2][1]],
             @[self.board[0][2], self.board[1][2], self.board[2][2]],
             @[self.board[0][0], self.board[1][1], self.board[2][2]],
             @[self.board[0][2], self.board[1][1], self.board[2][0]]];
}

- (BOOL)isOver
{
    for (NSArray *line in [self winningLines]) {
        int xCount = 0;
        int oCount = 0;
        
        for (int i = 0; i < 3; i++) {
            if ([line[i] isEqualToString:@"X"]) xCount++;
            if ([line[i] isEqualToString:@"O"]) oCount++;
        }
        if (xCount == 3) {
            self.score = 10;
            return TRUE;
        }
        if (oCount == 3) {
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

- (void)changeTurns
{
    if (self.turn == 0) {
        self.turn = 1;
    } else {
        self.turn = 0;
    }
}

@end
