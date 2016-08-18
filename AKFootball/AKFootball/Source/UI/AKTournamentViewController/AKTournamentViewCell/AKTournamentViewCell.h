//
//  AKTournamentViewCell.h
//  AKFootball
//
//  Created by Admin on 16.07.16.
//  Copyright © 2016 Karpov Andrey. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AKTeam;

@interface AKTournamentViewCell : UITableViewCell
@property (nonatomic, strong) IBOutlet  UILabel        *teamPositionLabel;
@property (nonatomic, strong) IBOutlet  UILabel        *teamNameLabel;
@property (nonatomic, strong) IBOutlet  UILabel        *teamPointsLabel;
@property (nonatomic, strong) IBOutlet  UIImageView    *teamImageLogo;

- (void)fillWithModel:(AKTeam *)team;

@end
