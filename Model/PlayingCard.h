//
//  PlayingCard.h
//  Matchismo
//
//  Created by Jared Sorge on 1/31/13.
//  Copyright (c) 2013 Jared Sorge. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface PlayingCard : Card

@property (nonatomic, strong) NSString *suit;
@property (nonatomic) NSUInteger rank;

+ (NSArray *)validSuits;
+ (NSUInteger)maxRank;

@end
