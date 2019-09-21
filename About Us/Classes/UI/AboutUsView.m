//
//  AboutUsView.m
//  SpinTheBottle
//
//  Created by Matt Davenport on 18/10/2012.
//  Copyright (c) 2012 Taptastic Apps. All rights reserved.
//

#import "AboutUsView.h"
#import "OurAppsEngine.h"

#define kHorizontalSpacing	(10)
#define kSpacing			(5)

@interface AboutUsView()

@property (strong) OurAppsEngine *engine;

@property (strong) UIScrollView *appsView;

@end

@implementation AboutUsView

- (id) init
{
    self = [super init];
    if (self)
	{
		self.engine = [[OurAppsEngine alloc] initWithHostName:@"www.tapbox.co/"];
		
		[[iRate sharedInstance] getAppStoreID];
		
		self.userInteractionEnabled = YES;
		
		[self.engine getOurApps:^(NSMutableArray *apps) {
			if ([apps count] > 0)
			{
				[self layoutApps:apps];
			}
		} onError:nil];
		
		self.appsView = [[UIScrollView alloc] init];
		self.appsView.showsHorizontalScrollIndicator = NO;
		self.appsView.showsVerticalScrollIndicator = NO;
		[self addSubview:self.appsView];
    }
    return self;
}

- (void) layoutSubviews
{
	[super layoutSubviews];
	
	self.appsView.frame = self.bounds;
}

- (void) layoutApps:(NSMutableArray *)apps
{
	for (UIView *view in self.appsView.subviews)
		[view removeFromSuperview];
	
	float x = kHorizontalSpacing;
	int count = 0;
	
	for (AMApp *app in apps)
	{
		UIButton *appButton = [UIButton buttonWithType:UIButtonTypeCustom];
		appButton.frame = CGRectMake(x, (self.frame.size.height - (self.frame.size.height-(kSpacing*2))) / 2,
									 self.frame.size.height-(kSpacing*2), self.frame.size.height-(kSpacing*2));
		[appButton setTitle:app.link forState:UIControlStateNormal];
		[appButton setTitleColor:[UIColor clearColor] forState:UIControlStateNormal]; //lulz
		[appButton setTag:count];
		[appButton addTarget:self action:@selector(onApp:) forControlEvents:UIControlEventTouchUpInside];
		[self.appsView addSubview:appButton];
		
		x = CGRectGetMaxX(appButton.frame)+kHorizontalSpacing;
		
		[self.engine imageAtURL:[NSURL URLWithString:app.iconURL]
				   onCompletion:^(UIImage *fetchedImage, NSURL *url, BOOL isInCache) {
					   [appButton setBackgroundImage:fetchedImage forState:UIControlStateNormal];
				   }];
		count++;
	}
	
	self.appsView.contentSize = CGSizeMake(x+kHorizontalSpacing, self.appsView.contentSize.height);
}

- (void) onApp:(UIButton *)btn
{
	/*id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
	[tracker trackEventWithCategory:@"Action"
						 withAction:@"App tapped"
						  withLabel:nil
						  withValue:@-1];
	*/
	NSURL *url = [NSURL URLWithString:btn.currentTitle];
	if ([[UIApplication sharedApplication] canOpenURL:url])
		[[UIApplication sharedApplication] openURL:url];
}

@end
