//
//  AKTeamsViewCell.h
//  AKFootball
//
//  Created by Admin on 11.07.16.
//  Copyright © 2016 Karpov Andrey. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AKTeam;
@class AKImageView;

@interface AKTeamsViewCell : UITableViewCell
@property (nonatomic, strong) IBOutlet  UILabel        *cellLabel;
@property (nonatomic, strong) IBOutlet  AKImageView    *cellImageView;

- (void)fillWithModel:(AKTeam *)team;

@end
