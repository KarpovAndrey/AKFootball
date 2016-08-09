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
#import "AKFootballConstants.h"

@implementation AKLeaguesContext

#pragma mark -
#pragma mark Accessors

- (NSString *)contextURLString {
    NSString *yearString = [NSString stringWithFormat:@"%li",  self.ID];

    return [kAKSeasonsURLString stringByAppendingString:yearString];
}

#pragma mark -
#pragma mark Public

- (void)parseData:(NSDictionary *)result {
    self.season = [AKSeason objectWithID:self.ID];
    self.season.year = self.ID;

    for (NSDictionary *dictionary in result) {
        NSUInteger integerID = [[dictionary valueForKey:kAKIDKey] integerValue];
        AKLeague *league = [AKLeague objectWithID:integerID];
        league.name = [dictionary valueForKey:kAKCaptionKey];
        league.year = [[dictionary valueForKey:kAKYearKey] integerValue];
        [self.season addLeaguesObject:league];
    }
    
    [self setState:kAKModelLoadedState withObject:self.season.leagues];
}

- (void)loadObject {
    self.season = [AKSeason objectWithID:self.ID];
    [self setState:kAKModelFailedState withObject:self.season.leagues];
}

@end
