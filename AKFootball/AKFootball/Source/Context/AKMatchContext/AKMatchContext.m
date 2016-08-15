//
//  AKMatchContext.m
//  AKFootball
//
//  Created by Admin on 13.07.16.
//  Copyright © 2016 Karpov Andrey. All rights reserved.
//

#import "IDPActiveRecordKit.h"
#import "AKMatchContext.h"
#import "AKSeason.h"
#import "AKLeague.h"
#import "AKMatch.h"
#import "AKFootballConstants.h"

@implementation AKMatchContext

#pragma mark -
#pragma mark Accessors

- (NSString *)contextURLString {
    NSString *matchURLString = [kAKFootballURLString stringByAppendingString:
                                               [NSString stringWithFormat:@"%li", (unsigned long)self.ID]];

    return [matchURLString stringByAppendingString:kAKFixturesPathKey];
}

#pragma mark -
#pragma mark Public

- (void)parseData:(NSDictionary *)result {
    AKLeague *league = [AKLeague objectWithID:self.ID];
    NSArray *arrayMatches = [result valueForKey:kAKFixturesKey];
    for (NSDictionary *dictionary in arrayMatches) {
        NSDictionary *newDictionary = [dictionary valueForKey:kAKLinksKey];
        NSDictionary *selfDictionary = [newDictionary valueForKey:kAKSelfKey];
        NSUInteger integerID = [[[selfDictionary valueForKey:kAKHrefKey] lastPathComponent] integerValue];
        
        AKMatch *match = [AKMatch objectWithID:integerID];
        NSArray *matchResult = [dictionary valueForKey:kAKResultKey];
        match.date = [dictionary valueForKey:kAKDateKey];
        match.homeTeam = [dictionary valueForKey:kAKHomeTeamNameKey];
        match.awayTeam = [dictionary valueForKey:kAKHomeTeamNameKey];
        match.status = [dictionary valueForKey:kAKStatusKey];
        if ([match.status isEqualToString:kAKFinishedKey]) {
            match.goalsHomeTeam = [matchResult valueForKey:kAKGoalsHomeTeamNameKey];
            match.goalsAwayTeam = [matchResult valueForKey:kAKGoalsAwayTeamNameKey];
        }

        [league addMatchesObject:match];
    }
    
    self.season = [AKSeason objectWithID:league.year];
    [self.season addLeaguesObject:league];
    [self setState:kAKModelLoadedState withObject:league.matches];
}

- (void)loadObject {
    AKLeague *league = [AKLeague objectWithID:self.ID];
    [self setState:kAKModelFailedState withObject:league.teams];
}

@end
