//
//  AKMatchesViewCell.m
//  AKFootball
//
//  Created by Admin on 13.07.16.
//  Copyright © 2016 Karpov Andrey. All rights reserved.
//

#import "AKMatchesViewCell.h"
#import "AKMatch.h"
#import "AKFootballConstants.h"

@implementation AKMatchesViewCell

#pragma mark -
#pragma mark Public

- (void)fillWithModel:(AKMatch *)match {
    self.firstTeamLabel.text = match.homeTeam;
    self.secongTeamLabel.text = match.awayTeam;
    if ([match.status isEqualToString:kAKFinishedKey]) {
        self.resultLabel.text = [NSString stringWithFormat:@"%@ : %@", match.goalsHomeTeam,
                                                                       match.goalsAwayTeam];
        self.dateLabel.text = [match.date substringToIndex:kAKMatchDateSubstring];
    } else {
        self.resultLabel.text = [match.date substringToIndex:kAKMatchDateSubstring];
    }
}

@end
