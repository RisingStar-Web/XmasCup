//
//  CardManager.m
//  KingsCup
//
//  Created by Matt Davenport on 18/07/2012.
//  Copyright (c) 2012 Taptastic Apps. All rights reserved.
//

#import "NSMutableArray+Shuffle.h"
#import "CardManager.h"

@implementation CardManager

@synthesize cards = _cards;
@synthesize currentCards = _currentCards;

- (id) init
{
	self = [super init];
	if (self)
	{
		self.cards = [NSMutableArray array];
		self.currentCards = [NSMutableArray array];
		
		[self setupCards];
	}
	return self;
}

- (void) setupCards
{
	[self.cards removeAllObjects];
	[self.currentCards removeAllObjects];
	
	for (int s=0; s<4; s++)
	{
		for (int f=0; f<13; f++)
		{
			Card *card = [[Card alloc] initWithFace:f andSuit:s];
			[self.cards addObject:card];
		}
	}
	[self.cards shuffle];
	
	return;
	
	//Comment out the above return for screenshots
	
	for (int c = 0; c < [self.cards count]; c++)
	{
		Card *card = [self.cards objectAtIndex:c];
		if (card.face == CardFaceKing && card.suit == CardSuitHearts)
		{
			[self.cards exchangeObjectAtIndex:c withObjectAtIndex:0];
			break;
		}
	}
	
	for (int c = 0; c < [self.cards count]; c++)
	{
		Card *card = [self.cards objectAtIndex:c];
		if (card.face == CardFace7 && card.suit == CardSuitHearts)
		{
			[self.cards exchangeObjectAtIndex:c withObjectAtIndex:1];
			break;
		}
	}
	
	for (int c = 0; c < [self.cards count]; c++)
	{
		Card *card = [self.cards objectAtIndex:c];
		if (card.face == CardFaceQueen && card.suit == CardSuitDiamonds)
		{
			[self.cards exchangeObjectAtIndex:c withObjectAtIndex:2];
			break;
		}
	}
	
	
	
	return;
	
	//Comment out the above return to test what happens when the King is the last card
	for (int c = 0; c < [self.cards count]; c++)
	{
		Card *card = [self.cards objectAtIndex:c];
		if (card.face == CardFaceKing)
		{
			[self.cards exchangeObjectAtIndex:c withObjectAtIndex:[self.cards count] - 1];
			break;
		}
	}
}

- (Card *) returnCard
{
	if ([self.cards count] == 0)
		return nil;
	
	return [self returnCardAtIndex:0];
}

- (Card *) returnCardAtIndex:(int)index
{
	if ([self.cards count] == 0)
		return nil;
	
	Card *card = [self.cards objectAtIndex:index];
	
	if (card.face == CardFaceKing)
	{
		int count = 0;
		for (Card *card in self.cards)
		{
			if (card.face == CardFaceKing)
				count++;
		}
		
		if (count == 1)
			card.isLastKing = YES;
	}
	[self.currentCards addObject:card];
	[self.cards removeObjectAtIndex:index];
	
	return [self.currentCards lastObject];
}

- (void) removeCard:(Card *)card
{
	//NSLog(@"Removing %@ (%i)", card, [self.cards count]);
	if ([self.currentCards containsObject:card])
		[self.currentCards removeObject:card];
	else
		NSLog(@"Could not remove %@ (%i)", card, [self.cards count]);
}

- (BOOL) doesCardExist:(CardFace)face
{
	for (Card *card in self.cards)
	{
		if (card.face == face)
			return YES;
	}
	
	for (Card *card in self.currentCards)
	{
		if (card.face == face)
			return YES;
	}
	return NO;
}

- (BOOL) hasCardsLeft
{
	return ([self.cards count] > 0 || [self.currentCards count] > 0);
}

#pragma mark - Singleton setup

+ (CardManager *) sharedInstance {
	static dispatch_once_t pred;
	static CardManager *shared = nil;
	dispatch_once(&pred, ^{
		shared = [[CardManager alloc] init];
	});
	return shared;
}

@end
