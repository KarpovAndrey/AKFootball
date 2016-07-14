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

static NSString * const kAKNavigationItemTitle = @"TEAMS";

@interface AKTeamsViewController ()
@property (nonatomic, readonly) AKTeamsView     *rootView;
@property (nonatomic, strong)   NSArray         *teamsArray;

@end

@implementation AKTeamsViewController

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
    return kAKNavigationItemTitle;
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
///////////////////////
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    AKMatchesViewController *controller = [AKMatchesViewController new];
    controller.league = self.league;
    
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark -
#pragma mark Public

- (void)objectDidLoadWithObject:(NSSet *)teams {
    self.teamsArray = [teams allObjects];
    AKTeamsView *rootView = self.rootView;
    [rootView.tableView reloadData];
    [self.rootView removeLoadingViewAnimated:YES];
}

- (void)objectDidFailToLoad:(NSSet *)teams {
    [super objectDidFailToLoad:teams];
    self.teamsArray = [teams allObjects];
    AKTeamsView *rootView = self.rootView;
    [rootView.tableView reloadData];
    [self.rootView removeLoadingViewAnimated:YES];
}

@end
