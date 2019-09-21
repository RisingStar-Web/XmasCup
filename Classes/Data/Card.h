//
//  Card.h
//  KingsCup
//
//  Created by Matt Davenport on 18/07/2012.
//  Copyright (c) 2012 Taptastic Apps. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
	CardColorRed = 0,
	CardColorBlack,
} CardColor;

typedef enum {
	CardSuitSpades = 0,
	CardSuitClubs,
	CardSuitHearts,
	CardSuitDiamonds
} CardSuit;

typedef enum {
	CardFaceAce = 0,
	CardFace2,
	CardFace3,
	CardFace4,
	CardFace5,
	CardFace6,
	CardFace7,
	CardFace8,
	CardFace9,
	CardFace10,
	CardFaceJack,
	CardFaceQueen,
	CardFaceKing
} CardFace;

@interface Card : NSObject

- (id) initWithFace:(CardFace)face andSuit:(CardSuit)suit;

- (NSString *) faceString;
- (NSString *) suitString;

@property (assign) CardFace face;
@property (assign) CardSuit suit;
@property (assign) CardColor color;
@property (assign) BOOL isLastKing;

@end
