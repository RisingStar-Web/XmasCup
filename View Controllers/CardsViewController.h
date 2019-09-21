//
//  CardsViewController.h
//  KingsCup
//
//  Created by Matt Davenport on 18/07/2012.
//  Copyright (c) 2012 Taptastic Apps. All rights reserved.
//

#import "CardManager.h"
#import "CardView.h"
#import "Card.h"

#define kSmallCardWidth		(iPad ? 245 : 207)
#define kSmallCardHeight	(iPad ? 350 : 295)

@interface CardsViewController : UIViewController <UIAlertViewDelegate>

@end
