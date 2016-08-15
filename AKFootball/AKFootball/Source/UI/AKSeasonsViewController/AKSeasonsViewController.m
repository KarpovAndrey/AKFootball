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
#import "AKFootballConstants.h"

@interface AKSeasonsViewController ()
@property (nonatomic, readonly) AKSeasonsView           *rootView;
@property (nonatomic, strong)   NSArray                 *yearsArray;

- (NSArray *)generateYearsArray;

@end

@implementation AKSeasonsViewController

#pragma mark -
#pragma mark Accessors

AKRootViewAndReturnIfNil(AKSeasonsView);

#pragma mark -
#pragma mark View LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = YES;
    self.yearsArray = [self generateYearsArray];
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
    [self.rootView showLoadingViewWithDefaultMessageAnimated:YES];
    [self.rootView.tableView reloadData];
    [super refreshTable];
    [self.rootView removeLoadingViewAnimated:YES];
}

@end
