//
//  CardView.m
//  KingsCup
//
//  Created by Matt Davenport on 18/07/2012.
//  Copyright (c) 2012 Taptastic Apps. All rights reserved.
//

#import "CardView.h"

@interface CardView()

@property (strong) FrontCardView *frontView;
@property (strong) BackCardView *backView;

@end

@implementation CardView

@synthesize card = _card;
@synthesize frontView = _frontView;
@synthesize backView = _backView;

- (id) initWithCard:(Card *)card frontView:(FrontCardView *)frontView backView:(BackCardView *)backView;
{
    self = [super init];
    if (self) 
	{
		self.card = card;
		
		if (!frontView)
			backView = [[BackCardView alloc] init];
		
		if (!frontView)
			frontView = [[FrontCardView alloc] initWithCard:card];
		
		self.frontView = frontView;
		self.backView = backView;
		
		[self addSubview:self.frontView];
		[self addSubview:self.backView];
    }
    return self;
}

#pragma mark - Drawing

- (void) layoutSubviews
{
	[super layoutSubviews];
	self.frontView.frame = self.bounds;
	self.backView.frame = self.bounds;
}

#pragma mark - Animations

- (void) flip
{
	CGContextRef context = UIGraphicsGetCurrentContext();
	[UIView beginAnimations:nil context:context];
	[UIView setAnimationTransition: UIViewAnimationTransitionFlipFromRight forView:self cache:YES];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	[UIView setAnimationDuration:0.4];
	[UIView setAnimationDidStopSelector:@selector(flipDidStop)];
	
	[self exchangeSubviewAtIndex:0 withSubviewAtIndex:1];
	
	[UIView commitAnimations];
}

@end
