//
//  AboutUsViewController.m
//  SpinTheBottle
//
//  Created by Matt Davenport on 19/10/2012.
//  Copyright (c) 2012 Taptastic Apps. All rights reserved.
//

#import "AboutUsViewController.h"
#import "AboutUsView.h"

#import "AMSharer.h"

#define kBannerSize		(iPad ? 200 : 100)

@interface AboutUsViewController ()

@property (strong) UIImage *backgroundImage;

@property (strong) UIImageView *background;
@property (strong) UIView *backgroundDarken;

@property (strong) UIView *topShadow;
@property (strong) UIView *bottomShadow;

@property (strong) UIControl *topCover;
@property (strong) UIControl *bottomCover;

@property (strong) UIImageView *topCoverBackground;
@property (strong) UIImageView *bottomCoverBackground;

@property (strong) AboutUsView *aboutUsView;

@property (strong) UIButton *twitterBtn;
@property (strong) UIButton *facebookBtn;
@property (strong) UIButton *giftBtn;

@end

@implementation AboutUsViewController

- (id) initWithBackgroundImage:(UIImage *)image
{
    self = [super init];
    if (self)
	{
		self.backgroundImage = image;
    }
    return self;
}

- (id) initWithView:(UIView *)view
{
    self = [super init];
    if (self)
	{
		UIGraphicsBeginImageContextWithOptions(view.bounds.size, YES, 0.0f);
		[view.layer renderInContext:UIGraphicsGetCurrentContext()];
		self.backgroundImage = UIGraphicsGetImageFromCurrentImageContext();
		UIGraphicsEndImageContext();
		
		self.topCoverBackground.image = self.backgroundImage;
		self.bottomCoverBackground.image = self.backgroundImage;
    }
    return self;
}

- (void) loadView
{
	[super loadView];
	
	self.background = [[UIImageView alloc] initWithImage:[UIImage universalImageNamed:@"Background.png"]];
	[self.view addSubview:self.background];
	
	self.backgroundDarken = [[UIView alloc] init];
	self.backgroundDarken.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.6];
	[self.view addSubview:self.backgroundDarken];
	
	self.aboutUsView = [[AboutUsView alloc] init];
	[self.view addSubview:self.aboutUsView];
	
	self.topShadow = [[UIView alloc] init];
	self.topShadow.backgroundColor = [UIColor blackColor];
	self.topShadow.layer.shadowColor = [UIColor blackColor].CGColor;
	self.topShadow.layer.shadowOffset = CGSizeMake(0, 0);
	self.topShadow.layer.shadowOpacity = 1.0;
	self.topShadow.layer.shadowRadius = 10.0;
	[self.view addSubview:self.topShadow];
	
	self.bottomShadow = [[UIView alloc] init];
	self.bottomShadow.backgroundColor = [UIColor blackColor];
	self.bottomShadow.layer.shadowColor = [UIColor blackColor].CGColor;
	self.bottomShadow.layer.shadowOffset = CGSizeMake(0, 0);
	self.bottomShadow.layer.shadowOpacity = 1.0;
	self.bottomShadow.layer.shadowRadius = 10.0;
	[self.view addSubview:self.bottomShadow];
	
	self.topCover = [[UIControl alloc] init];
	self.topCover.layer.masksToBounds = YES;
	[self.view addSubview:self.topCover];
	
	self.bottomCover = [[UIControl alloc] init];
	self.bottomCover.layer.masksToBounds = YES;
	[self.view addSubview:self.bottomCover];
	
	self.topCoverBackground = [[UIImageView alloc] initWithImage:self.backgroundImage];
	[self.topCover addSubview:self.topCoverBackground];
	
	self.bottomCoverBackground = [[UIImageView alloc] initWithImage:self.backgroundImage];
	[self.bottomCover addSubview:self.bottomCoverBackground];
	
	self.twitterBtn = [UIButton buttonWithType:UIButtonTypeCustom];
	[self.twitterBtn setBackgroundImage:[UIImage universalImageNamed:@"ShareTwitter.png"] forState:UIControlStateNormal];
	[self.twitterBtn.layer setShadowColor:[UIColor blackColor].CGColor];
	[self.twitterBtn.layer setShadowOpacity:0.6];
	[self.twitterBtn.layer setShadowRadius:3.0];
	[self.view addSubview:self.twitterBtn];
	
	self.facebookBtn = [UIButton buttonWithType:UIButtonTypeCustom];
	[self.facebookBtn setBackgroundImage:[UIImage universalImageNamed:@"ShareFacebook.png"] forState:UIControlStateNormal];
	[self.facebookBtn.layer setShadowColor:[UIColor blackColor].CGColor];
	[self.facebookBtn.layer setShadowOpacity:0.6];
	[self.facebookBtn.layer setShadowRadius:3.0];
	[self.view addSubview:self.facebookBtn];
	
	self.giftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
	[self.giftBtn setBackgroundImage:[UIImage universalImageNamed:@"ShareGift.png"] forState:UIControlStateNormal];
	[self.giftBtn.layer setShadowColor:[UIColor blackColor].CGColor];
	[self.giftBtn.layer setShadowOpacity:0.6];
	[self.giftBtn.layer setShadowRadius:3.0];
	[self.view addSubview:self.giftBtn];
	
	[self layoutSubviews];
}

