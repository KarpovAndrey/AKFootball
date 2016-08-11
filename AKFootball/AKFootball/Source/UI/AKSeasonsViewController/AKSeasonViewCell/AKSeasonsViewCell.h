//
//  AKSeasonsViewCell.h
//  AKFootball
//
//  Created by Admin on 29.06.16.
//  Copyright © 2016 Karpov Andrey. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AKSeasonsViewCell : UITableViewCell
@property (nonatomic, strong) IBOutlet UILabel        *seasonLabel;
@property (nonatomic, strong) IBOutlet UILabel        *yearLabel;

- (void)fillWithModel:(NSString *)year;

@end
