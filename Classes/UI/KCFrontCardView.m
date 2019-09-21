//
//  KCFrontCardView.m
//  KingsCup
//
//  Created by Matt Davenport on 27/07/2012.
//  Copyright (c) 2012 Taptastic Apps. All rights reserved.
//

#import "KCFrontCardView.h"
#import "KCCardConfig.h"

#define kMaxFontSize	(iPad ? 18 : 18)

@implementation KCFrontCardView

@synthesize descriptionLabel = _descriptionLabel;

- (id)initWithCard:(Card *)card
{
    self = [super initWithCard:card];
    if (self) 
	{
		//UIColor *cardColor = card.color == CardColorRed ? [UIColor redColor] : [UIColor darkGrayColor];
		self.suitLabelFull.hidden = YES;
		
		self.descriptionLabel = [[UILabel alloc] init];
		if (card.isLastKing)
			[self.descriptionLabel setText:[KCCardConfig definitionForLastKing]];
		else
			[self.descriptionLabel setText:[KCCardConfig definitionForFace:card.face]];
		[self.descriptionLabel setTextColor:[UIColor blackColor]];
		[self.descriptionLabel setTextAlignment:NSTextAlignmentCenter];
		[self.descriptionLabel setBackgroundColor:[UIColor clearColor]];
		[self.descriptionLabel setNumberOfLines:0];
		[self.descriptionLabel setAdjustsFontSizeToFitWidth:YES];
		[self addSubview:self.descriptionLabel];
    }
    return self;
}

- (void) layoutSubviews
{
	[super layoutSubviews];
	
	self.descriptionLabel.frame = CGRectMake(35, 40, self.frame.size.width - 70, self.frame.size.height - 80);
	[self setFontForLabel:self.descriptionLabel];
}

- (void) setFontForLabel:(UILabel *)label
{
	int fontSize = kMaxFontSize + 1; // 1 more than max
	BOOL fitsInside = NO;
	
	while (!fitsInside)
	{
		fontSize -= 1;
		UIFont *font = [UIFont fontWithName:@"HelveticaNeue-Light" size:fontSize];
		CGSize labelTextSize = [label.text sizeWithFont:font
									  constrainedToSize:CGSizeMake(label.frame.size.width, 9999)
										  lineBreakMode:label.lineBreakMode];
		fitsInside = (labelTextSize.height <= label.frame.size.height);
	}
	
	self.descriptionLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:fontSize];
}

@end
