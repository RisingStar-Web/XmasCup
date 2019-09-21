//
//  AMApp.m
//  SpinTheBottle
//
//  Created by Matt Davenport on 02/09/2012.
//  Copyright (c) 2012 Taptastic Apps. All rights reserved.
//

#import "AMApp.h"

@implementation AMApp

- (id) initWithDictionary:(NSMutableDictionary *)appInfo
{
	self = [super init];
	if (self)
	{
		self.name = [appInfo objectForKey:@"name"];
		self.scheme = [appInfo objectForKey:@"url_scheme"];
		self.iconURL = [self getIconURLFromDictionary:appInfo];
		self.icon = nil;
		self.appId = [appInfo objectForKey:@"app_store_id"];
		self.link = [appInfo objectForKey:@"app_store_link"];
		self.device = [appInfo objectForKey:@"device"];
	}
	return self;
}

- (NSString *) getIconURLFromDictionary:(NSMutableDictionary *)dictionary
{
	BOOL retina = [[UIScreen mainScreen] scale] > 1.0;
	if (iPad)
	{
		NSString *iconKey = [NSString stringWithFormat:@"ipad_%@icon_url", retina ? @"retina_" : @""];
		return [dictionary objectForKey:iconKey];
	}
	
	NSString *iconKey = [NSString stringWithFormat:@"iphone_%@icon_url", retina ? @"retina_" : @""];
	return [dictionary objectForKey:iconKey];
}

@end
