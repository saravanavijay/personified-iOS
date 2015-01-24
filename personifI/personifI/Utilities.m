//
//  Utilities.m
//  personifI
//
//  Created by Vijay on 24/01/15.
//  Copyright (c) 2015 personifIInc. All rights reserved.
//

#import "Utilities.h"

@implementation Utilities
//-------------------------------------------------------------------------------------------------------------------------------------------------
UIImage* ResizeImage(UIImage *image, CGFloat width, CGFloat height)
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
    CGSize size = CGSizeMake(width, height);
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
