//
//  AKMatchesViewCell.m
//  AKFootball
//
//  Created by Admin on 13.07.16.
//  Copyright © 2016 Karpov Andrey. All rights reserved.
//

#import "AKMatchesViewCell.h"
#import "AKMatch.h"

@implementation AKMatchesViewCell

- (void)fillWithModel:(AKMatch *)match {
    self.firstTeamLabel.text = match.homeTeam;
    self.secongTeamLabel.text = match.awayTeam;
    if ([match.status isEqualToString:@"FINISHED"]) {
        self.resultLabel.text = [NSString stringWithFormat:@"%@ : %@", match.goalsHomeTeam, match.goalsAwayTeam];
    } else {
        self.resultLabel.text = [match.date substringToIndex:10];
    }
}

@end
