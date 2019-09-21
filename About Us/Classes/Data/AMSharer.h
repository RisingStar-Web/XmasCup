//
//  AMSharer.h
//  SpinTheBottle
//
//  Created by Matt Davenport on 18/03/2013.
//  Copyright (c) 2013 Taptastic Apps. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AMSharer : NSObject

+ (void) shareOnTwitterWithShareString:(NSString *)shareString presentedFromViewController:(UIViewController *)viewController;
+ (void) shareOnFacebookWithShareString:(NSString *)shareString presentedFromViewController:(UIViewController *)viewController;

@end
