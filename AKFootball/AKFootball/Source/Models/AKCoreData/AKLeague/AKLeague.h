//
//  AKLeague.h
//  AKFootball
//
//  Created by Admin on 20.07.16.
//  Copyright © 2016 Karpov Andrey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "AKManagedObject.h"

@class AKMatch, AKSeason, AKTeam;

NS_ASSUME_NONNULL_BEGIN

@interface AKLeague : AKManagedObject
@property (nonatomic, assign) NSUInteger      year;

@end

NS_ASSUME_NONNULL_END

#import "AKLeague+CoreDataProperties.h"
