//
//  AKViewModel.h
//  AKStudy
//
//  Created by Admin on 19.05.16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AKView: UIView

- (void)showLoadingView;
- (void)showLoadingViewWithDefaultMessageAnimated:(BOOL)animated;
- (void)showLoadingViewAnimated:(BOOL)animated;
- (void)showLoadingViewWithMessage:(NSString *)message;
- (void)showLoadingViewWithMessage:(NSString *)message animated:(BOOL)animated;

- (void)removeLoadingView;
- (void)removeLoadingViewAnimated:(BOOL)animated;

@end
