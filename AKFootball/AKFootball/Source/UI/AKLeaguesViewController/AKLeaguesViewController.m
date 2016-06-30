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

static NSString * const kAKNavigationItemTitle      = @"LEAGUES";

@interface AKLeaguesViewController ()
@property (nonatomic, readonly) AKLeaguesView   *rootView;

@end

@implementation AKLeaguesViewController

#pragma mark -
#pragma mark View LifeCycle

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = NO;
    self.navigationItem.rightBarButtonItem = nil;
//    ///////////////////////////////
}

#pragma mark -
#pragma mark Accessors

AKRootViewAndReturnIfNil(AKLeaguesView)

- (NSString *)navigationItemTitle {
    return kAKNavigationItemTitle;
}

#pragma mark -
#pragma mark UITableViewDataSource Protocol

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AKLeaguesViewCell *cell = [tableView dequeueCellFromNibWithClass:[AKLeaguesViewCell class]];
//    [cell fillWithModel:self.yearsArray[indexPath.row]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    AKLeaguesViewController *controller = [AKLeaguesViewController new];
//    //    [self performTransition];
//    [self.navigationController pushViewController:controller animated:YES];
}

@end
