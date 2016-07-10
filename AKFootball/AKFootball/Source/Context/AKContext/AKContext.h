//
//  AKContext.h
//  AKFootball
//
//  Created by Admin on 07.07.16.
//  Copyright © 2016 Karpov Andrey. All rights reserved.
//

#import "AKModel.h"

@interface AKContext : AKModel

@property (nonatomic, readonly)     NSDictionary        *headerFields;
@property (nonatomic, readonly)     NSString            *requestURLString;

//- (void)cancel;

//these methods are called in subclasses
//you should never call these method directly from outside subclasses
//- (void)parseData:(NSDictionary *)result;

@end
