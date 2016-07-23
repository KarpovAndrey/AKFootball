//
//  AKTabBarView.h
//  AKFootball
//
//  Created by Admin on 18.07.16.
//  Copyright © 2016 Karpov Andrey. All rights reserved.
//

#import "AKView.h"

@interface AKTabBarView : AKView
@property (nonatomic, strong) IBOutlet UIButton    *matchesButton;
@property (nonatomic, strong) IBOutlet UIButton    *teamsButton;
@property (nonatomic, strong) IBOutlet UIButton    *tournamentButton;

- (IBAction)onMatchesButtonClick:(id)sender;
- (IBAction)onTeamesButtonClick:(id)sender;
- (IBAction)onTournamentButtonClick:(id)sender;

@end
