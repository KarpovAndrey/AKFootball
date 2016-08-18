//
//  UIColor+AKCategory.m
//  AKFootball
//
//  Created by Admin on 18.08.16.
//  Copyright © 2016 Karpov Andrey. All rights reserved.
//

#import "UIColor+AKCategory.h"

@implementation UIColor (AKCategory)

+ (UIColor *)colorWithRedColor:(CGFloat)red
                    greenColor:(CGFloat)green
                     blueColor:(CGFloat)blue
                         alpha:(CGFloat)alpha
{
    return [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:alpha];
}

@end
