//
//  AKTeamsViewController.m
//  AKFootball
//
//  Created by Admin on 01.07.16.
//  Copyright © 2016 Karpov Andrey. All rights reserved.
//

#import "AKTeamsViewController.h"
#import "AKTeamsViewCell.h"
#import "AKTeamsView.h"
#import "AKLeague.h"
#import "AKTeamContext.h"
#import "AKDispatch.h"
#import "AKMatchesViewController.h"
#import "AKTournamentViewController.h"
#import "AKFootballConstants.h"
#import "AKTabBarViewController.h"
#import "AKView.h"

@interface AKTeamsViewController ()
@property (nonatomic, readonly) AKTeamsView             *rootView;
@property (nonatomic, strong)   NSArray                 *teamsArray;

- (void)loadContextWithObject:(NSSet *)teams;

@end

@implementation AKTeamsViewController

#pragma mark -
#pragma mark View LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (!(self.customTabBarController)) {
        AKTabBarViewController *controller = [AKTabBarViewController new];
        controller.league = self.league;
        [self addChildViewController:controller];
        controller.view.frame = self.rootView.tabBarView.frame;
        [controller didMoveToParentViewController:self];
        self.customTabBarController = controller;
        self.currentViewControllerIndex = 0;
    }
    
    if (self.context.state == kAKModelLoadingState) {
        [self.rootView showLoadingViewWithDefaultMessageAnimated:YES];
    }
    
}

#pragma mark -
#pragma mark Accessors

AKRootViewAndReturnIfNil(AKTeamsView)

- (void)setLeague:(AKLeague *)league {
    if (_league != league) {
        _league = league;
        
        self.context = [[AKTeamContext alloc] initWithID:_league.ID];
    }
}

- (NSString *)navigationItemTitle {
    return kAKTeamsNavigationItemTitle;
}

- (void)setCurrentViewControllerIndex:(NSUInteger)currentViewControllerIndex {
    if (_currentViewControllerIndex != currentViewControllerIndex) {
        _currentViewControllerIndex = currentViewControllerIndex;
        
        UIView *view = [self.customTabBarController.controllersCollection[currentViewControllerIndex] view];
//        [self.view addSubview:view];
        self.rootView.customView = view;
        view.frame = self.rootView.frame;
        [self.view bringSubviewToFront:self.rootView.customView];
    }
}

#pragma mark -
#pragma mark UITableViewDataSource Protocol

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.teamsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AKTeamsViewCell *cell = [tableView dequeueCellFromNibWithClass:[AKTeamsViewCell class]];
    [cell fillWithModel:self.teamsArray[indexPath.row]];
    
    return cell;
}

#pragma mark -
#pragma mark Private

- (void)loadContextWithObject:(NSSet *)teams {
    self.teamsArray = [teams allObjects];
    AKTeamsView *rootView = self.rootView;
    [rootView.tableView reloadData];
    [rootView removeLoadingViewAnimated:YES];
}

#pragma mark -
#pragma mark Public

- (void)contextDidLoadWithObject:(NSSet *)teams {
    [self loadContextWithObject:teams];
}

- (void)contextDidFailToLoad:(NSSet *)teams {
    [super contextDidFailToLoad:teams];
    [self loadContextWithObject:teams];
}

- (void)refreshTable {
    [self.rootView showLoadingViewWithDefaultMessageAnimated:YES];
    self.context = [[AKTeamContext alloc] initWithID:self.league.ID];
    [super refreshTable];
}

#pragma mark -
#pragma mark Handling Interface

- (IBAction)onMatchesButtonClick:(id)sender {
//    AKMatchesViewController *controller = self.customTabBarController.controllersCollection[1];
//    controller.customTabBarController = self.customTabBarController;
////    [self.navigationController pushViewController:controller animated:YES];
//    [self addChildViewController:controller];
//    controller.view.frame = self.rootView.tabBarView.frame;
//    [controller didMoveToParentViewController:self];
//    self.view = controller.view;
    self.currentViewControllerIndex = 1;
}

- (IBAction)onTournamentButtonClick:(id)sender {
    AKTournamentViewController *controller = self.customTabBarController.controllersCollection[2];
    controller.customTabBarController = self.customTabBarController;
//    [self.navigationController pushViewController:controller animated:YES];
    [self.customTabBarController showViewController:controller sender:sender];
}

@end