- (void) layoutSubviews
{
	self.background.frame = self.view.bounds;
	self.backgroundDarken.frame = self.view.bounds;
	
	self.topCover.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height / 2);
	self.bottomCover.frame = CGRectMake(0, self.view.frame.size.height / 2, self.view.frame.size.width, self.view.frame.size.height / 2);
	
	self.topShadow.frame = self.topCover.frame;
	self.bottomShadow.frame = self.bottomCover.frame;
	
	self.topCoverBackground.frame = CGRectMake(0, 0, self.topCoverBackground.image.size.width, self.topCoverBackground.image.size.height);
	self.bottomCoverBackground.frame = CGRectMake(0, -(self.bottomCoverBackground.image.size.height / 2), self.bottomCoverBackground.image.size.width, self.bottomCoverBackground.image.size.height);
	
	self.aboutUsView.frame = CGRectMake(0, (CGRectGetMaxY(self.topCover.frame)-(kBannerSize / 2))+5, self.view.frame.size.width, kBannerSize-10);
	
	self.facebookBtn.bounds = CGRectMake(0, 0, self.facebookBtn.currentBackgroundImage.size.width, self.facebookBtn.currentBackgroundImage.size.height);
	self.twitterBtn.bounds = CGRectMake(0, 0, self.twitterBtn.currentBackgroundImage.size.width, self.twitterBtn.currentBackgroundImage.size.height);
	self.giftBtn.bounds = CGRectMake(0, 0, self.giftBtn.currentBackgroundImage.size.width, self.giftBtn.currentBackgroundImage.size.height);
	
	self.twitterBtn.center = CGPointMake(self.view.center.x, self.view.frame.size.height + CGRectGetMidY(self.twitterBtn.bounds));
	self.facebookBtn.center = CGPointMake(CGRectGetMinX(self.twitterBtn.frame) - CGRectGetMidX(self.facebookBtn.bounds) - 10, self.view.frame.size.height + CGRectGetMidY(self.facebookBtn.bounds));
	self.giftBtn.center = CGPointMake(CGRectGetMaxX(self.twitterBtn.frame) + CGRectGetMidX(self.giftBtn.bounds) + 10, self.view.frame.size.height + CGRectGetMidY(self.giftBtn.bounds));
}

- (void) viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	[self layoutSubviews];
}

- (void) viewDidAppear:(BOOL)animated
{
	[super viewDidAppear:animated];
	
	
	[self layoutSubviews];
	
	[UIView animateWithDuration:0.4
					 animations:^{
						 CGRect topCoverFrame = self.topCover.frame;
						 topCoverFrame.origin.y = -(kBannerSize / 2);
						 self.topCover.frame = topCoverFrame;
						 
						 CGRect bottomCoverFrame = self.bottomCover.frame;
						 bottomCoverFrame.origin.y = (self.view.frame.size.height / 2) + (kBannerSize / 2);
						 self.bottomCover.frame = bottomCoverFrame;
						 
						 self.topShadow.frame = self.topCover.frame;
						 self.bottomShadow.frame = self.bottomCover.frame;
					 } completion:^(BOOL finished) {
						 [self.topCover addTarget:self action:@selector(onClose) forControlEvents:UIControlEventTouchUpInside];
						 [self.bottomCover addTarget:self action:@selector(onClose) forControlEvents:UIControlEventTouchUpInside];
						 
						 [UIView animateWithDuration:0.3
											   delay:0.2
											 options:UIViewAnimationOptionBeginFromCurrentState
										  animations:^{
											  
											  CGRect twitterFrame = self.twitterBtn.frame;
											  twitterFrame.origin.y = self.view.frame.size.height-40-twitterFrame.size.height;
											  self.twitterBtn.frame = twitterFrame;
											  
										  } completion:^(BOOL finished) {
											  [self.twitterBtn addTarget:self action:@selector(onTwitter) forControlEvents:UIControlEventTouchUpInside];
										  }];
						 
						 [UIView animateWithDuration:0.3
											   delay:0.1
											 options:UIViewAnimationOptionBeginFromCurrentState
										  animations:^{
											  
											  CGRect facebookFrame = self.facebookBtn.frame;
											  facebookFrame.origin.y = self.view.frame.size.height-40-facebookFrame.size.height;
											  self.facebookBtn.frame = facebookFrame;
											  
										  } completion:^(BOOL finished) {
											  [self.facebookBtn addTarget:self action:@selector(onFacebook) forControlEvents:UIControlEventTouchUpInside];
										  }];
						 
						 
						 [UIView animateWithDuration:0.3
											   delay:0.3
											 options:UIViewAnimationOptionBeginFromCurrentState
										  animations:^{
											  
											  CGRect giftFrame = self.giftBtn.frame;
											  giftFrame.origin.y = self.view.frame.size.height-40-giftFrame.size.height;
											  self.giftBtn.frame = giftFrame;
											  
										  } completion:^(BOOL finished) {
											  [self.giftBtn addTarget:self action:@selector(onGift) forControlEvents:UIControlEventTouchUpInside];
										  }];
					 }];
}

- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	if(iPad)
		return (UIInterfaceOrientationIsLandscape(interfaceOrientation));
	
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Actions

- (void) onClose
{
	[UIView animateWithDuration:0.3
						  delay:0.2
						options:UIViewAnimationOptionBeginFromCurrentState
					 animations:^{
						 
						 CGRect twitterFrame = self.twitterBtn.frame;
						 twitterFrame.origin.y = self.view.frame.size.height + CGRectGetMidY(self.twitterBtn.bounds) + 10;
						 self.twitterBtn.frame = twitterFrame;
						 
					 } completion:nil];
	
	[UIView animateWithDuration:0.3
						  delay:0.1
						options:UIViewAnimationOptionBeginFromCurrentState
					 animations:^{
						 
						 CGRect facebookFrame = self.facebookBtn.frame;
						 facebookFrame.origin.y = self.view.frame.size.height + CGRectGetMidY(self.facebookBtn.bounds) + 10;
						 self.facebookBtn.frame = facebookFrame;
						 
					 } completion:nil];
	
	[UIView animateWithDuration:0.3
						  delay:0.3
						options:UIViewAnimationOptionBeginFromCurrentState
					 animations:^{
						 
						 CGRect giftFrame = self.giftBtn.frame;
						 giftFrame.origin.y = self.view.frame.size.height + CGRectGetMidY(self.giftBtn.bounds) + 10;
						 self.giftBtn.frame = giftFrame;
						 
					 } completion:^(BOOL finished) {
						 [UIView animateWithDuration:0.4
										  animations:^{
											  CGRect topCoverFrame = self.topCover.frame;
											  topCoverFrame.origin.y = 0;
											  self.topCover.frame = topCoverFrame;
											  
											  CGRect bottomCoverFrame = self.bottomCover.frame;
											  bottomCoverFrame.origin.y = (self.view.frame.size.height / 2);
											  self.bottomCover.frame = bottomCoverFrame;
											  
											  self.topShadow.frame = self.topCover.frame;
											  self.bottomShadow.frame = self.bottomCover.frame;
										  } completion:^(BOOL finished) {
											  [self.navigationController popViewControllerAnimated:NO];
										  }];
					 }];
}

- (void) onTwitter
{
	NSString *appName = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"Name"];
	[AMSharer shareOnTwitterWithShareString:[NSString stringWithFormat:NSLocalizedString(@"Check out %@ by @tapboxltd %@", nil), appName, [self appStoreURL]]
				presentedFromViewController:self];
}

- (void) onFacebook
{
	NSString *appName = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"Name"];
	[AMSharer shareOnFacebookWithShareString:[NSString stringWithFormat:NSLocalizedString(@"Check out %@ by Tapbox %@", nil), appName, [self appStoreURL]]
				 presentedFromViewController:self];
}

- (void) onGift
{
	[[iRate sharedInstance] openGiftAppPageInAppStore];
}

- (NSString *) appStoreURL
{
	NSString *appName = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"];
	NSString *linkName =	[appName stringByReplacingOccurrencesOfString:@" " withString:@""];
	linkName =				[linkName stringByReplacingOccurrencesOfString:@"." withString:@""];
	linkName =				[linkName stringByReplacingOccurrencesOfString:@":" withString:@""];
	linkName =				[linkName stringByReplacingOccurrencesOfString:@"!" withString:@""];
	linkName =				[linkName stringByReplacingOccurrencesOfString:@"?" withString:@""];
	
	return [NSString stringWithFormat:@"http://tapbox.co/link/app/%@", [linkName lowercaseString]];
}

@end
