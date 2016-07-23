//
//  AKContext.m
//  AKFootball
//
//  Created by Admin on 07.07.16.
//  Copyright © 2016 Karpov Andrey. All rights reserved.
//

#import "AKContext.h"
#import "IDPActiveRecordKit.h"
#import "AKFootballConstants.h"
#import "AKSeason.h"

@interface AKContext ()
@property (nonatomic, strong) NSURLSessionDataTask *dataTask;

@end

@implementation AKContext

#pragma mark -
#pragma mark Initialization & Deallocation

- (instancetype)initWithID:(NSUInteger)ID {
    self = [super init];
    if (self) {
        self.ID = ID;
    }
    
    return self;
}

#pragma mark -
#pragma mark Public

- (void)setupLoad {
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:
                                                                        self.appendingURLString]];
    
    [request setHTTPMethod:kAKHTTPMethod];
    [request setAllHTTPHeaderFields:kAKAuthToken];
    
    self.dataTask = [[NSURLSession sharedSession] dataTaskWithRequest:request
                                                    completionHandler:^(NSData *data,
                                                                        NSURLResponse *response,
                                                                        NSError *error) {
                                                        if (!error) {
                                                            NSDictionary *result = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                                                            [self parseData:result];
                                                            [self.season saveManagedObject];
                                                        } else {
                                                            [self loadObject];
                                                        }}];
    [self.dataTask resume];
}

- (void)cancel {
    [self.dataTask cancel];
}

- (void)parseData:(NSDictionary *)result {
    
}

- (void)loadObject {
    
}

@end