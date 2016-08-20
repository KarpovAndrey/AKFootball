//
//  AKMatchesViewController.h
//  AKFootball
//
//  Created by Admin on 01.07.16.
//  Copyright © 2016 Karpov Andrey. All rights reserved.
//

#import "AKCustomViewController.h"

@class AKLeague;
@class AKTabBarViewController;

@interface AKMatchesViewController : AKCustomViewController <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong)   AKLeague                *league;
@property (nonatomic, strong)   AKTabBarViewController  *customTabBarController;
@property (nonatomic, assign)   NSUInteger              currentViewControllerIndex;

- (IBAction)onTeamsButtonClick:(id)sender;
- (IBAction)onTournamentButtonClick:(id)sender;

@end
