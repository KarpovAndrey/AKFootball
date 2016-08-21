//
//  AKTournamentViewCell.m
//  AKFootball
//
//  Created by Admin on 16.07.16.
//  Copyright © 2016 Karpov Andrey. All rights reserved.
//

#import "AKTournamentViewCell.h"
#import "AKTeam.h"
#import "AKFootballConstants.h"

static CGFloat const kAKBorderCornerRadius = 50.0f;
static CGFloat const kAKBorderWidth = 1.0f;

#define kAKBorderColor [UIColor colorWithRedColor:80.0 greenColor:17.0 blueColor:98.0 alpha:1.0]

@implementation AKTournamentViewCell

#pragma mark -
#pragma mark Public

- (void)fillWithModel:(AKTeam *)team {
    [self.teamNameLabel addDefaultBorderWithColor:kAKBorderColor];
    [self.teamPointsLabel addDefaultBorderWithColor:kAKBorderColor];
    [self.teamImageLogo addDefaultBorderWithColor:kAKBorderColor];
    [self.teamPositionLabel addBorderWithColor:kAKBorderColor
                                         width:kAKBorderWidth
                                  cornerRadius:kAKBorderCornerRadius];
    
    NSString *imageFullName = team.pictureURLPath.lastPathComponent;
    NSString *currentImageName = [imageFullName substringToIndex:
                                  [imageFullName length] - kAKImageSubstringFull];
    self.teamPositionLabel.text = [NSString stringWithFormat:@"%@", team.position] ;
    self.teamNameLabel.text = [NSString stringWithFormat:@" %@", team.name];
    self.teamPointsLabel.text = [NSString stringWithFormat:@"%@", team.points];
    
    if ([[currentImageName substringFromIndex:[currentImageName length] - kAKImageSubstringShort]
         isEqualToString:kAKSVGString]) {
        self.teamImageLogo.image = [UIImage imageNamed:kAKNoLogoImageName];
    } else {
        self.teamImageLogo.image = [UIImage imageNamed:currentImageName];
    }
}

//- (void)fillWithModel:(AKTeam *)team {
//    self.cellLabel.text = team.name;
//    if (team.pictureURLPath == nil) {
//        self.customImageView.image = [UIImage imageNamed:kAKNoLogoImageName];
//    } else {
//        NSString *imageFullName = team.pictureURLPath.lastPathComponent;
//        NSString *currentImageName = [imageFullName substringToIndex:
//                                      [imageFullName length] - kAKImageSubstringFull];
//        if ([[currentImageName substringFromIndex:[currentImageName length] - kAKImageSubstringShort]
//             isEqualToString:kAKSVGString]) {
//            self.customImageView.image = [UIImage imageNamed:kAKNoLogoImageName];
//        } else {
//            self.customImageView.image = [UIImage imageNamed:currentImageName];
//        }
//    }
//}

@end
