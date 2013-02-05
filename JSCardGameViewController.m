//
//  JSViewController.m
//  Matchismo
//
//  Created by Jared Sorge on 1/28/13.
//  Copyright (c) 2013 Jared Sorge. All rights reserved.
//

#import "JSCardGameViewController.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"

@interface JSCardGameViewController ()
- (IBAction)dealButton:(id)sender;
- (IBAction)changeGameType:(UISegmentedControl *)sender;

@property (nonatomic) int flipCount;
@property (strong, nonatomic) CardMatchingGame *game;
@property (weak, nonatomic) IBOutlet UISegmentedControl *gameTypeControl;
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastFlipLabel;
@end

@implementation JSCardGameViewController

- (CardMatchingGame *)game
{
    if (!_game) {
        _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                  usingDeck:[[PlayingCardDeck alloc] init]];
    }
    return _game;
}

- (void)updateUI
{
    for (UIButton *cardButton in self.cardButtons) {
        Card *card = [self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
		[cardButton setImage:card.isFaceUp ? nil : [UIImage imageNamed:@"cardback.jpg"] forState:UIControlStateNormal];
        [cardButton setTitle:card.contents forState:UIControlStateSelected];
        [cardButton setTitle:card.contents forState:UIControlStateSelected | UIControlStateDisabled];
        cardButton.selected = card.isFaceUp;
        cardButton.enabled = !card.unplayable; //if the card is playable then it is enabled
        cardButton.alpha = card.isunplayable ? 0.3 : 1.0; //if the card is unplayable set its alpha to .3, otherwise leave it full
    }
    
    //Get the last flip text from the model
    self.lastFlipLabel.text = [NSString stringWithFormat:@"%@", self.game.lastFlipLabel];
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
}

- (void)setCardButtons:(NSArray *)cardButtons
{
	_cardButtons = cardButtons;
    [self updateUI];
}

- (void)setFlipCount:(int)flipCount
{
	_flipCount = flipCount;
	self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
}

- (IBAction)flipCard:(UIButton *)sender
{
	[self.game flipCardAtIndex:[self.cardButtons indexOfObject:sender]];
    self.flipCount++;
    [self updateUI];
}


- (IBAction)dealButton:(id)sender
{
    _game = nil;
    [self updateUI];
    if ([self.gameTypeControl selectedSegmentIndex] == 0) {
        _game.gameType = 0;
    } else if ([self.gameTypeControl selectedSegmentIndex]== 1) {
        _game.gameType = 1;
    }
	self.flipCount = 0;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: 0"];
    self.lastFlipLabel.text = [NSString stringWithFormat:@"Pick a card"];
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: 0"];
}

- (IBAction)changeGameType:(UISegmentedControl *)sender
{
    //Change the game type using the UISegmentedControl to flip between 2 or 3 card matching
    if (sender.selectedSegmentIndex == 0) {
        _game.gameType = 0;
    } else if (sender.selectedSegmentIndex == 1) {
        _game.gameType = 1;
    }
}



@end
