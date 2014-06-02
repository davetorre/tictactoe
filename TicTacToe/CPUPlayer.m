//
//  CPUPlayer.m
//  TicTacToe
//
//  Created by David Torre on 5/12/14.
//  Copyright (c) 2014 David Torre. All rights reserved.
//

#import "CPUPlayer.h"
#import "Constants.h"

@interface CPUPlayer ()
@property (nonatomic) CGPoint choice;
@property (nonatomic, strong) NSString *player;
@end

@implementation CPUPlayer

- (id)initAsPlayer:(NSString *)player
{
    self = [super init];
    
    if (self) {
        self.player = player;
    }
    
    return self;
}

- (void)switchPlayer
{
    if ([self.player isEqualToString:TTT_O]) {
        self.player = TTT_X;
    } else {
        self.player = TTT_O;
    }
}

- (void)makeMoveInGame:(TicTacToeGame *)game
{
    [self minMax:game];
    [game markLocation:self.choice with:self.player];
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
        
        [game markLocation:move with:self.player];
        
        [self switchPlayer];

        [moves addObject:moveObject];
        [scores addObject:[NSNumber numberWithInt:[self minMax:game]]];
        
        [game eraseLocation:move];
        [self switchPlayer];
    }
    
    int index;
    
    if ([self.player isEqualToString:TTT_X]) {
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
