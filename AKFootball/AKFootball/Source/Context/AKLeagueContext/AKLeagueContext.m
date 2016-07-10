//
//  AKLeagueContext.m
//  AKFootball
//
//  Created by Admin on 07.07.16.
//  Copyright © 2016 Karpov Andrey. All rights reserved.
//

#import "IDPActiveRecordKit.h"

#import "AKLeagueContext.h"
#import "AKLeague.h"

#define kAKAuthToken @{@"X-Auth-Token": @"f39e518c66d64efd9443fc5e8cef9c3a"}

static NSString * const kAKSeasonsURLString = @"http://api.football-data.org/v1/soccerseasons/?season=";
static NSString * const kAKCaptionKey       = @"caption";
static NSString * const kAKNameKey          = @"name";
static NSString * const kAKIDKey            = @"id";
static NSString * const kAKHTTPMethod       = @"GET";

@interface AKLeagueContext ()
@property (nonatomic, strong) NSURLSessionDataTask *dataTask;

@end

@implementation AKLeagueContext

#pragma mark -
#pragma mark Initialization & Deallocation

- (instancetype)initWithYear:(NSUInteger)year {
    self = [super init];
    if (self) {
        self.year = year;
    }
    
    return self;
}

#pragma mark -
#pragma mark Private

- (void)parseData:(NSDictionary *)result {
    NSMutableArray *leaguesArray = [NSMutableArray new];
    for (NSDictionary *dictionary in result) {
        NSUInteger integerID = [[dictionary valueForKey:kAKIDKey] integerValue];
        AKLeague *league = [AKLeague objectWithID:integerID];
        league.name = [dictionary valueForKey:kAKCaptionKey];
        [leaguesArray addObject:league];
        [league saveManagedObject];
    }
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:kAKNameKey
                                                                   ascending:YES];
    NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    NSArray *sortedArray = [leaguesArray sortedArrayUsingDescriptors:sortDescriptors];
    
    [self setState:kAKModelLoadedState withObject:[sortedArray copy]];
}

#pragma mark -
#pragma mark Public

- (void)setupLoad {
    NSString *yearString = [NSString stringWithFormat:@"%li",  self.year];
    NSString *seasonsURLString = [kAKSeasonsURLString stringByAppendingString:yearString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:seasonsURLString]];
    
    [request setHTTPMethod:kAKHTTPMethod];
    [request setAllHTTPHeaderFields:kAKAuthToken];
    
    self.dataTask = [[NSURLSession sharedSession] dataTaskWithRequest:request
                                                    completionHandler:^(NSData *data,
                                                                        NSURLResponse *response,
                                                                        NSError *error) {
                                                        if (!error) {
                                                            NSDictionary *result = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                                                            [self parseData:result];
                                                        } else {
                                                            NSLog(@"%@", error);
                                                            [self setState:kAKModelFailedState withObject:nil];
                                                        }}];
    [self.dataTask resume];
}

- (void)cancel {
    [self.dataTask cancel];
}

@end
