//
//  UIImage+imageNamedExtension.m
//  SpinTheBottle
//
//  Created by Matt Davenport on 14/05/2012.
//  Copyright (c) 2012 Taptastic Apps All rights reserved.
//

#import "UIImage+imageNamedExtension.h"

@implementation UIImage (imageNamedExtension)

+ (UIImage *) universalImageNamed:(NSString *)name
{
	if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
	{
		NSArray *fileNameComponents = [name componentsSeparatedByString:@"."];
		if([fileNameComponents count] > 1)
		{
			NSString *fileName = [NSString stringWithFormat:@"%@-iPad.%@", [fileNameComponents objectAtIndex:0], [fileNameComponents lastObject]];
			UIImage *image = [UIImage imageNamed:fileName];
			if(image != nil)
				return image;
		}
	}
	else if ([[UIScreen mainScreen] bounds].size.height == 568)
	{
		NSArray *fileNameComponents = [name componentsSeparatedByString:@"."];
		if([fileNameComponents count] > 1)
		{
			NSString *fileName = [NSString stringWithFormat:@"%@-568h.%@", [fileNameComponents objectAtIndex:0], [fileNameComponents lastObject]];
			UIImage *image = [UIImage imageNamed:fileName];
			if(image != nil)
				return image;
		}
	}
	return [UIImage imageNamed:name];
}

@end
