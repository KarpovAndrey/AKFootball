//
//  AKSeasonsViewController.m
//  AKFootball
//
//  Created by Admin on 29.06.16.
//  Copyright © 2016 Karpov Andrey. All rights reserved.
//

#import "AKSeasonsViewController.h"
#import "AKSeasonsView.h"
#import "AKSeasonsViewCell.h"

#import "AKLeaguesViewController.h"
#import "AKLeague.h"

static NSUInteger const kAKYearInterval =   1;
static NSString * const kAKDateFormat   =   @"yyyy";

@interface AKSeasonsViewController ()
@property (nonatomic, readonly) AKSeasonsView           *rootView;
@property (nonatomic, strong)   NSArray                 *yearsArray;
@property (nonatomic, strong)   UIRefreshControl        *refreshControl;

- (NSArray *)generateYearsArray;
- (void)refreshTable;

@end

@implementation AKSeasonsViewController

#pragma mark -
#pragma mark Accessors

AKRootViewAndReturnIfNil(AKSeasonsView);

#pragma mark -
#pragma mark View LifeCycle


- (void)viewDidLoad {
    [super viewDidLoad];
    
//    UIRefreshControl *refreshControl = [UIRefreshControl new];
//    [self.rootView.tableView addSubview:refreshControl];
//    self.refreshControl = refreshControl;
    UIRefreshControl *refreshControl = [UIRefreshControl new];
    [self.rootView.tableView addSubview:refreshControl];
    [refreshControl addTarget:self action:@selector(refreshTable) forControlEvents:UIControlEventValueChanged];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = YES;
    self.yearsArray = [self generateYearsArray];
    [self.refreshControl beginRefreshing];
}

#pragma mark -
#pragma mark UITableViewDataSource Protocol

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.yearsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AKSeasonsViewCell *cell = [tableView dequeueCellFromNibWithClass:[AKSeasonsViewCell class]];
    [cell fillWithModel:self.yearsArray[indexPath.row]];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    AKLeaguesViewController *controller = [AKLeaguesViewController new];
    NSUInteger year = [self.yearsArray[indexPath.row] integerValue];
    controller.year = year;
//    controller.user = self.friends[indexPath.row];
//    [self performTransition];
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark -
#pragma mark Private

- (NSArray *)generateYearsArray {
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setDateFormat:kAKDateFormat];
    NSString *yearString = [formatter stringFromDate:[NSDate date]];
    NSInteger integerDate = [yearString integerValue];
    NSMutableArray *array = [NSMutableArray new];
    for (NSUInteger indexValue = integerDate - kAKYearInterval; indexValue <= integerDate; indexValue++) {
        [array addObject:@(indexValue)];
    }
    
    return [array mutableCopy];
}

- (void)refreshTable {
    //TODO: refresh your data
    [self.rootView.tableView reloadData];
    [self.refreshControl endRefreshing];
}

@end
