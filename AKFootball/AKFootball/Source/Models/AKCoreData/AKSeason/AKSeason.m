//
//  AKSeason.m
//  AKFootball
//
//  Created by Admin on 10.07.16.
//  Copyright © 2016 Karpov Andrey. All rights reserved.
//

#import "IDPActiveRecordKit.h"
#import "AKSeason.h"
#import "AKLeague.h"
#import "AKFootballConstants.h"

@implementation AKSeason
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
