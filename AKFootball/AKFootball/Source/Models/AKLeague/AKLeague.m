//
//  AKLeague.m
//  AKFootball
//
//  Created by Admin on 07.07.16.
//  Copyright © 2016 Karpov Andrey. All rights reserved.
//

#import "AKLeague.h"
#import "IDPActiveRecordKit.h"

static NSString * const kAKTeamsCountKey  = @"teamsCount";

@implementation AKLeague
@dynamic teamsCount;

#pragma mark -
#pragma mark Accessors

- (void)setTeamsCount:(NSUInteger)teamsCount {
    [self setCustomValue:[NSNumber numberWithInteger:teamsCount] forKey:kAKTeamsCountKey];
}

- (NSUInteger)teamsCount {
    return [[self customValueForKey:kAKTeamsCountKey] integerValue];
}

@end
