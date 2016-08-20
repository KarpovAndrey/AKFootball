//
//  AKTeamsView.h
//  AKFootball
//
//  Created by Admin on 01.07.16.
//  Copyright © 2016 Karpov Andrey. All rights reserved.
//

#import "AKView.h"
#import "AKTabBarView.h"

@interface AKTeamsView : AKView
@property (nonatomic, strong) IBOutlet UITableView                            *tableView;
@property (nonatomic, strong) IBOutlet AKTabBarView                           *tabBarView;

@property (nonatomic, strong) IBOutlet UIButton    *matchesButton;
@property (nonatomic, strong) IBOutlet UIButton    *teamsButton;
@property (nonatomic, strong) IBOutlet UIButton    *tournamentButton;
@property (nonatomic, strong) IBOutlet UIView      *customView;



@end
