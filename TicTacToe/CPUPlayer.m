//
//  CPUPlayer.m
//  TicTacToe
//
//  Created by David Torre on 5/12/14.
//  Copyright (c) 2014 David Torre. All rights reserved.
//

#import "CPUPlayer.h"

@interface CPUPlayer ()
@property (nonatomic) CGPoint choice;
@end

@implementation CPUPlayer

- (void)makeMove:(TicTacToeGame *)game
{
    [self minMax:game];
    [game markLocation:self.choice with:@"O"];
}

- (int)minMax:(TicTacToeGame *)game
{
    if ([game isOver]) {
        return game.score;
    }
    
    NSMutableArray *moves = [[NSMutableArray alloc] init];
    NSMutableArray *scores = [[NSMutableArray alloc] init];

    for (NSValue *moveObject in [game possibleMoves]) {

        CGPoint move;
        [moveObject getValue:&move];
        
        if (game.turn == 0) {
            [game markLocation:move with:@"X"];
        } else {
            [game markLocation:move with:@"O"];
        }
        
        [game changeTurns];

        [moves addObject:moveObject];
        [scores addObject:[NSNumber numberWithInt:[self minMax:game]]];
        
        [game eraseLocation:move];
        [game changeTurns];
    }
    
    int index;
    
    if (game.turn == 0) {
        // find the maximum score's index
        NSNumber *max = scores[0];
        for (NSNumber *num in scores) {
            if ([num integerValue] > [max integerValue]) max = num;
        }
        index = (int)[scores indexOfObject:max];
    } else {
        // find the minimum score's index
        NSNumber *min = scores[0];
        for (NSNumber *num in scores) {
            if ([num integerValue] < [min integerValue]) min = num;
        }
        index = (int)[scores indexOfObject:min];
    }
    
    // find and save the min/max score's corresponding choice
    CGPoint choice;
    [moves[index] getValue:&choice];
    self.choice = choice;
    
    // return the min/max score
    return (int)[scores[index] integerValue];
}

@end
