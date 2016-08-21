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
        self.rootView.teamsButton.selected = YES;
        self.rootView.currentView.hidden = YES;
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
        if (currentViewControllerIndex == 0) {
            self.rootView.currentView.hidden = YES;
        } else {
            self.rootView.currentView.hidden = NO;
            
            UIView *view = [self.customTabBarController.controllersCollection[currentViewControllerIndex] view];
            [self.rootView.currentView addSubview:view];
            view.frame = CGRectMake(0, 0, self.rootView.frame.size.width, self.rootView.frame.size.height - self.rootView.tabBarView.frame.size.height);
        }
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
    self.currentViewControllerIndex = kAKMatchesControllerNumber;
    self.rootView.teamsButton.selected = NO;
    self.rootView.tournamentButton.selected = NO;
    self.rootView.matchesButton.selected = YES;
}

- (IBAction)onTournamentButtonClick:(id)sender {
    self.currentViewControllerIndex = kAKTournamentControllerNumber;
    self.rootView.teamsButton.selected = NO;
    self.rootView.matchesButton.selected = NO;
    self.rootView.tournamentButton.selected = YES;
}

- (IBAction)onTeamsButtonClick:(id)sender {
    self.currentViewControllerIndex = kAKTeamsControllerNumber;
    self.rootView.tournamentButton.selected = NO;
    self.rootView.matchesButton.selected = NO;
    self.rootView.teamsButton.selected = YES;
}

@end
