//
//  Card.h
//  Matchismo
//
//  Created by Jared Sorge on 1/31/13.
//  Copyright (c) 2013 Jared Sorge. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject

@property (nonatomic, strong)NSString *contents;
@property (nonatomic, getter = isFaceUp) BOOL faceUp;
@property (nonatomic, getter = isunplayable) BOOL unplayable;

- (int)match:(NSArray *)otherCards;

@end
