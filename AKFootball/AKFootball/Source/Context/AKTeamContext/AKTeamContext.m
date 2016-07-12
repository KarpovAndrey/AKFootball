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

#define kAKAuthToken @{@"X-Auth-Token": @"f39e518c66d64efd9443fc5e8cef9c3a"}

static NSString * const kAKLeagueURLString  = @"http://api.football-data.org/v1/soccerseasons/";
static NSString * const kAKHTTPMethod       = @"GET";
static NSString * const kAKTeamsString      = @"/teams";

@interface AKTeamContext ()
@property (nonatomic, strong) NSURLSessionDataTask *dataTask;

@end

@implementation AKTeamContext

#pragma mark -
#pragma mark Initialization & Deallocation

- (instancetype)initWithID:(NSUInteger)ID {
    self = [super init];
    if (self) {
        self.league = [AKLeague objectWithID:ID];
        self.ID = ID;
    }
    
    return self;
}

#pragma mark -
#pragma mark Private

- (void)parseData:(NSDictionary *)result {
    self.league = [AKLeague objectWithID:self.ID];
    
    NSArray *dictionary = [result valueForKey:@"teams"];
    for (NSDictionary *teamDictionary in dictionary) {
        //        NSString *code = [teamDictionary valueForKey:@"code"];
        //        NSLog(@"%@", code);
        NSDictionary *array = [teamDictionary valueForKey:@"_links"];
        NSArray *selfDictionary = [array valueForKey:@"self"];
        NSString *dict1 = [selfDictionary valueForKey:@"href"];
        NSString *ID = [dict1 lastPathComponent];
        NSUInteger integerID = [ID integerValue];
        
        AKTeam *team = [AKTeam objectWithID:integerID];
        team.pictureURLPath = [teamDictionary valueForKey:@"crestUrl"];
        team.name = [teamDictionary valueForKey:@"name"];
        [self.league addTeamsObject:team];
    }
    
    [self setState:kAKModelLoadedState withObject:self.league.teams];
}

#pragma mark -
#pragma mark Public

- (void)saveObject {
    [self.league saveManagedObject];
}

- (void)loadObject {
    self.league = [AKLeague objectWithID:self.league.ID];
    [self setState:kAKModelFailedState withObject:self.league.teams];
}

- (NSString *)contextURLString {
    return kAKLeagueURLString;
}

- (NSString *)appendingURLString {
    NSString *teamsURLString = [kAKLeagueURLString stringByAppendingString:[NSString stringWithFormat:@"%li", self.ID]];
    teamsURLString = [teamsURLString stringByAppendingString:kAKTeamsString];
    return teamsURLString;
}

@end
