//
//  AKLeague.m
//  AKFootball
//
//  Created by Admin on 20.07.16.
//  Copyright © 2016 Karpov Andrey. All rights reserved.
//

#import "AKLeague.h"
#import "AKMatch.h"
#import "AKSeason.h"
#import "AKTeam.h"
#import "AKFootballConstants.h"
#import "IDPActiveRecordKit.h"

@implementation AKLeague
@dynamic year;

#pragma mark -
#pragma mark Accessors

- (void)setYear:(NSUInteger)year {
    [self setCustomValue:[NSNumber numberWithUnsignedInteger:year] forKey:kAKYearKey];
}

- (NSUInteger)year {
    return [[self customValueForKey:kAKYearKey] unsignedIntegerValue];
}

@end
