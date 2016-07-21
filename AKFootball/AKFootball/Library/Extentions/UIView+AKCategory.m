//
//  UIView+AKCategory.m
//  AKFootball
//
//  Created by Admin on 18.07.16.
//  Copyright © 2016 Karpov Andrey. All rights reserved.
//

#import "UIView+AKCategory.h"

static CGFloat const kAKDefaultBorderWidth           = 1.0f;
static CGFloat const kAKDefaultBorderCornerRadius    = 0;

@implementation UIView (AKCategory)

- (void)addDefaultBorder {
    [self addBorderWithColor:[UIColor blackColor]
                       width:kAKDefaultBorderWidth
                cornerRadius:kAKDefaultBorderCornerRadius];
}

- (void)addDefaultBorderWithCornerRadius:(CGFloat)cornerRadius {
    [self addBorderWithColor:[UIColor blackColor]
                       width:kAKDefaultBorderWidth
                cornerRadius:cornerRadius];
}

- (void)addBorderWithColor:(UIColor *)color width:(CGFloat)width cornerRadius:(CGFloat)cornerRadius {
    CALayer *layer = self.layer;
    layer.cornerRadius = cornerRadius;
    layer.borderColor = [color CGColor];
    layer.borderWidth = width;
}

@end
