//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Jared Sorge on 2/2/13.
//  Copyright (c) 2013 Jared Sorge. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"

@interface CardMatchingGame : NSObject

- (id)initWithCardCount:(NSUInteger)cardCount
			  usingDeck:(Deck *)deck;

- (void)flipCardAtIndex:(NSUInteger)index;

- (Card *)cardAtIndex:(NSUInteger)index;

@property (readonly, nonatomic) int score;
@property (readonly, nonatomic) NSString *lastFlipLabel;
@property (nonatomic) int gameType;

@end
