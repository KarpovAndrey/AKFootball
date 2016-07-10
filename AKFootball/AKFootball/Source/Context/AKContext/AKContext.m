//
//  AKContext.m
//  AKFootball
//
//  Created by Admin on 07.07.16.
//  Copyright © 2016 Karpov Andrey. All rights reserved.
//

#import "AKContext.h"

@interface AKContext ()
@property (nonatomic, strong) NSURLSessionDataTask *dataTask;

@end

@implementation AKContext

//#pragma mark -
//#pragma mark Private
//
//- (void)parseData:(NSDictionary *)result {
//    
//}
//
//#pragma mark -
//#pragma mark Public
//
//- (void)setupLoad {
//    NSDictionary *headers = @{@"X-Auth-Token": @"f39e518c66d64efd9443fc5e8cef9c3a"};
//    
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://api.football-data.org/alpha/soccerseasons/424/teams"]];
//    
//    [request setHTTPMethod:@"GET"];
//    [request setAllHTTPHeaderFields:headers];
//    
//    self.dataTask = [[NSURLSession sharedSession] dataTaskWithRequest:request
//                                                    completionHandler:^(NSData *data,
//                                                                        NSURLResponse *response,
//                                                                        NSError *error) {
//                                                        if (!error) {
//                                                            NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
//                                                            NSLog(@"%@", dictionary);
//                                                            [self parseData:dictionary];
//                                                            //    [self.user saveManagedObject];
//                                                        } else {
//                                                            NSLog(@"%@", error);
//                                                            [self setState:kAKModelFailedState withObject:self.object];
//                                                        }}];
//    [self.dataTask resume];
//}
//
//- (void)cancel {
//    [self.dataTask cancel];
//}

@end
