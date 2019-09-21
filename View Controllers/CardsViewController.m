//
//  CardsViewController.m
//  KingsCup
//
//  Created by Matt Davenport on 18/07/2012.
//  Copyright (c) 2012 Flatshare LTD. All rights reserved.
//

#import "CardsViewController.h"
#import "AboutUsViewController.h"

#import "CardManager.h"
#import "CardView.h"

#define kCardXOffset	(iPad ? 150 : 0)

@interface CardsViewController ()

@property (strong) UIView *cardView;

@property (strong) UIImageView *background;
@property (strong) UIImageView *overlay;
@property (strong) UIButton *infoButton;

@property (strong) NSMutableArray *cards;
@property (strong) NSMutableArray *removedCards;
@property (strong) Card *selectedCard;

@end

@implementation CardsViewController

@synthesize cards = _cards;
@synthesize removedCards = _removedCards;
@synthesize selectedCard = _selectedCard;

- (void) dealloc
{
	[[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (id) init
{
	self = [super init];
	if (self)
	{
		self.cards = [NSMutableArray array];
		self.removedCards = [NSMutableArray array];
		self.selectedCard = nil;
	}
	return self;
}

- (void) viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	[self layout];
}

- (void) viewDidAppear:(BOOL)animated
{
	[super viewDidAppear:animated];
	[self layout];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	if(iPad)
		return (UIInterfaceOrientationIsLandscape(interfaceOrientation));
	
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Drawing

- (void) loadView
{
	[super loadView];
	
	self.background = [[UIImageView alloc] initWithImage:[UIImage universalImageNamed:@"Background.png"]];
	[self.view addSubview:self.background];
	
	self.cardView = [[UIView alloc] init];
	[self.view addSubview:self.cardView];
	
	self.infoButton = [UIButton buttonWithType:UIButtonTypeCustom];
	[self.infoButton setBackgroundImage:[UIImage universalImageNamed:@"InfoBtn.png"] forState:UIControlStateNormal];
	[self.infoButton setBackgroundImage:[UIImage universalImageNamed:@"InfoBtnPushed.png"] forState:UIControlStateHighlighted];
	[self.infoButton addTarget:self action:@selector(onOurApps) forControlEvents:UIControlEventTouchUpInside];
	self.infoButton.hidden = YES;
	[self.view addSubview:self.infoButton];
	
	[self drawCards];
	
	self.overlay = [[UIImageView alloc] initWithImage:[UIImage universalImageNamed:@"Overlay.png"]];
	self.overlay.userInteractionEnabled = NO;
	self.overlay.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
	[self.view addSubview:self.overlay];
	
	[self layout];
	
}

- (void) drawCards
{
	for (UIView *view in [self.cardView subviews])
		[view removeFromSuperview];
	
	for (int c=0; c<5; c++)
	{
		[self addCard];
	}
}

- (void) addCard
{
	Card *randomCard = [[CardManager sharedInstance] returnCard];
	
	if (randomCard == nil)
		return;
	
	KCFrontCardView *frontView = [[KCFrontCardView alloc] initWithCard:randomCard];
	BackCardView *backView = [[BackCardView alloc] init];
	
	CardView *card = [[CardView alloc] initWithCard:randomCard
										  frontView:frontView
										   backView:backView];
	[card setFrame:CGRectMake(0, 0, kSmallCardWidth, kSmallCardHeight)];
	[card setCenter: CGPointMake(CGRectGetMidX(self.view.frame)+kCardXOffset, CGRectGetMidY(self.view.frame))];
	[card addTarget:self action:@selector(cardTapped:) forControlEvents:UIControlEventTouchUpInside];
	
	int rotate = (0 + arc4random() % 10)-5;
	card.transform = CGAffineTransformMakeRotation(degreesToRadians(rotate));
	[self.cardView addSubview:card];
	[self.cards addObject:card];
	
	[self.cardView sendSubviewToBack:card];
}

- (void) layout
{
	CGSize base = self.view.bounds.size;
	self.background.frame = CGRectMake(0, 0, base.width, base.height);
	self.overlay.frame = CGRectMake(0, 0, base.width, base.height);
	self.cardView.frame = CGRectMake(0, 0, base.width, base.height);
	
	if (iPad)
	{
		self.infoButton.frame = CGRectMake(15, 15, self.infoButton.currentBackgroundImage.size.width, self.infoButton.currentBackgroundImage.size.height);
	}
	else
	{
		self.infoButton.frame = CGRectMake(self.view.frame.size.width - self.infoButton.currentBackgroundImage.size.width - 15, 15, self.infoButton.currentBackgroundImage.size.width, self.infoButton.currentBackgroundImage.size.height);
	}
	
	for (CardView *card in self.cards)
		[card setCenter: CGPointMake(CGRectGetMidX(self.view.frame)+kCardXOffset, CGRectGetMidY(self.view.frame))];
}

#pragma mark - Actions

- (void) cardTapped:(CardView *)card
{
	//id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
	/*
	[tracker sendEvent:@"Card Tapped"];
	[tracker trackEventWithCategory:@"Action"
						 withAction:
						  withLabel:nil
						  withValue:@-1];
	*/
	if (!iPad)
		self.selectedCard = card.card;
	
	[self.cardView bringSubviewToFront:card];
	if (iPad)
	{
		[self.removedCards addObject:card];
		if ([self.removedCards count] > 5)
		{
			CardView *cardView = [self.removedCards objectAtIndex:0];
			[cardView removeFromSuperview];
			[self.removedCards removeObjectAtIndex:0];
		}
	}
	[UIView animateWithDuration:0.2
					 animations:^{
						 if (!iPad)
							 card.transform = CGAffineTransformMakeRotation(degreesToRadians(0));
					 } completion:^(BOOL finished) {
						 [UIView animateWithDuration:0.5
										  animations:^{
											   if (iPad)
												   card.center = CGPointMake(CGRectGetMidX(self.view.frame)-kCardXOffset, CGRectGetMidY(self.view.frame));
											   else
											   {
												   CGRect f = card.frame;
												   f.size.width = kSmallCardWidth*1.4;
												   f.size.height = kSmallCardHeight*1.4;
												   f.origin.x = (self.view.frame.size.width-f.size.width)/2;
												   f.origin.y = (self.view.frame.size.height-f.size.height)/2;
												   card.frame = f;
											   }
										  } completion:^(BOOL finished) {
											  [card flip];
											  [self cardTappedAnimationFinished:card];
											  if (iPad)
											  {
												  [[CardManager sharedInstance] removeCard:card.card];
												  [self checkEndGame];
												  [self.cards removeObject:card];
											  }
										  }];
					 }];
	
	[card removeTarget:self action:@selector(cardTapped:) forControlEvents:UIControlEventTouchUpInside];
	if (iPad)
		[self addCard];
	else
		[card addTarget:self action:@selector(removeCard:) forControlEvents:UIControlEventTouchUpInside];
}

- (void) removeCard:(CardView *)card
{
	[[CardManager sharedInstance] removeCard:card.card];
	
	if (![self canContinue])
		return;
	
	[self addCard];
	
	self.selectedCard = nil;
	[self.cards removeObject:card];
	[UIView animateWithDuration:0.3 
					 animations:^{
						 CGRect f = card.frame;
						 f.origin.y -= self.view.frame.size.height;
						 card.frame = f;
						 card.alpha = 0;
					 } completion:^(BOOL finished) {
						 [self animatedReset];
						 [self removeCardAnimationFinished];
					 }];
}

- (void) checkEndGame
{
	[self canContinue];
}

- (void) onOurApps
{
	[self showOurAppsAnimated:YES];
}

#pragma mark - Animation finished

- (void) cardTappedAnimationFinished:(CardView *)card
{
	
}

- (void) removeCardAnimationFinished
{
	
}

#pragma mark - Checking / game over

- (BOOL) canContinue
{
	if (![[CardManager sharedInstance] hasCardsLeft])
	{
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Game over", @"Game over title")
														message:NSLocalizedString(@"There are no cards left, the game is over", @"Cards GO msg")
													   delegate:self
											  cancelButtonTitle:NSLocalizedString(@"New Game", @"New Game button") 
											  otherButtonTitles:nil];
		[alert show];
        
		return NO;
	}
	
	if (![[CardManager sharedInstance] doesCardExist:CardFaceKing])
	{
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Game over", @"Game over title")
														message:NSLocalizedString(@"There are no kings left, the game is over", @"Kings GO msg")
													   delegate:self
											  cancelButtonTitle:NSLocalizedString(@"New Game", @"New Game button")
											  otherButtonTitles:nil];
		[alert show];
        
		return NO;
	}
	
	return YES;
}

- (void) newGame
{
	//id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
	/*[tracker trackEventWithCategory:@"Action"
						 withAction:@"New Game"
						  withLabel:nil
						  withValue:@-1];
	*/
	[UIView animateWithDuration:0.3
					 animations:^{
						 //
					 } completion:^(BOOL finished) {
						 for (CardView *cardView in self.cards)
							 [cardView removeFromSuperview];
						 
						 [self.cards removeAllObjects];
						 
						 [[CardManager sharedInstance] setupCards];
						 
						 [self drawCards];
						 [self layout];
					 }];
}

- (void) animatedReset
{
	
}

#pragma mark - UIAlertView Delegate

- (void) alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
	[self newGame];
}

#pragma mark - View loading

- (void) showOurAppsAnimated:(BOOL)animated
{
	AboutUsViewController *viewController = [[AboutUsViewController alloc] initWithView:self.view];
	[self.navigationController pushViewController:viewController animated:NO];
}

@end
