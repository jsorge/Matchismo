	//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Jared Sorge on 2/2/13.
//  Copyright (c) 2013 Jared Sorge. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()
@property (readwrite, nonatomic) int score;
@property (strong, nonatomic) NSMutableArray *cards;
@property (readwrite, nonatomic) NSString *lastFlipLabel;
@property (nonatomic) BOOL singleCard;
@end

@implementation CardMatchingGame

#pragma mark Properties

- (NSMutableArray *)cards
{
    if (!_cards) {
        _cards = [[NSMutableArray alloc] init];
    }
    return _cards;
}

#pragma mark init
- (id)initWithCardCount:(NSUInteger)cardCount
              usingDeck:(Deck *)deck
{
    self = [super init];
    if (self){
        for (int i = 0; i < cardCount; i++) {
            Card *card = [deck drawRandomCard];
            if (!card) {
                self = nil;
            } else {
                self.cards[i] = card;
            }
        }
    }
    
    return self;
}

#pragma mark Return single card

- (Card *)cardAtIndex:(NSUInteger)index
{
    //if the index is less than the count then it returns the card at the index, otherwise nil
    return (index < [self.cards count]) ? self.cards[index] : nil;
}

#pragma mark Flip & Match Cards

#define MATCH_BONUS 4;
#define MISMATCH_PENALTY 2;
#define FLIP_COST 1;

- (void)flipCardAtIndex:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];
    
    if (self.gameType == 0) { //If gameType == 0, then it will match 2 cards
        if (card && !card.isunplayable) { //There needs to be a valid, playable card
            if (!card.isFaceUp) { //The card needs to start face down
                for (Card *otherCard in self.cards) { //Loop through all the other cards
                    if (otherCard.isFaceUp && !otherCard.isunplayable) { //If the other card is face up and playable, proceed
                        int matchScore = [card match:@[otherCard]]; //Check to see if the card matches
                        if (matchScore) {
                            card.unplayable = YES;
                            otherCard.unplayable = YES;
                            int flipScore = matchScore * MATCH_BONUS;
                            self.score += flipScore;
                            self.lastFlipLabel = [NSString stringWithFormat:@"Matched %@ and %@ for %d points", card.contents, otherCard.contents, flipScore];
                            self.singleCard = NO;
                        } else {
                            otherCard.faceUp = NO;
                            self.score -= MISMATCH_PENALTY;
                            self.lastFlipLabel = [NSString stringWithFormat:@"Flipped %@ & %@! No Match! -2 points", card.contents, otherCard.contents];
                            self.singleCard = NO;
                        }
                        break;
                    } else {
                        self.singleCard = YES; //Use this to configure the lastFlipLabel property
                    }
                }
                self.score -= FLIP_COST;
            }
            card.faceUp = !card.isFaceUp;
            if (self.singleCard) { //If this is the only flipped up card, then update the label
                self.lastFlipLabel = [NSString stringWithFormat:@"Flipped the %@", card.contents];
            }
        }
    } else if (self.gameType == 1) { //If gameType == 1 then it will match 3 cards
		NSMutableArray *otherCards = [[NSMutableArray alloc] init];
        if (card && !card.isunplayable){ //We need a valid card that is playable
            if (!card.isFaceUp) { //The card needs to start face down
                for (Card * otherCard in self.cards) { //Loop through all the cards to see how many we have up
					if (otherCard.isFaceUp && !otherCard.isunplayable) { //If we have a card that is face up and playable, add it to an array
						[otherCards addObject:otherCard];
					} //end if
				} //end loop
				if ([otherCards count] == 2) { //if there are 2 cards in the array then we score the result
					int matchScore = [card match:otherCards];
					if (matchScore) { //if the cards match
						Card *firstCard = [otherCards objectAtIndex:0];
						Card *secondCard = [otherCards lastObject];
						firstCard.unplayable = YES;
						secondCard.unplayable = YES;
						card.unplayable = YES;
						int flipScore = matchScore * MATCH_BONUS;
						self.score += flipScore;
						self.lastFlipLabel = [NSString stringWithFormat:@"Matched %@, %@ and %@ for %d points", card.contents, firstCard.contents, secondCard.contents, flipScore];
					} else { //if the cards don't match
						Card *firstCard = [otherCards objectAtIndex:0];
						Card *secondCard = [otherCards lastObject];
						firstCard.faceUp = NO;
						secondCard.faceUp = NO;
						card.faceUp = YES;
						self.score -= MISMATCH_PENALTY;
						self.lastFlipLabel = [NSString stringWithFormat:@"Flipped %@, %@ and %@ with no match. -4 points!", card.contents, firstCard.contents, secondCard.contents];
					}
				} else if ([otherCards count] == 1) { //If this is the second card that we're flipping
					card.faceUp = !card.faceUp;
					self.lastFlipLabel = [NSString stringWithFormat:@"Flipped the %@. Pick one more", card.contents];
				} else if ([otherCards count] == 0) {
					card.faceUp = !card.faceUp;
					self.lastFlipLabel = [NSString stringWithFormat:@"Flipped the %@. Pick two more", card.contents];
				}
				self.score -= FLIP_COST;
            } else if (card.isFaceUp) {
				card.faceUp = !card.faceUp;
				self.lastFlipLabel = [NSString stringWithFormat:@"Flipped the %@ back over.", card.contents];
			}
        }
    }
}


@end
