//
//  AKMatchContext.m
//  AKFootball
//
//  Created by Admin on 13.07.16.
//  Copyright © 2016 Karpov Andrey. All rights reserved.
//

#import "AKMatchContext.h"
#import "AKLeague.h"
#import "AKMatch.h"

static NSString * const kAKMatchURLString   = @"http://api.football-data.org/v1/soccerseasons/";
static NSString * const kAKFixturesKey      = @"/fixtures";

@implementation AKMatchContext

#pragma mark -
#pragma mark Initialization & Deallocation

- (instancetype)initWithID:(NSUInteger)ID {
    self = [super init];
    if (self) {
        self.ID = ID;
    }
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (NSString *)contextURLString {
    return kAKMatchURLString;
}

- (NSString *)appendingURLString {
    NSString *matchURLString = [kAKMatchURLString stringByAppendingString:
                                               [NSString stringWithFormat:@"%li", self.ID]];

    return [matchURLString stringByAppendingString:kAKFixturesKey];
}

#pragma mark -
#pragma mark Public

- (void)parseData:(NSDictionary *)result {
    self.league = [AKLeague objectWithID:self.ID];
    NSMutableArray *arrayMatches = [result valueForKey:@"fixtures"];
    NSLog(@"%@", arrayMatches);
    for (NSDictionary *dictionary in arrayMatches) {
        NSDictionary *newDictionary = [dictionary valueForKey:@"_links"];
        NSDictionary *selfDictionary = [newDictionary valueForKey:@"self"];
        NSString *stringID = [selfDictionary valueForKey:@"href"];
        NSUInteger integerID = [[stringID lastPathComponent] integerValue];
        NSLog(@"%li", integerID);
        AKMatch *match = [AKMatch objectWithID:integerID];
        NSArray *matchResult = [dictionary valueForKey:@"result"];
        match.date = [dictionary valueForKey:@"date"];
        match.homeTeam = [dictionary valueForKey:@"homeTeamName"];
        match.awayTeam = [dictionary valueForKey:@"awayTeamName"];
        match.status = [dictionary valueForKey:@"status"];
        if ([match.status isEqualToString:@"FINISHED"]) {
            match.goalsHomeTeam = [matchResult valueForKey:@"goalsHomeTeam"];
            match.goalsAwayTeam = [matchResult valueForKey:@"goalsAwayTeam"];
        }

        [self.league addMathesObject:match];
    }

    [self setState:kAKModelLoadedState withObject:self.league.mathes];
}

- (void)saveObject {
//    [self.league saveManagedObject];
}

- (void)loadObject {
//    self.league = [AKLeague objectWithID:self.league.ID];
//    [self setState:kAKModelFailedState withObject:self.league.teams];
}

@end
