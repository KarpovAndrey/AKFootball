//
//  AKLeaguesViewController.h
//  AKFootball
//
//  Created by Admin on 30.06.16.
//  Copyright © 2016 Karpov Andrey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AKCustomViewController.h"

@interface AKLeaguesViewController : AKCustomViewController <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, assign)   NSUInteger          year;

@end
