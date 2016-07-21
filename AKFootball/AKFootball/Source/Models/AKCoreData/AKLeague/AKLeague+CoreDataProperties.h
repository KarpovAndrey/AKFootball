//
//  AKLeague+CoreDataProperties.h
//  AKFootball
//
//  Created by Admin on 20.07.16.
//  Copyright © 2016 Karpov Andrey. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "AKLeague.h"

NS_ASSUME_NONNULL_BEGIN

@interface AKLeague (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *id;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSNumber *year;
@property (nullable, nonatomic, retain) NSSet<AKMatch *> *matches;
@property (nullable, nonatomic, retain) AKSeason *season;
@property (nullable, nonatomic, retain) NSSet<AKTeam *> *teams;

@end

@interface AKLeague (CoreDataGeneratedAccessors)

- (void)addMatchesObject:(AKMatch *)value;
- (void)removeMatchesObject:(AKMatch *)value;
- (void)addMatches:(NSSet<AKMatch *> *)values;
- (void)removeMatches:(NSSet<AKMatch *> *)values;

- (void)addTeamsObject:(AKTeam *)value;
- (void)removeTeamsObject:(AKTeam *)value;
- (void)addTeams:(NSSet<AKTeam *> *)values;
- (void)removeTeams:(NSSet<AKTeam *> *)values;

@end

NS_ASSUME_NONNULL_END
