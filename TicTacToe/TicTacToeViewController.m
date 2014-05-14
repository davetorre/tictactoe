//
//  TicTacToeViewController.m
//  TicTacToe
//
//  Created by David Torre on 5/12/14.
//  Copyright (c) 2014 David Torre. All rights reserved.
//

#import "TicTacToeViewController.h"
#import "TicTacToeGame.h"
#import "CPUPlayer.h"

@interface TicTacToeViewController()
@property (strong, nonatomic) TicTacToeGame *game;
@property (strong, nonatomic) CPUPlayer *cpuPlayer;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *locationButtons;

@end

@implementation TicTacToeViewController

static const int NUM_ROWS = 3;
static const int NUM_COLUMNS = 3;
static const int TURN = 0; // User goes first.

- (TicTacToeGame *)game
{
    if (!_game) {
        _game = [[TicTacToeGame alloc] initWithRows:NUM_ROWS columns:NUM_COLUMNS turn:TURN];
    }
    return _game;
}

- (CPUPlayer *)cpuPlayer
{
    if (!_cpuPlayer) {
        _cpuPlayer = [[CPUPlayer alloc] init];
    }
    return _cpuPlayer;
}

- (CGPoint)getCGPointForIndex:(int)index
{
    int x = index / self.game.numColumns;
    int y = index % self.game.numColumns;
    return CGPointMake(x, y);
}

- (IBAction)touchLocationButton:(UIButton *)sender {
    
    int index = [self.locationButtons indexOfObject:sender];
    CGPoint location = [self getCGPointForIndex:index];
    
    if ([[self.game playerAtLocation:location] isEqualToString:@" "]) {
        [self.game markLocation:location with:@"X"];
        if (![self.game isOver]) {
            [self.cpuPlayer makeMove:self.game];
        }
        [self updateUI];
    }
}

- (void)updateUI
{
    for (UIButton *locationButton in self.locationButtons) {
        int index = [self.locationButtons indexOfObject:locationButton];
        CGPoint location = [self getCGPointForIndex:index];
        
        NSAttributedString *player = [[NSAttributedString alloc]
                                    initWithString:[self.game playerAtLocation:location]];
        [locationButton setAttributedTitle:player forState:UIControlStateNormal];
    }
    
    if ([self.game isOver]) {
        NSLog(@"Game over");
    }
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
