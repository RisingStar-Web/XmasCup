//
//  KCCardConfig.m
//  KingsCup
//
//  Created by Matt Davenport on 27/07/2012.
//  Copyright (c) 2012 Taptastic Apps. All rights reserved.
//

#import "KCCardConfig.h"

@implementation KCCardConfig

+ (NSString *) definitionForFace:(CardFace)face
{
	NSMutableArray *definitions = [NSMutableArray array];
	[definitions addObject:NSLocalizedString(@"Confess the worst present you have ever received", nil)]; // Race the ace
	[definitions addObject:NSLocalizedString(@"Mime your favourite Christmas film", nil)]; //Is for you
	[definitions addObject:NSLocalizedString(@"Transform the person on your left into a Christmas tree using anything you can find in your house", nil)]; //Is for me
	[definitions addObject:NSLocalizedString(@"Eat a mince pie (or any pie you have) without using your hands!", nil)]; //Floor
	[definitions addObject:NSLocalizedString(@"Pick a person to be Santa's little helper, they must get all your food and drink for the rest of the game", nil)]; //Guys
	[definitions addObject:NSLocalizedString(@"Draw something Christmas related on a piece of paper with your eyes closed, everyone must guess what it is", nil)]; // Chicks
	[definitions addObject:NSLocalizedString(@"Tell everyone a lie and 2 things that are true about yourself, they must guess which is which", nil)]; //Heaven
	[definitions addObject:NSLocalizedString(@"Everyone must write a list from A-Z, next to each letter they should write a christmas related word. The first to finish wins!", nil)];
	[definitions addObject:NSLocalizedString(@"You must think of a word. Each player in the circle must say a word that rhymes with your word. The first player to repeat a word or fail to come up with one loses and misses a turn", nil)]; //Rhyme Time
	[definitions addObject:NSLocalizedString(@"You must pick a category. Players in your the circle must say an item in your chosen category. The first player to repeat an item or fail to come up with one loses and misses a turn", nil)]; //Category
	[definitions addObject:NSLocalizedString(@"You must make up a rule to put into play until the next Jack is drawn. e.g. every time a person laughs, they miss a turn", nil)];
	[definitions addObject:NSLocalizedString(@"Each player must go around the circle and ask the player next to them a question. If a player repeats a question they lose and miss a turn", nil)]; //Question time
	[definitions addObject:NSLocalizedString(@"Write your favourite Christmas song onto a piece of paper. Fold it and drop it into a cup (don't let anyone else see)", nil)]; //Kings cup
	
	return [definitions objectAtIndex:face];
}

+ (NSString *) definitionForLastKing
{
	return NSLocalizedString(@"You must pick a song from the cup and sing it as loud as you can", nil);
}

@end