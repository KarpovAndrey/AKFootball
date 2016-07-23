//
//  AKTournamentViewController.h
//  AKFootball
//
//  Created by Admin on 01.07.16.
//  Copyright © 2016 Karpov Andrey. All rights reserved.
//

#import "AKCustomViewController.h"

@class AKLeague;

@interface AKTournamentViewController : AKCustomViewController <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong)   AKLeague    *league;

@end
