//
//  AKManagedObject.h
//  AKFootball
//
//  Created by Admin on 07.07.16.
//  Copyright © 2016 Karpov Andrey. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface AKManagedObject : NSManagedObject
@property (nonatomic, assign)   NSUInteger              year;
@property (nonatomic, assign)   NSUInteger              ID;

+ (instancetype)objectWithID:(NSUInteger)ID;
+ (instancetype)findObjectWithID:(NSUInteger)ID;

@end
