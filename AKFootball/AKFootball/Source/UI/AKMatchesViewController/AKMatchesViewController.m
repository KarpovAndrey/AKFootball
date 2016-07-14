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


static NSString * const kAKFinishedMatchesTitle     = @"FINISHED MATCHES";
static NSString * const kAKSheduledMatchesTitle     = @"SHEDULED MATCHES";
static NSString * const kAKNavigationItemTitle      = @"MATCHES";

@interface AKMatchesViewController ()
@property (nonatomic, strong)   NSMutableArray        *arrayMatches;

@end

@implementation AKMatchesViewController

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
    return kAKNavigationItemTitle;
}

#pragma mark -
#pragma mark UITableViewDataSource Protocol

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSDictionary *dictionary = [self.arrayMatches objectAtIndex:section];
    return [[dictionary valueForKey:@"matches"] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AKMatchesViewCell *cell = [tableView dequeueCellFromNibWithClass:[AKMatchesViewCell class]];
//    [cell fillWithModel:self.arrayMatches[indexPath.row]];
    NSDictionary *currentSection = [self.arrayMatches objectAtIndex:indexPath.section];
    NSArray *matches = [currentSection objectForKey:@"matches"];
    [cell fillWithModel:matches[indexPath.row]];
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.arrayMatches.count;
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [self.arrayMatches[section] objectForKey:@"title"];
}

#pragma mark -
#pragma mark Public

- (void)objectDidLoadWithObject:(NSSet *)matches {
    NSMutableArray *finishedMatches = [NSMutableArray new];
    NSMutableArray * sheduledMatches = [NSMutableArray new];

    for (AKMatch *match in [matches allObjects]) {
        if ([match.status isEqualToString:@"FINISHED"]) {
            [finishedMatches addObject:match];
        } else {
            [sheduledMatches addObject:match];
        }
    }
    
    NSMutableDictionary *finishedMatchesDictionary = [NSMutableDictionary dictionary];
    [finishedMatchesDictionary setObject:finishedMatches forKey:@"matches"];
    [finishedMatchesDictionary setObject:@"FINISHED MATCHES" forKey:@"title"];
    
    NSMutableDictionary *sheduledMatchesDictionary = [NSMutableDictionary dictionary];
    [sheduledMatchesDictionary setObject:sheduledMatches forKey:@"matches"];
    [sheduledMatchesDictionary setObject:@"SHEDULED MATCHES" forKey:@"title"];
    
    self.arrayMatches = [NSMutableArray new];
    
    if ([[finishedMatchesDictionary valueForKey:@"matches"] count] != 0) {
        [self.arrayMatches addObject:finishedMatchesDictionary];
    }
    
    if ([[sheduledMatchesDictionary valueForKey:@"matches"] count] != 0) {
        [self.arrayMatches addObject:sheduledMatchesDictionary];
    }
    
    AKMatchesView *rootView = self.rootView;
    [rootView.tableView reloadData];
    [self.rootView removeLoadingViewAnimated:YES];
}

//- (void)objectDidFailToLoad:(NSSet *)matches {
//    self.arrayMatches = [matches allObjects];
//    AKMatchesView *rootView = self.rootView;
//    [rootView.tableView reloadData];
//    [self.rootView removeLoadingViewAnimated:YES];
//}

@end
