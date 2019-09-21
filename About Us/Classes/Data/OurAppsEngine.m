//
//  OurAppsEngine.m
//  SpinTheBottle
//
//  Created by Matt Davenport on 02/09/2012.
//  Copyright (c) 2012 Taptastic Apps. All rights reserved.
//

#import "OurAppsEngine.h"

#define kOurAppsURL @"api/apps/"

@implementation OurAppsEngine

- (id) initWithHostName:(NSString *)hostName
{
	self = [super initWithHostName:hostName];
	if (self)
	{
		[self useCache];
		
		[super useCache];
	}
	return self;
}

- (MKNetworkOperation *) getOurApps:(OurAppsResponseBlock)completionBlock onError:(MKNKErrorBlock)errorBlock
{
	MKNetworkOperation *op = [self operationWithPath:kOurAppsURL
											  params:[@{@"action": @"apps", @"type": @"12"} mutableCopy]
										  httpMethod:@"GET"];
	
    [op onCompletion:^(MKNetworkOperation *completedOperation)
     {
		 NSMutableArray *apps = [NSMutableArray array];
		 for (NSMutableDictionary *appInfo in [completedOperation responseJSON])
		 {
			 AMApp *app = [[AMApp alloc] initWithDictionary:appInfo];
			 [apps addObject:app];
		 }
		 completionBlock(apps);
		 
     }onError:^(NSError* error) {
         errorBlock(error);
     }];
	
    [self enqueueOperation:op];
	
    return op;
}

- (NSString*) cacheDirectoryName
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *cacheDirectoryName = [documentsDirectory stringByAppendingPathComponent:@"Icons"];
	
    return cacheDirectoryName;
}

+ (id) sharedInstance
{
    DEFINE_SHARED_INSTANCE_USING_BLOCK(^{
        return [[self alloc] init];
    });
}

@end
