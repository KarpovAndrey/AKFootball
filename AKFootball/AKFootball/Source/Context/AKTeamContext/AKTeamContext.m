//
//  AKTeamContext.m
//  AKFootball
//
//  Created by Admin on 11.07.16.
//  Copyright © 2016 Karpov Andrey. All rights reserved.
//

#import "IDPActiveRecordKit.h"

#import "AKTeamContext.h"
#import "AKLeague.h"
#import "AKTeam.h"
#import "AKSeason.h"
#import "AKFootballConstants.h"

@implementation AKTeamContext

#pragma mark -
#pragma mark Accessors

- (NSString *)contextURLString {
    NSString *teamsURLString = [kAKFootballURLString stringByAppendingString:
                                                [NSString stringWithFormat:@"%li", self.ID]];

    return [teamsURLString stringByAppendingString:kAKTeamsPathKey];
}

#pragma mark -
#pragma mark Public

- (void)parseData:(NSDictionary *)result {
    AKLeague *league = [AKLeague objectWithID:self.ID];
    
    NSArray *dictionary = [result valueForKey:kAKTeamsKey];
    for (NSDictionary *teamDictionary in dictionary) {
        NSDictionary *linksDictionary = [teamDictionary valueForKey:kAKLinksKey];
        NSArray *selfArray = [linksDictionary valueForKey:kAKSelfKey];
        NSString *stringID = [selfArray valueForKey:kAKHrefKey];
        NSUInteger integerID = [[stringID lastPathComponent] integerValue];
        
        AKTeam *team = [AKTeam objectWithID:integerID];
        team.pictureURLPath = [teamDictionary valueForKey:kAKCrestURLKey];
        team.name = [teamDictionary valueForKey:kAKNameKey];
        [league addTeamsObject:team];
    }
    
    self.season = [AKSeason objectWithID:league.year];
    [self.season addLeaguesObject:league];
    [self setState:kAKModelLoadedState withObject:league.teams];
}

- (void)loadObject {
    AKLeague *league = [AKLeague objectWithID:self.ID];
    [self setState:kAKModelFailedState withObject:league.teams];
}

@end
