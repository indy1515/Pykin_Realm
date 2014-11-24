//
//  ImageCrop.h
//  Pykin Realms
//
//  Created by IndyZa on 11/24/2557 BE.
//  Copyright (c) 2557 IndyZa. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ImageCrop :UIImage

+ (UIImage *)imageWithImage:(UIImage *)image cropInRect:(CGRect)rect;

// define rect in proportional to the target image.
//
//  +--+--+
//  |A | B|
//  +--+--+
//  |C | D|
//  +--+--+
//
//  rect {0, 0, 1, 1} produce full image without cropping.
//  rect {0.5, 0.5, 0.5, 0.5} produce part D, etc.

+ (UIImage *)imageWithImage:(UIImage *)image cropInRelativeRect:(CGRect)rect;

@end

// Used by +[UIImage imageWithImage:cropInRelativeRect]
CGRect CGRectTransformToRect(CGRect fromRect, CGRect toRect);

