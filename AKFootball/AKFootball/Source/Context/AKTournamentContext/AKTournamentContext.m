//
//  AKTournamentContext.m
//  AKFootball
//
//  Created by Admin on 16.07.16.
//  Copyright © 2016 Karpov Andrey. All rights reserved.
//

#import "IDPActiveRecordKit.h"

#import "AKTournamentContext.h"
#import "AKLeague.h"
#import "AKSeason.h"
#import "AKTeam.h"
#import "AKFootballConstants.h"

@implementation AKTournamentContext

#pragma mark -
#pragma mark Accessors

- (NSString *)appendingURLString {
    NSString *teamsURLString = [kAKFootballURLString stringByAppendingString:
                                [NSString stringWithFormat:@"%li", self.ID]];
    
    return [teamsURLString stringByAppendingString:kAKLeagueTablePathKey];
}

#pragma mark -
#pragma mark Public

- (void)parseData:(NSDictionary *)result {
    AKLeague *league = [AKLeague objectWithID:self.ID];
    
    NSArray *array = [result valueForKey:kAKStandingKey];
    for (NSDictionary *teamDictionary in array) {
        NSArray *array = [teamDictionary valueForKey:kAKLinksKey];
        NSDictionary *dictionary = [array valueForKey:kAKTeamKey];
        NSString *string = [dictionary valueForKey:kAKHrefKey];
        NSUInteger integerID = [[string lastPathComponent] integerValue];
        AKTeam *team = [AKTeam objectWithID:integerID];
        team.points = [teamDictionary valueForKey:kAKPointsKey];
        team.position = [teamDictionary valueForKey:kAKPositionKey];
        [league addTeamsObject:team];
    }
    
    self.season = [AKSeason objectWithID:league.year];
    [self.season addLeaguesObject:league];
    [self setState:kAKModelLoadedState withObject:league.teams];
}

- (void)loadObject {
    AKLeague *league = [AKLeague objectWithID:league.ID];
    [self setState:kAKModelFailedState withObject:league.teams];
}

@end
