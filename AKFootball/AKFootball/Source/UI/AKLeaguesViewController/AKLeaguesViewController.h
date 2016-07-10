//
//  AKLeaguesViewController.h
//  AKFootball
//
//  Created by Admin on 30.06.16.
//  Copyright © 2016 Karpov Andrey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AKCustomViewController.h"

@class AKLeague;

@interface AKLeaguesViewController : AKCustomViewController <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong)   AKLeague            *league;
@property (nonatomic, assign)   NSUInteger          year;

@end
