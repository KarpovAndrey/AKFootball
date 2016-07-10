//
//  AKLeagueContext.h
//  AKFootball
//
//  Created by Admin on 07.07.16.
//  Copyright © 2016 Karpov Andrey. All rights reserved.
//

#import "AKModel.h"

@class AKLeague;

@interface AKLeagueContext : AKModel
@property (nonatomic, assign)   NSUInteger  year;
@property (nonatomic, strong)   NSArray     *leaguesArray;

- (instancetype)initWithYear:(NSUInteger)year;

- (void)cancel;

- (void)parseData:(NSDictionary *)result;

@end
