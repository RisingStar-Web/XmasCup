//
//  FrontCardView.h
//  KingsCup
//
//  Created by Matt Davenport on 27/07/2012.
//  Copyright (c) 2012 Taptastic Apps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Card.h"

@interface FrontCardView : UIView

@property (strong) UILabel *faceLabel;
@property (strong) UIImageView *suitImage; //Will be UIImage
@property (strong) UILabel *suitLabelFull; //Test

- (id) initWithCard:(Card *)card;

@end
