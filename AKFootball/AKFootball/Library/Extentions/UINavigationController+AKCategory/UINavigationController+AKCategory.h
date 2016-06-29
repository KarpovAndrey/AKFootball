//
//  UINavigationController+AKCategory.h
//  AKFacebook
//
//  Created by Admin on 22.06.16.
//  Copyright © 2016 Karpov Andrey. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationController (AKCategory)

- (void)performTransition;
- (void)pushViewControllerWithDefaultTransitions:(UIViewController *)viewController
                                        animated:(BOOL)animated;

@end
