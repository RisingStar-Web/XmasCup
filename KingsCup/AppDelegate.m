//
//  AppDelegate.m
//  KingsCup
//
//  Created by Matt Davenport on 18/07/2012.
//  Copyright (c) 2012 Taptastic Apps. All rights reserved.
//

#import "AppDelegate.h"
#import "CardsViewController.h"

@implementation AppDelegate

@synthesize window = _window;
@synthesize viewController = _viewController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
	
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	
    self.viewController = [[CardsViewController alloc] init];
	
	UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:self.viewController];
	[navController setNavigationBarHidden:YES];
	
	self.window.rootViewController = navController;
    [self.window makeKeyAndVisible];
    return YES;
}

@end
