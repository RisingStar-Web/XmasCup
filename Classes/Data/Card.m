//
//  Card.m
//  KingsCup
//
//  Created by Matt Davenport on 18/07/2012.
//  Copyright (c) 2012 Taptastic Apps. All rights reserved.
//

#define faceValues		([NSArray arrayWithObjects:@"A", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"J", @"Q", @"K", nil])
#define suitValues		([NSArray arrayWithObjects:@"Spades", @"Clubs", @"Hearts", @"Diamonds", nil])

#import "Card.h"

@implementation Card

@synthesize face = _face;
@synthesize suit = _suit;
@synthesize color = _color;

- (id) initWithFace:(CardFace)face andSuit:(CardSuit)suit;
{
	self = [super init];
	if (self)
	{
		self.face = face;
		self.suit = suit;
		
		self.isLastKing = NO;
		
		BOOL isBlack = self.suit == CardSuitClubs || self.suit == CardSuitSpades;
		self.color = isBlack ? CardColorBlack : CardColorRed;
	}
	return self;
}

- (NSString *) faceString
{
	return [faceValues objectAtIndex:self.face];
}

- (NSString *) suitString
{
	return [suitValues objectAtIndex:self.suit];
}

- (NSString *) description
{
	return [NSString stringWithFormat:@"%@ of %@", [self faceString], [self suitString]];
}

@end
