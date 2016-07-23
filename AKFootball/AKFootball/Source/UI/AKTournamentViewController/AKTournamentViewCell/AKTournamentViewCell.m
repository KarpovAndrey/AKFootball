//
//  AKTournamentViewCell.m
//  AKFootball
//
//  Created by Admin on 16.07.16.
//  Copyright © 2016 Karpov Andrey. All rights reserved.
//

#import "AKTournamentViewCell.h"
#import "AKTeam.h"

static CGFloat const kAKBorderCornerRadius = 50.0f;

@implementation AKTournamentViewCell

#pragma mark -
#pragma mark Public

- (void)fillWithModel:(AKTeam *)team {
    [self.teamPositionLabel addDefaultBorderWithCornerRadius:kAKBorderCornerRadius];
    [self.teamNameLabel addDefaultBorder];
    [self.teamPointsLabel addDefaultBorder];
    
    self.teamPositionLabel.text = [NSString stringWithFormat:@"%@", team.position] ;
    self.teamNameLabel.text = [NSString stringWithFormat:@" %@", team.name];
    self.teamPointsLabel.text = [NSString stringWithFormat:@"%@", team.points];
}

@end
