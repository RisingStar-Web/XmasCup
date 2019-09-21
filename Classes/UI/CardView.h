//
//  CardView.h
//  KingsCup
//
//  Created by Matt Davenport on 18/07/2012.
//  Copyright (c) 2012 Taptastic Apps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Card.h"
#import "KCFrontCardView.h"
#import "BackCardView.h"

@interface CardView : UIButton

@property (strong) Card *card;

- (id) initWithCard:(Card *)card frontView:(FrontCardView *)frontView backView:(BackCardView *)backView;
- (void) flip;

@end
