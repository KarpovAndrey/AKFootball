//
//  AKLeaguesViewController.m
//  AKFootball
//
//  Created by Admin on 30.06.16.
//  Copyright © 2016 Karpov Andrey. All rights reserved.
//

#import "AKLeaguesViewController.h"
#import "AKLeaguesView.h"
#import "AKLeaguesViewCell.h"
#import "AKLeague.h"
#import "AKLeagueContext.h"
#import "AKDispatch.h"

static NSString * const kAKNavigationItemTitle      = @"LEAGUES";

@interface AKLeaguesViewController ()
@property (nonatomic, readonly) AKLeaguesView       *rootView;
@property (nonatomic, strong)   NSArray             *leaguesArray;
@property (nonatomic, strong)   AKLeagueContext     *context;

@end

@implementation AKLeaguesViewController

#pragma mark -
#pragma mark View LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.context.state == kAKModelLoadingState) {
        [self.rootView showLoadingViewWithDefaultMessageAnimated:YES];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = NO;
}

#pragma mark -
#pragma mark Accessors

AKRootViewAndReturnIfNil(AKLeaguesView)

- (NSString *)navigationItemTitle {
    return kAKNavigationItemTitle;
}

- (void)setYear:(NSUInteger)year {
    if (_year != year) {
        _year = year;
        
        self.context = [[AKLeagueContext alloc] initWithYear:year];
    }
}

- (void)setContext:(AKLeagueContext *)context {
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
            [strongSelf objectDidFailToLoad:object];
        }forState:kAKModelFailedState
                      object:self];
        
    }
}

#pragma mark -
#pragma mark UITableViewDataSource Protocol

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.leaguesArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AKLeaguesViewCell *cell = [tableView dequeueCellFromNibWithClass:[AKLeaguesViewCell class]];
    [cell fillWithModel:self.leaguesArray[indexPath.row]];
    
    return cell;
}

#pragma mark -
#pragma mark Public

- (void)objectDidLoadWithObject:(NSArray *)leagues {
    self.leaguesArray = leagues;
    AKLeaguesView *rootView = self.rootView;
    [rootView.tableView reloadData];
    [self.rootView removeLoadingViewAnimated:YES];
}

- (void)objectDidFailToLoad:(NSArray *)leagues {
    AKLeaguesView *rootView = self.rootView;
    [rootView.tableView reloadData];
    [self.rootView removeLoadingViewAnimated:YES];
}

@end
