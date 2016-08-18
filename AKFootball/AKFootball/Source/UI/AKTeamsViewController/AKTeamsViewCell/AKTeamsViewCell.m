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
#import "AKFootballConstants.h"

@implementation AKTeamsViewCell

#pragma mark -
#pragma mark Public

- (void)fillWithModel:(AKTeam *)team {
    self.cellLabel.text = team.name;
    if (team.pictureURLPath == nil) {
        self.customImageView.image = [UIImage imageNamed:kAKNoLogoImageName];
    } else {
        NSString *imageFullName = team.pictureURLPath.lastPathComponent;
        self.customImageView.image = [UIImage imageNamed:[imageFullName substringToIndex:
                                                          [imageFullName length] - kAKImageSubstringSubstring]];
    }
}

@end