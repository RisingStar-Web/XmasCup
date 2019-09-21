//
//  NSMutableArray+Shuffle.m
//  KingsCup
//
//  Created by Matt Davenport on 18/07/2012.
//  Copyright (c) 2012 Taptastic Apps. All rights reserved.
//

#import "NSMutableArray+Shuffle.h"

@implementation NSMutableArray (Shuffle)

- (void)shuffle
{
    for (uint i = 0; i < self.count; ++i)
    {
        // Select a random element between i and end of array to swap with.
        int nElements = self.count - i;
        int n = arc4random_uniform(nElements) + i;
        [self exchangeObjectAtIndex:i withObjectAtIndex:n];
    }
}

@end