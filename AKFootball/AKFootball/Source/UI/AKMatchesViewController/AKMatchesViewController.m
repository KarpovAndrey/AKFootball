//
//  AKMatchesViewController.m
//  AKFootball
//
//  Created by Admin on 01.07.16.
//  Copyright © 2016 Karpov Andrey. All rights reserved.
//

#import "AKMatchesViewController.h"
#import "AKMatchesView.h"
#import "AKMatchesViewCell.h"
#import "AKMatchContext.h"
#import "AKLeague.h"
#import "AKMatch.h"
#import "AKTournamentViewController.h"
#import "AKFootballConstants.h"

@interface AKMatchesViewController ()
@property (nonatomic, readonly) AKMatchesView           *rootView;
@property (nonatomic, strong)   NSMutableArray          *arrayMatches;

- (void)loadWithObject:(id)object;

@end

@implementation AKMatchesViewController

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

AKRootViewAndReturnIfNil(AKMatchesView)

- (void)setLeague:(AKLeague *)league {
    if (_league != league) {
        _league = league;
        
        self.context = [[AKMatchContext alloc] initWithID:_league.ID];
    }
}

- (NSString *)navigationItemTitle {
    return kAKMatchesNavigationItemTitle;
}

#pragma mark -
#pragma mark UITableViewDataSource Protocol

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSDictionary *dictionary = [self.arrayMatches objectAtIndex:section];
    return [[dictionary valueForKey:kAKMatchesKey] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AKMatchesViewCell *cell = [tableView dequeueCellFromNibWithClass:[AKMatchesViewCell class]];
    NSDictionary *currentSection = [self.arrayMatches objectAtIndex:indexPath.section];
    NSArray *matches = [currentSection objectForKey:kAKMatchesKey];
    [cell fillWithModel:matches[indexPath.row]];
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.arrayMatches.count;
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [self.arrayMatches[section] objectForKey:kAKTitleKey];
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    // 1. The view for the header
    UIView* headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 20, tableView.frame.size.width, 10)];
    
    // 3. Add a label
    UILabel *headerLabel = [[UILabel alloc] init];
    headerLabel.frame = CGRectMake(0, 30, tableView.frame.size.width, 20);
    headerLabel.backgroundColor = [UIColor clearColor];
    headerLabel.textColor = [UIColor brownColor];
    headerLabel.font = [UIFont boldSystemFontOfSize:17.0];
    headerLabel.text = [self.arrayMatches[section] objectForKey:kAKTitleKey];
    headerLabel.textAlignment = NSTextAlignmentCenter;
    
    // 4. Add the label to the header view
    [headerView addSubview:headerLabel];
    
    return headerView;
}

///////////////////////need to delete whet tab bar will ready
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    AKTournamentViewController *controller = [AKTournamentViewController new];
    controller.league = self.league;
    
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark -
#pragma mark Public

- (void)contextDidLoadWithObject:(NSSet *)matches {
    [self loadWithObject:matches];
}

- (void)contextDidFailToLoad:(NSSet *)matches {
    [super contextDidFailToLoad:matches];
    [self loadWithObject:matches];
}

#pragma mark -
#pragma mark Private

- (void)loadWithObject:(NSSet *)matches {
    NSMutableArray *finishedMatches = [NSMutableArray new];
    NSMutableArray * sheduledMatches = [NSMutableArray new];
    
    for (AKMatch *match in [matches allObjects]) {
        if ([match.status isEqualToString:kAKFinishedKey]) {
            [finishedMatches addObject:match];
            
        } else {
            [sheduledMatches addObject:match];
        }
    }
    
    self.arrayMatches = [NSMutableArray new];
    
    if (finishedMatches.count != 0) {
        NSMutableDictionary *finishedMatchesDictionary = [NSMutableDictionary dictionary];
        [finishedMatchesDictionary setObject:finishedMatches forKey:kAKMatchesKey];
        [finishedMatchesDictionary setObject:kAKFinishedMatchesKey forKey:kAKTitleKey];
        
        [self.arrayMatches addObject:finishedMatchesDictionary];
    }
    
    if (sheduledMatches.count != 0) {
        NSMutableDictionary *sheduledMatchesDictionary = [NSMutableDictionary dictionary];
        [sheduledMatchesDictionary setObject:sheduledMatches forKey:kAKMatchesKey];
        [sheduledMatchesDictionary setObject:kAKShedulededMatchesKey forKey:kAKTitleKey];
        
        [self.arrayMatches addObject:sheduledMatchesDictionary];
    }
    
    AKMatchesView *rootView = self.rootView;
    [rootView.tableView reloadData];
    [self.rootView removeLoadingViewAnimated:YES];
}

@end
