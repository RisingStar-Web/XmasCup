//
//  KCCardConfig.h
//  KingsCup
//
//  Created by Matt Davenport on 27/07/2012.
//  Copyright (c) 2012 Taptastic Apps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface KCCardConfig : NSObject

+ (NSString *) definitionForLastKing;
+ (NSString *) definitionForFace:(CardFace)face;

@end
