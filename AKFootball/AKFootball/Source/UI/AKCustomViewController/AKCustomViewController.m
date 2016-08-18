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
#import "AKFootballConstants.h"

@interface AKCustomViewController ()
@property (nonatomic, readonly) AKView                  *rootView;
@property (nonatomic, strong)   UIRefreshControl        *refreshControl;

- (void)leftBarButtonClick;
- (void)rightBarButtonClick;
- (void)showCustomNavigationBar;
- (void)addRefreshControl;

@end

@implementation AKCustomViewController

@dynamic leftButtonImageName;
@dynamic rightButtonImageName;
@dynamic loadingViewMessage;

#pragma mark -
#pragma mark View LifeCycle

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self showCustomNavigationBar];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addRefreshControl];
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
                [strongSelf contextDidLoadWithObject:object];
            });
        }forState:kAKModelLoadedState
                      object:self];
        
        [_context addHandler:^(id object) {
            AKStrongifyAndReturnIfNil
            AKDispatchAsyncOnMainThread(^{
                [strongSelf contextDidFailToLoad:object];
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
    UINavigationBar *navigationBar = self.navigationController.navigationBar;
    [navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    navigationBar.shadowImage = [UIImage new];
    navigationBar.translucent = YES;
    NSDictionary *titleTextAttributes =@{NSFontAttributeName:[UIFont fontWithName:
                                                              kAKFontName size:kAKFontSize],
                                         NSForegroundColorAttributeName:
                                             [UIColor whiteColor]};
    navigationBar.titleTextAttributes = titleTextAttributes;
    UINavigationItem *navigationItem = self.navigationItem;
    navigationItem.title = title;
    
    navigationItem.leftBarButtonItem = [UIBarButtonItem buttonWithImageName:leftButtonImageName
                                                                   selector:@selector(leftBarButtonClick)
                                                                     target:self];
    
    navigationItem.rightBarButtonItem = [UIBarButtonItem buttonWithImageName:rightButtonImageName
                                                                    selector:@selector(rightBarButtonClick)
                                                                      target:self];
}

- (void)contextDidLoadWithObject:(id)object {
    
}

- (void)contextDidFailToLoad:(id)object {
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:kAKAllertControllerTitle
                                                                   message:kAKAllertControllerMessage
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:kAKActionTitle style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {
                                                          }];
    
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)addRefreshControl {
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    refreshControl.backgroundColor = [UIColor grayColor];
    refreshControl.tintColor = [UIColor whiteColor];
    [refreshControl addTarget:self
                       action:@selector(refreshTable)
             forControlEvents:UIControlEventValueChanged];
    self.refreshControl = refreshControl;
    [self.rootView.tableView addSubview:self.refreshControl];
}

- (void)refreshTable {
    if (self.refreshControl) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:kAKRefreshDateFormat];
        NSString *title = [NSString stringWithFormat:kAKRefreshString, [formatter stringFromDate:[NSDate date]]];
        NSDictionary *attrsDictionary = [NSDictionary dictionaryWithObject:[UIColor whiteColor]
                                                                    forKey:NSForegroundColorAttributeName];
        NSAttributedString *attributedTitle = [[NSAttributedString alloc] initWithString:title
                                                                              attributes:attrsDictionary];
        self.refreshControl.attributedTitle = attributedTitle;
        
        [self.refreshControl endRefreshing];
    }
}

@end
