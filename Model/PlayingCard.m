//
//  PlayingCard.m
//  Matchismo
//
//  Created by Jared Sorge on 1/31/13.
//  Copyright (c) 2013 Jared Sorge. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

@synthesize suit = _suit;

- (int)match:(NSArray *)otherCards
{
    int score = 0;
    if (otherCards.count == 1) {
        PlayingCard *otherCard = [otherCards lastObject];
        if ([otherCard.suit isEqualToString:self.suit]) {
            score = 1;
        } else if (otherCard.rank == self.rank) {
            score = 4;
        }
    } else if (otherCards.count == 2) {
        PlayingCard *firstCard = [otherCards objectAtIndex:0];
		PlayingCard *secondCard = [otherCards lastObject];
		if ([firstCard.suit isEqualToString:self.suit] && [secondCard.suit isEqualToString:self.suit] && [firstCard.suit isEqualToString:secondCard.suit]) {
			score = 2;
		} else if (firstCard.rank == self.rank && secondCard.rank == self.rank && firstCard.rank == secondCard.rank) {
			score = 8;
		}
    }
    return score;
}

+ (NSArray *) validSuits {
    return @[@"♥", @"♦",@"♠",@"♣"];
}

+ (NSArray *)rankStrings {
    return @[@"?",@"A", @"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"];
}

+ (NSUInteger)maxRank {
    return [self rankStrings].count -1;
}

- (void)setRank:(NSUInteger)rank {
    if (rank <= [PlayingCard maxRank]) {
        _rank = rank;
        // No need to use @synthesize here, since we're never setting the getter for rank
    }
}

- (NSString *)contents {
    return [PlayingCard.rankStrings[self.rank] stringByAppendingString:self.suit];
}

- (void)setSuit:(NSString *)suit {
    if ([@[@"♥", @"♦",@"♠",@"♣"] containsObject:suit]) {
        _suit = suit;
    }
}

- (NSString *)suit {
    return  _suit ? _suit: @"?";
}

@end
