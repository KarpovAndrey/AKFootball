//
//  AKTeam+CoreDataProperties.h
//  AKFootball
//
//  Created by Admin on 16.07.16.
//  Copyright © 2016 Karpov Andrey. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "AKTeam.h"

NS_ASSUME_NONNULL_BEGIN

@interface AKTeam (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *pictureURLPath;
@property (nullable, nonatomic, retain) NSNumber *points;
@property (nullable, nonatomic, retain) NSNumber *position;
@property (nullable, nonatomic, retain) AKLeague *league;

@end

NS_ASSUME_NONNULL_END
