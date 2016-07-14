//
//  AKMatchContext.h
//  AKFootball
//
//  Created by Admin on 13.07.16.
//  Copyright © 2016 Karpov Andrey. All rights reserved.
//

#import "AKContext.h"

@class AKLeague;

@interface AKMatchContext : AKContext
@property (nonatomic, strong)   AKLeague     *league;

- (instancetype)initWithID:(NSUInteger)ID;

- (void)parseData:(NSDictionary *)result;

@end
