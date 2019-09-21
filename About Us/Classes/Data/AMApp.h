//
//  AMApp.h
//  SpinTheBottle
//
//  Created by Matt Davenport on 02/09/2012.
//  Copyright (c) 2012 Taptastic Apps. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AMApp : NSObject

@property (strong) NSString *name;
@property (strong) NSString *scheme;
@property (strong) NSString *iconURL;
@property (strong) UIImage *icon;
@property (strong) NSString *appId;
@property (strong) NSString *link;
@property (strong) NSString *device;

- (id) initWithDictionary:(NSMutableDictionary *)appInfo;

@end
