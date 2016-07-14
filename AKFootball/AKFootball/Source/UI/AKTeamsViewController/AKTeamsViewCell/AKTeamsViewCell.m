//
//  AKTeamsViewCell.m
//  AKFootball
//
//  Created by Admin on 11.07.16.
//  Copyright © 2016 Karpov Andrey. All rights reserved.
//

#import "AKTeamsViewCell.h"
#import "AKTeam.h"
#import "AKImageView.h"

@implementation AKTeamsViewCell

- (void)fillWithModel:(AKTeam *)team {
    self.cellLabel.text = team.name;
//    NSString *URLString = team.pictureURLPath;
//    if ([[URLString substringFromIndex:[URLString length] - 3]  isEqual: @"svg"]) {
//        NSLog(@"EQUAL");
//        return;
//    }
//    self.cellImageView.URL = [NSURL URLWithString:team.pictureURLPath];
}

@end
