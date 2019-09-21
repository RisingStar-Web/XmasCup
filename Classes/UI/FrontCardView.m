//
//  FrontCardView.m
//  KingsCup
//
//  Created by Matt Davenport on 27/07/2012.
//  Copyright (c) 2012 Taptastic Apps. All rights reserved.
//

#import "FrontCardView.h"

@interface FrontCardView()

@property (strong) Card *card;
@property (strong) UIImageView *background;

@end

@implementation FrontCardView

- (id) initWithCard:(Card *)card
{
	self = [super init];
	if (self)
	{
		self.card = card;
		
		self.background = [[UIImageView alloc] initWithImage:[UIImage universalImageNamed:@"FrontCardBackground.png"]];
		[self addSubview:self.background];
		
		UIColor *cardColor = card.color == CardColorRed ? rgb(208, 0, 0) : rgb(31, 31, 31);
		
		[self setUserInteractionEnabled:NO];
		
		self.faceLabel = [[UILabel alloc] init];
		[self.faceLabel setText:card.faceString];
		[self.faceLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:16]];
		[self.faceLabel setTextColor:cardColor];
		[self.faceLabel setTextAlignment:NSTextAlignmentCenter];
		[self.faceLabel setBackgroundColor:[UIColor clearColor]];
		[self addSubview:self.faceLabel];
		
		self.suitImage = [[UIImageView alloc] init];
		[self addSubview:self.suitImage];
		
		switch (card.suit) {
			case CardSuitClubs:
				self.suitImage.image = [UIImage universalImageNamed:@"CardClub.png"];
				break;
			case CardSuitDiamonds:
				self.suitImage.image = [UIImage universalImageNamed:@"CardDiamond.png"];
				break;
			case CardSuitHearts:
				self.suitImage.image = [UIImage universalImageNamed:@"CardHeart.png"];
				break;
			case CardSuitSpades:
				self.suitImage.image = [UIImage universalImageNamed:@"CardSpade.png"];
				break;
		}
		
		self.suitLabelFull = [[UILabel alloc] init];
		[self.suitLabelFull setText:card.suitString];
		[self.suitLabelFull setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18]];
		[self.suitLabelFull setTextColor:cardColor];
		[self.suitLabelFull setTextAlignment:NSTextAlignmentCenter];
		[self.suitLabelFull setBackgroundColor:[UIColor clearColor]];
		[self addSubview:self.suitLabelFull];
    }
    return self;
}

- (void) layoutSubviews
{
	[super layoutSubviews];
	self.background.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
	self.faceLabel.frame = CGRectMake(0, 30, self.frame.size.width, 20);
	
	CGSize faceWidth = [self.faceLabel.text sizeWithFont:self.faceLabel.font];
	
	float x = (self.faceLabel.frame.size.width / 2) + 2 + (faceWidth.width / 2);
	float y = CGRectGetMidY(self.faceLabel.frame) - ( self.suitImage.image.size.height / 2);
	self.suitImage.frame = CGRectMake(x, y, self.suitImage.image.size.width, self.suitImage.image.size.height);
}

@end