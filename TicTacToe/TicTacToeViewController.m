//
//  TicTacToeViewController.m
//  TicTacToe
//
//  Created by David Torre on 5/12/14.
//  Copyright (c) 2014 David Torre. All rights reserved.
//

#import "TicTacToeViewController.h"
#import "TicTacToeGame.h"
#import "GameMaster.h"

@interface TicTacToeViewController()
@property (strong, nonatomic) TicTacToeGame *game;
@property (strong, nonatomic) GameMaster *gameMaster;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *locationButtons;
@property (weak, nonatomic) IBOutlet UILabel *gameStatusLabel;
@end

@implementation TicTacToeViewController

static const int NUM_ROWS = 3;
static const int NUM_COLUMNS = 3;

- (TicTacToeGame *)game
{
    if (!_game) {
        _game = [[TicTacToeGame alloc] initWithRows:NUM_ROWS columns:NUM_COLUMNS];
    }
    return _game;
}

- (GameMaster *)gameMaster
{
    if (!_gameMaster) {
        _gameMaster = [[GameMaster alloc] init];
    }
    return _gameMaster;
}

- (CGPoint)getCGPointForIndex:(int)index
{
    int x = index / NUM_COLUMNS;
    int y = index % NUM_COLUMNS;
    return CGPointMake(x, y);
}

- (IBAction)touchLocationButton:(UIButton *)sender
{
    int index = (int)[self.locationButtons indexOfObject:sender];
    CGPoint location = [self getCGPointForIndex:index];
    if ([self.gameMaster requestMoveInGame:self.game atLocation:location]) {
        [self updateUI];
    }
}

- (IBAction)touchNewGameButton:(UIButton *)sender
{
    self.game = nil;
    self.gameStatusLabel.text = @" ";
    [self updateUI];
}

- (IBAction)touchShiftRightButton:(UIButton *)sender
{
    if (![self.game isOver]) {
        [self.game shiftRight];
        [self updateUI];
    }
}

- (void)updateUI
{
    for (UIButton *locationButton in self.locationButtons) {
        int index = (int)[self.locationButtons indexOfObject:locationButton];
        CGPoint location = [self getCGPointForIndex:index];
        
        NSAttributedString *player = [[NSAttributedString alloc]
                                    initWithString:[self.game playerAtLocation:location]];
        [locationButton setAttributedTitle:player forState:UIControlStateNormal];
    }
    
    if ([self.game isOver]) {
        NSString *statusText;
        switch (self.game.score) {
            case 10:
                statusText = @"Game over. You won!";
                break;
            case -10:
                statusText = @"Game over. You Lost.";
                break;
            case 0:
                statusText = @"Game over. Draw.";
                break;
            default:
                statusText = @" ";
                break;
        }
        self.gameStatusLabel.text = statusText;
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
