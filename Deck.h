//
//  Deck.h
//  Matchismo
//
//  Created by Jared Sorge on 1/31/13.
//  Copyright (c) 2013 Jared Sorge. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject

- (void)addCard:(Card *)card atTop:(BOOL)atTop;

- (Card *)drawRandomCard;

@end
