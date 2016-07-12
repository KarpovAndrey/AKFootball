//
//  AKTeamContext.h
//  AKFootball
//
//  Created by Admin on 11.07.16.
//  Copyright © 2016 Karpov Andrey. All rights reserved.
//

#import "AKModel.h"
#import "AKContext.h"

@class AKLeague;
@class AKSeason;

@interface AKTeamContext : AKContext
@property (nonatomic, strong)   AKLeague     *league;

- (instancetype)initWithID:(NSUInteger)ID;

- (void)parseData:(NSDictionary *)result;

@end
