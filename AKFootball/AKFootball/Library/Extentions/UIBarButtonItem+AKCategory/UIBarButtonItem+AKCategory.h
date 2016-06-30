//
//  UIBarButtonItem+AKCategory.h
//  AKFootball
//
//  Created by Admin on 30.06.16.
//  Copyright © 2016 Karpov Andrey. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (AKCategory)

+ (UIBarButtonItem *)buttonWithImageName:(NSString *)imageName
                                selector:(SEL)selector
                                  target:(id)target;

@end
