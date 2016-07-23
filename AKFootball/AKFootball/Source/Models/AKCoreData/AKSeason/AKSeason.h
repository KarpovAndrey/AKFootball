//
//  AKSeason.h
//  AKFootball
//
//  Created by Admin on 10.07.16.
//  Copyright © 2016 Karpov Andrey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

#import "AKManagedObject.h"

@class AKLeague;

NS_ASSUME_NONNULL_BEGIN

@interface AKSeason : AKManagedObject
@property (nonatomic, assign) NSUInteger      year;

@end

NS_ASSUME_NONNULL_END

#import "AKSeason+CoreDataProperties.h"
