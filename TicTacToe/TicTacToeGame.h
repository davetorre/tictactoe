//
//  TicTacToeGame.h
//  TicTacToe
//
//  Created by David Torre on 5/12/14.
//  Copyright (c) 2014 David Torre. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TicTacToeGame : NSObject

@property (nonatomic) int numRows;
@property (nonatomic) int numColumns;
@property (nonatomic) int score;
@property (nonatomic) int turn; // 0 is 'X', 1 is 'O'

- (id)initWithRows:(int)rows columns:(int)columns turn:(int)turn;

- (NSString *)playerAtLocation:(CGPoint)location;

- (void)markLocation:(CGPoint)location with:(NSString *)player;

- (void)eraseLocation:(CGPoint)location;

- (NSMutableArray *)possibleMoves;

- (BOOL)isOver;

- (void)changeTurns;

- (void)shiftRight;

@end
