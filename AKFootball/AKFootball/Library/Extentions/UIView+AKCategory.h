//
//  UIView+AKCategory.h
//  AKFootball
//
//  Created by Admin on 18.07.16.
//  Copyright © 2016 Karpov Andrey. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (AKCategory)

- (void)addDefaultBorder;
- (void)addDefaultBorderWithCornerRadius:(CGFloat)cornerRadius;
- (void)addBorderWithColor:(UIColor *)color width:(CGFloat)width cornerRadius:(CGFloat)cornerRadius;

@end
