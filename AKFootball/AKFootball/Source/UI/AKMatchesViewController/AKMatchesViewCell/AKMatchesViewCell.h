//
//  AKMatchesViewCell.h
//  AKFootball
//
//  Created by Admin on 13.07.16.
//  Copyright © 2016 Karpov Andrey. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AKMatch;

@interface AKMatchesViewCell : UITableViewCell
@property (nonatomic, strong) IBOutlet  UILabel        *firstTeamLabel;
@property (nonatomic, strong) IBOutlet  UILabel        *secongTeamLabel;
@property (nonatomic, strong) IBOutlet  UILabel        *resultLabel;

- (void)fillWithModel:(AKMatch *)match;

@end
