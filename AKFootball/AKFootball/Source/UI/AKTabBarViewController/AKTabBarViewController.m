//
//  AKTabBarViewController.m
//  AKFootball
//
//  Created by Admin on 18.07.16.
//  Copyright © 2016 Karpov Andrey. All rights reserved.
//

#import "AKTabBarViewController.h"
#import "AKTabBarView.h"
#import "AKLeague.h"
#import "AKTeamsViewController.h"
#import "AKMatchesViewController.h"
#import "AKTournamentViewController.h"

@interface AKTabBarViewController ()

@end

@implementation AKTabBarViewController

#pragma mark -
#pragma mark Accessors

AKRootViewAndReturnIfNil(AKTabBarView)

- (void)setLeague:(AKLeague *)league {
    if (_league != league) {
        _league = league;
        
        AKTeamsViewController *teamsController = [AKTeamsViewController new];
        teamsController.league = self.league;

        AKMatchesViewController *matchesController = [AKMatchesViewController new];
        matchesController.league = self.league;
        
        AKTournamentViewController *tournamentController = [AKTournamentViewController new];
        tournamentController.league = self.league;

        self.controllersCollection = [NSArray arrayWithObjects:teamsController,
                                                               matchesController,
                                                               tournamentController, nil];
    }
}

@end
