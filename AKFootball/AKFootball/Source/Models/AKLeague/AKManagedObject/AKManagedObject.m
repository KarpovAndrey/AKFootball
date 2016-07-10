//
//  AKManagedObject.m
//  AKFootball
//
//  Created by Admin on 07.07.16.
//  Copyright © 2016 Karpov Andrey. All rights reserved.
//

#import "IDPActiveRecordKit.h"

#import "AKManagedObject.h"

static NSString * const kAKIDKey    = @"id";
static NSString * const kAKYearKey  = @"year";


@implementation AKManagedObject

@dynamic year;

#pragma mark -
#pragma mark Class Methods

+ (instancetype)objectWithID:(NSUInteger)ID {
    AKManagedObject *object = [self findObjectWithID:ID];
    if (object) {
        return object;
    }
    
    object = [self managedObject];
    object.ID = ID;
    
    return object;
}

+ (instancetype)findObjectWithID:(NSUInteger)ID {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K = %d", kAKIDKey, ID];
    
    return [[[self class] fetchEntityWithSortDescriptors:nil predicate:predicate prefetchPaths:nil] firstObject];
}

#pragma mark -
#pragma mark Accessors

- (void)setID:(NSUInteger)ID {
    NSNumber *number = [NSNumber numberWithUnsignedInteger:ID];
    [self setCustomValue:number forKey:kAKIDKey];
}

- (NSUInteger)ID {
    NSNumber *number = [self customValueForKey:kAKIDKey];
    
    return [number unsignedIntegerValue];
}


- (void)setYear:(NSUInteger)year {
    NSNumber *number = [NSNumber numberWithInteger:year];
    [self setCustomValue:number forKey:kAKYearKey];
}

- (NSUInteger)year {
    NSNumber *number = [self customValueForKey:kAKYearKey];
    
    return [number integerValue];
}

@end
