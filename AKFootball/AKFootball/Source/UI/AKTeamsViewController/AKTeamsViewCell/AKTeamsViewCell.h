//
//  AKTeamsViewCell.h
//  AKFootball
//
//  Created by Admin on 11.07.16.
//  Copyright © 2016 Karpov Andrey. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AKTeam;

@interface AKTeamsViewCell : UITableViewCell
@property (nonatomic, strong) IBOutlet  UILabel        *cellLabel;
@property (nonatomic, strong) IBOutlet  UIImageView    *customImageView;

- (void)fillWithModel:(AKTeam *)team;

@end