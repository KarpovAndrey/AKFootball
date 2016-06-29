//
//  UINavigationController+AKCategory.m
//  AKFacebook
//
//  Created by Admin on 22.06.16.
//  Copyright © 2016 Karpov Andrey. All rights reserved.
//

#import "UINavigationController+AKCategory.h"

#define kAKTransitionDuration 0.5f;


@implementation UINavigationController (AKCategory)

- (void)pushViewControllerWithDefaultTransitions:(UIViewController *)viewController animated:(BOOL)animated {
    [self pushViewController:viewController animated:animated];
    [self performTransition];

}

- (void)performTransition  {
    CATransition *transition = [CATransition animation];
    transition.duration = kAKTransitionDuration;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromTop;
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
}

@end
