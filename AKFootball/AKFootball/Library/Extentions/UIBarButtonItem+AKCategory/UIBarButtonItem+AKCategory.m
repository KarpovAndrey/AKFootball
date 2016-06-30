//
//  UIBarButtonItem+AKCategory.m
//  AKFootball
//
//  Created by Admin on 30.06.16.
//  Copyright © 2016 Karpov Andrey. All rights reserved.
//

#import "UIBarButtonItem+AKCategory.h"

@implementation UIBarButtonItem (AKCategory)

+ (UIBarButtonItem *)buttonWithImageName:(NSString *)imageName
                                selector:(SEL)selector
                                  target:(id)target
{
    UIImage *image = [UIImage imageNamed:imageName];
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    return [[UIBarButtonItem alloc] initWithImage:image
                                            style:UIBarButtonItemStyleDone
                                           target:target
                                           action:selector];
}

@end
