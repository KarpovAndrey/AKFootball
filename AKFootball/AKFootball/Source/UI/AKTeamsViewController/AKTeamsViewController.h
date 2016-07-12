//
//  AKTeamsViewController.h
//  AKFootball
//
//  Created by Admin on 01.07.16.
//  Copyright © 2016 Karpov Andrey. All rights reserved.
//

#import "AKCustomViewController.h"

@class AKLeague;
@class AKTeamContext;

@interface AKTeamsViewController : AKCustomViewController <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong)   AKLeague        *league;

@end
