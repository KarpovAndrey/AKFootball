//
//  AKLeaguesContext.h
//  AKFootball
//
//  Created by Admin on 07.07.16.
//  Copyright © 2016 Karpov Andrey. All rights reserved.
//

#import "AKModel.h"
#import "AKContext.h"

@class AKSeason;

@interface AKLeaguesContext : AKContext
@property (nonatomic, strong)   AKSeason    *season;

- (void)parseData:(NSDictionary *)result;

@end
