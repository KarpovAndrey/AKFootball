//
//  AKTournamentViewController.m
//  AKFootball
//
//  Created by Admin on 01.07.16.
//  Copyright © 2016 Karpov Andrey. All rights reserved.
//

#import "AKTournamentViewController.h"
#import "AKTournamentView.h"
#import "AKTournamentViewCell.h"
#import "AKLeague.h"
#import "AKTournamentContext.h"
#import "AKFootballConstants.h"

@interface AKTournamentViewController ()
@property (nonatomic, readonly) AKTournamentView            *rootView;
@property (nonatomic, strong)   NSArray                     *teamsArray;

- (void)loadContextWithObject:(NSSet *)teams;

@end

@implementation AKTournamentViewController

#pragma mark -
#pragma mark View LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.context.state == kAKModelLoadingState) {
        [self.rootView showLoadingViewWithDefaultMessageAnimated:YES];
    }
}

#pragma mark -
#pragma mark Accessors

AKRootViewAndReturnIfNil(AKTournamentView)

- (void)setLeague:(AKLeague *)league {
    if (_league != league) {
        _league = league;
        
        self.context = [[AKTournamentContext alloc] initWithID:_league.ID];
    }
}

- (NSString *)navigationItemTitle {
    return kAKTournamentNavigationItemTitle;
}

#pragma mark -
#pragma mark UITableViewDataSource Protocol

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.teamsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AKTournamentViewCell *cell = [tableView dequeueCellFromNibWithClass:[AKTournamentViewCell class]];
    [cell fillWithModel:self.teamsArray[indexPath.row]];
    
    return cell;
}

#pragma mark -
#pragma mark Private

- (void)loadContextWithObject:(NSSet *)teams {
    NSArray *arrayTeams = [[teams allObjects] mutableCopy];
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:kAKPointsKey ascending:NO];
    self.teamsArray = [arrayTeams sortedArrayUsingDescriptors:@[sortDescriptor]];
        
    AKTournamentView *rootView = self.rootView;
    [rootView.tableView reloadData];
    [self.rootView removeLoadingViewAnimated:YES];
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
    self.context = [[AKTournamentContext alloc] initWithID:self.league.ID];
    [super refreshTable];
}

@end
