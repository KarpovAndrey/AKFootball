//
//  AKContext.h
//  AKFootball
//
//  Created by Admin on 07.07.16.
//  Copyright © 2016 Karpov Andrey. All rights reserved.
//

#import "AKModel.h"

@class AKSeason;

@interface AKContext : AKModel
@property (nonatomic, assign)       NSUInteger          ID;
@property (nonatomic, readonly)     NSString            *contextURLString;
@property (nonatomic, strong)       AKSeason            *season;

- (void)cancel;
- (instancetype)initWithID:(NSUInteger)ID;

//these methods are called in subclasses
//you should never call these method directly from outside subclasses
- (void)parseData:(NSDictionary *)result;
- (void)loadObject;

@end
