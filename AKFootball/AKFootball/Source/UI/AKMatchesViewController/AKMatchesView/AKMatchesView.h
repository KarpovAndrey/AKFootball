//
//  AKMatchesView.h
//  AKFootball
//
//  Created by Admin on 01.07.16.
//  Copyright © 2016 Karpov Andrey. All rights reserved.
//

#import "AKView.h"
#import "AKTabBarView.h"

@interface AKMatchesView : AKView
@property (nonatomic, strong) IBOutlet UITableView              *tableView;
@property (nonatomic, strong) IBOutlet AKTabBarView             *tabBarView;

@end
