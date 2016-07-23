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
#import "AKTeamsViewController.h"
#import "AKSeason.h"
#import "AKLeaguesContext.h"
#import "AKDispatch.h"
#import "AKFootballConstants.h"

@interface AKLeaguesViewController ()
@property (nonatomic, readonly) AKLeaguesView       *rootView;
@property (nonatomic, strong)   NSArray             *leaguesArray;

@end

@implementation AKLeaguesViewController

#pragma mark -
#pragma mark View LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.context.state == kAKModelLoadingState) {
        [self.rootView showLoadingViewWithDefaultMessageAnimated:YES];
    }
    
    UIRefreshControl *refresh = [UIRefreshControl new];
    refresh.attributedTitle = [[NSAttributedString alloc] initWithString:@"PULL TO REFRESH"];
    [refresh addTarget:self action:@selector(refreshView:) forControlEvents:UIControlEventValueChanged];
    [self.rootView.tableView addSubview:refresh];
}

- (void)refreshView:(UIRefreshControl *)refreshControl {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MMM d, h:mm a"];
    NSString *title = [NSString stringWithFormat:@"Last update: %@", [formatter stringFromDate:[NSDate date]]];
    NSDictionary *attrsDictionary = [NSDictionary dictionaryWithObject:[UIColor blackColor]
                                                                forKey:NSForegroundColorAttributeName];
    NSAttributedString *attributedTitle = [[NSAttributedString alloc] initWithString:title attributes:attrsDictionary];
    refreshControl.attributedTitle = attributedTitle;
    [self.rootView.tableView reloadData];
    
    [refreshControl endRefreshing];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = NO;
    ///////////
    self.navigationController.navigationItem.rightBarButtonItem.image = nil;
}

#pragma mark -
#pragma mark Accessors

AKRootViewAndReturnIfNil(AKLeaguesView)

- (NSString *)navigationItemTitle {
    return kAKLeaguesNavigationItemTitle;
}

- (void)setYear:(NSUInteger)year {
    if (_year != year) {
        _year = year;
        
        self.context = [[AKLeaguesContext alloc] initWithID:_year];
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    AKTeamsViewController *controller = [AKTeamsViewController new];
    controller.league = self.leaguesArray[indexPath.row];
    
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark -
#pragma mark Public

- (void)contextDidLoadWithObject:(NSSet *)leagues {
    self.leaguesArray = [leagues allObjects];
    AKLeaguesView *rootView = self.rootView;
    [rootView.tableView reloadData];
    [self.rootView removeLoadingViewAnimated:YES];
}

- (void)contextDidFailToLoad:(NSSet *)leagues {
    [super contextDidFailToLoad:leagues];
    self.leaguesArray = [leagues allObjects];
    AKLeaguesView *rootView = self.rootView;
    [rootView.tableView reloadData];
    [self.rootView removeLoadingViewAnimated:YES];
}

@end
