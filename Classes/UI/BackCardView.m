//
//  BackCardView.m
//  KingsCup
//
//  Created by Matt Davenport on 27/07/2012.
//  Copyright (c) 2012 Taptastic Apps. All rights reserved.
//

#import "BackCardView.h"

@interface BackCardView()

@property (strong) UIImageView *background;

@end

@implementation BackCardView

- (id)init
{
    self = [super init];
    if (self) 
	{
		self.background = [[UIImageView alloc] initWithImage:[UIImage universalImageNamed:@"CardBackground.png"]];
		[self addSubview:self.background];
		
		[self setUserInteractionEnabled:NO];
    }
    return self;
}

- (void) layoutSubviews
{
	[super layoutSubviews];
	
	self.background.frame = self.bounds;
}

@end
