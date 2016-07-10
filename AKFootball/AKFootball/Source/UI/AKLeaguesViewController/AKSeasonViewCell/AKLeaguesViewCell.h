//
//  AKLeaguesViewCell.h
//  AKFootball
//
//  Created by Admin on 29.06.16.
//  Copyright © 2016 Karpov Andrey. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AKLeague;

@interface AKLeaguesViewCell : UITableViewCell
@property (nonatomic, strong) IBOutlet UILabel        *cellLabel;

- (void)fillWithModel:(AKLeague *)league;

@end
