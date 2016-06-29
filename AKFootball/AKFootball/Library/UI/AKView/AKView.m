//
//  AKView.m
//  AKStudy
//
//  Created by Admin on 19.05.16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import "AKView.h"
#import "AKLoadingView.h"

static CGFloat      const kAKDefaultAnimateDuration      = 0.3;
static CGFloat      const kAKDefaultLoadingAlpha         = 0.9;
static CGFloat      const kAKDefaultRemovingAlpha        = 0.2;
static NSString*    const kAKDefaultLoadingMessage       = @"LOADING";

@interface AKView ()
@property (nonatomic, strong) AKLoadingView *loadingView;

@end

@implementation AKView

#pragma mark -
#pragma mark Public

- (void)showLoadingView {
    [self showLoadingViewAnimated:NO];
}

- (void)showLoadingViewAnimated:(BOOL)animated {
    [self showLoadingViewWithMessage:nil animated:animated];
}

- (void)showLoadingViewWithMessage:(NSString *)message {
    [self showLoadingViewWithMessage:message animated:NO];
}

- (void)showLoadingViewWithDefaultMessageAnimated:(BOOL)animated {
    [self showLoadingViewWithMessage:kAKDefaultLoadingMessage animated:YES];
}

- (void)showLoadingViewWithMessage:(NSString *)message animated:(BOOL)animated {
    AKLoadingView *view = self.loadingView;
    if (!view) {
        view = [UINib loadFromNibWithClass:[AKLoadingView class]];
        view.frame = self.frame;
        view.label.text = message;
        self.loadingView = view;
    }

    [UIView animateWithDuration:animated ? kAKDefaultAnimateDuration : 0
                     animations:^{
                         self.loadingView.alpha = kAKDefaultLoadingAlpha;
                         [self addSubview:view];
                     }];
}

- (void)removeLoadingView {
    [self removeLoadingViewAnimated:NO];
}

- (void)removeLoadingViewAnimated:(BOOL)animated {
    
    [UIView animateWithDuration:animated ? kAKDefaultAnimateDuration : 0
                     animations:^{
                         self.loadingView.alpha = kAKDefaultRemovingAlpha;
                     } completion:^(BOOL finished) {
                         [self.loadingView removeFromSuperview];
                     }];
}

@end
