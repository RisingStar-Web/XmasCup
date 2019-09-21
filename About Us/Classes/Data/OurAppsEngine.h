//
//  OurAppsEngine.h
//  SpinTheBottle
//
//  Created by Matt Davenport on 02/09/2012.
//  Copyright (c) 2012 Taptastic Apps. All rights reserved.
//

#import "MKNetworkEngine.h"
#import "AMApp.h"

typedef void (^OurAppsResponseBlock)(NSMutableArray *apps);

@interface OurAppsEngine : MKNetworkEngine

+ (id) sharedInstance;

- (MKNetworkOperation*) getOurApps:(OurAppsResponseBlock) completionBlock
						   onError:(MKNKErrorBlock) errorBlock;

@end
