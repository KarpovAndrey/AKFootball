//
//  AKSeason+CoreDataProperties.h
//  AKFootball
//
//  Created by Admin on 12.07.16.
//  Copyright © 2016 Karpov Andrey. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "AKSeason.h"

NS_ASSUME_NONNULL_BEGIN

@interface AKSeason (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSSet<AKLeague *> *leagues;

@end

@interface AKSeason (CoreDataGeneratedAccessors)

- (void)addLeaguesObject:(AKLeague *)value;
- (void)removeLeaguesObject:(AKLeague *)value;
- (void)addLeagues:(NSSet<AKLeague *> *)values;
- (void)removeLeagues:(NSSet<AKLeague *> *)values;

@end

NS_ASSUME_NONNULL_END
