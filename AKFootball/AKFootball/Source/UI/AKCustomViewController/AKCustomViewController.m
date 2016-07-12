//
//  AKCustomViewController.m
//  AKFacebook
//
//  Created by Admin on 13.06.16.
//  Copyright © 2016 Karpov Andrey. All rights reserved.
//

#import "AKCustomViewController.h"
#import "AKView.h"
#import "AKContext.h"
#import "AKDispatch.h"
//#import "AKUserModel.h"

static NSString * const kAKNavigationItemTitle      = @"TITLE";
static NSString * const kAKAllertControllerTitle    = @"No Interner Connection";
static NSString * const kAKAllertControllerMessage  = @"Make sure your device is connected to the internet";
static NSString * const kAKActionTitle              = @"OK";
static NSString * const kAKLeftBarBattonImageName   = @"BackButton";
static NSString * const kAKRightBarBattonImageName  = @"HomeButton";

@interface AKCustomViewController ()


- (void)leftBarButtonClick;
- (void)rightBarButtonClick;
- (void)showCustomNavigationBar;

@end

@implementation AKCustomViewController

@dynamic leftButtonImageName;
@dynamic rightButtonImageName;
@dynamic loadingViewMessage;
//@dynamic navigationItemTitle;

#pragma mark -
#pragma mark View LifeCycle

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self showCustomNavigationBar];
}

#pragma mark -
#pragma mark Accessors

- (NSString *)navigationItemTitle {
    return kAKNavigationItemTitle;
}

- (NSString *)leftButtonImageName {
    return kAKLeftBarBattonImageName;
}

- (NSString *)rightButtonImageName {
    return kAKRightBarBattonImageName;
}

- (void)setContext:(AKContext *)context {
    if (_context != context) {
        [_context cancel];
        _context = context;
        [_context load];

        AKWeakify;
        [_context addHandler:^(id object) {
            AKStrongifyAndReturnIfNil
            AKDispatchAsyncOnMainThread(^{
                [strongSelf objectDidLoadWithObject:object];
            });
        }forState:kAKModelLoadedState
                      object:self];
        
        [_context addHandler:^(id object) {
            AKStrongifyAndReturnIfNil
            AKDispatchAsyncOnMainThread(^{
                [strongSelf objectDidFailToLoad:object];
            });
        }forState:kAKModelFailedState
                      object:self];
    }
}

#pragma mark -
#pragma mark Private

- (void)leftBarButtonClick {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)rightBarButtonClick {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark Public

- (void)showCustomNavigationBar {
    [self showNavigationBarWithTitle:self.navigationItemTitle
                 leftButtonImageName:self.leftButtonImageName
                rightButtonImageName:self.rightButtonImageName];
}

- (void)showNavigationBarWithTitle:(NSString *)title
               leftButtonImageName:(NSString *)leftButtonImageName
              rightButtonImageName:(NSString *)rightButtonImageName
{
    self.navigationController.navigationBarHidden = NO;
    UINavigationItem *navigationItem = self.navigationItem;
    
    navigationItem.title = title;
    
    navigationItem.leftBarButtonItem = [UIBarButtonItem buttonWithImageName:leftButtonImageName
                                                                   selector:@selector(leftBarButtonClick)
                                                                     target:self];
    
    navigationItem.rightBarButtonItem = [UIBarButtonItem buttonWithImageName:rightButtonImageName
                                                                    selector:@selector(rightBarButtonClick)
                                                                      target:self];
}

- (void)objectDidLoadWithObject:(id)object {
    
}

- (void)objectDidFailToLoad:(id)object {
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:kAKAllertControllerTitle
                                                                   message:kAKAllertControllerMessage
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:kAKActionTitle style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {
                                                          }];
    
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
}

@end
