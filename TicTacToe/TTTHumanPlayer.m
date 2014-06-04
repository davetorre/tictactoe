//
//  HumanPlayer.m
//  TicTacToe
//
//  Created by David Torre on 6/1/14.
//  Copyright (c) 2014 David Torre. All rights reserved.
//

#import "TTTHumanPlayer.h"

@interface TTTHumanPlayer ()
@property (nonatomic, strong) NSString *player;
@end

@implementation TTTHumanPlayer

- (id)initAsPlayer:(NSString *)player
{
    self = [super init];
    
    if (self) {
        self.player = player;
    }
    
    return self;
}

- (void)makeMoveInGame:(TTTGame *)game atLocation:(CGPoint)location
{
    [game markLocation:location with:self.player];
}

@end
