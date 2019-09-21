//
//  CardManager.h
//  KingsCup
//
//  Created by Matt Davenport on 18/07/2012.
//  Copyright (c) 2012 Taptastic Apps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface CardManager : NSObject

@property (strong) NSMutableArray *cards;
@property (strong) NSMutableArray *currentCards;

+ (CardManager *) sharedInstance;
- (void) setupCards;
- (Card *) returnCardAtIndex:(int)index;
- (Card *) returnCard;
- (void) removeCard:(Card *)card;
- (BOOL) doesCardExist:(CardFace)face;
- (BOOL) hasCardsLeft;
@end
