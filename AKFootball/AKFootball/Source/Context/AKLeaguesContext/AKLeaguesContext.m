//
//  AKLeaguesContext.m
//  AKFootball
//
//  Created by Admin on 07.07.16.
//  Copyright © 2016 Karpov Andrey. All rights reserved.
//

#import "IDPActiveRecordKit.h"

#import "AKLeaguesContext.h"
#import "AKLeague.h"
#import "AKSeason.h"

#define kAKAuthToken @{@"X-Auth-Token": @"f39e518c66d64efd9443fc5e8cef9c3a"}

static NSString * const kAKSeasonsURLString = @"http://api.football-data.org/v1/soccerseasons/?season=";
static NSString * const kAKCaptionKey       = @"caption";
static NSString * const kAKNameKey          = @"name";
static NSString * const kAKIDKey            = @"id";
static NSString * const kAKHTTPMethod       = @"GET";

@interface AKLeaguesContext ()
@property (nonatomic, strong) NSURLSessionDataTask *dataTask;

@end

@implementation AKLeaguesContext

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
#pragma mark Private

- (void)parseData:(NSDictionary *)result {
    self.season = [AKSeason objectWithID:self.ID];

    for (NSDictionary *dictionary in result) {
        NSUInteger integerID = [[dictionary valueForKey:kAKIDKey] integerValue];
        AKLeague *league = [AKLeague objectWithID:integerID];
        league.name = [dictionary valueForKey:kAKCaptionKey];
        [self.season addLeaguesObject:league];
    }
    
    [self setState:kAKModelLoadedState withObject:self.season.leagues];
}

#pragma mark -
#pragma mark Public

- (void)saveObject {
    [self.season saveManagedObject];
}

- (void)loadObject {
    self.season = [AKSeason objectWithID:self.ID];
    [self setState:kAKModelFailedState withObject:self.season.leagues];
}

- (NSString *)contextURLString {
    return kAKSeasonsURLString;
}

- (NSString *)appendingURLString {
    NSString *yearString = [NSString stringWithFormat:@"%li",  self.ID];
    NSString *seasonsURLString = [kAKSeasonsURLString stringByAppendingString:yearString];
    return seasonsURLString;
}

@end
