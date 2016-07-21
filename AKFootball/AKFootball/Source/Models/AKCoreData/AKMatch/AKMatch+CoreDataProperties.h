//
//  AKMatch+CoreDataProperties.h
//  AKFootball
//
//  Created by Admin on 14.07.16.
//  Copyright © 2016 Karpov Andrey. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "AKMatch.h"
#import "AKLeague.h"

NS_ASSUME_NONNULL_BEGIN

@interface AKMatch (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *awayTeam;
@property (nullable, nonatomic, retain) NSString *homeTeam;
@property (nullable, nonatomic, retain) NSNumber *goalsAwayTeam;
@property (nullable, nonatomic, retain) NSNumber *goalsHomeTeam;
@property (nullable, nonatomic, retain) NSString *date;
@property (nullable, nonatomic, retain) NSString *status;
@property (nullable, nonatomic, retain) AKLeague *relationship;

@end

NS_ASSUME_NONNULL_END
