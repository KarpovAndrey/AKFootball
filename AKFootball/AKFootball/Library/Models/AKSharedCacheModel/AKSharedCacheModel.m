//
//  AKSharedCacheModel.m
//  AKStudy
//
//  Created by Admin on 02.06.16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import "AKSharedCacheModel.h"

static NSString * const kAKSharedCacheModelName        = @"sharedCache.plist";
static NSString * const kAKStringCachedFiles           = @"sharedCacheFiles";

static AKSharedCacheModel * model = nil;

@interface AKSharedCacheModel ()
@property (nonatomic, strong)   NSMutableDictionary     *cachedFiles;
@property (nonatomic, readonly) NSString                *path;
@property (nonatomic, readonly) NSArray                 *notificationsURLStrings;

@property (nonatomic, readonly, getter=isCached) BOOL   cached;

- (void)addObserversWithURLStrings:(NSArray *)URLStrings;
- (void)removeObserversWithURLStrings:(NSArray *)URLStrings;
- (void)save;

@end

@implementation AKSharedCacheModel

@dynamic path;
@dynamic notificationsURLStrings;

#pragma mark -
#pragma mark Class Methods

+ (instancetype)sharedCache {
    static dispatch_once_t once_token = 0;
    dispatch_once(&once_token, ^{
        AKSharedCacheModel *newModel = [self new];
        model = [NSKeyedUnarchiver unarchiveObjectWithFile:newModel.path];
        
        if (!model) {
            model = [self new];
            model.cachedFiles = [NSMutableDictionary dictionary];
        }
        
        [model addObserversWithURLStrings:model.notificationsURLStrings];
    });
    
    return model;
}

#pragma mark -
#pragma mark Initializations & Deallocations

- (void)dealloc {
    [self removeObserversWithURLStrings:self.notificationsURLStrings];
}

#pragma mark -
#pragma mark Accessors

- (NSString *)path {
    return [NSFileManager pathToFileWithName:kAKSharedCacheModelName];
}

- (NSArray *)notificationsURLStrings {
    return @[UIApplicationDidEnterBackgroundNotification, UIApplicationWillTerminateNotification];
}

#pragma mark -
#pragma mark Private

- (void)addObserversWithURLStrings:(NSArray *)URLStrings {
    @synchronized (self) {
        for (NSString *URLString in URLStrings) {
            [[NSNotificationCenter defaultCenter] addObserver:self
                                                     selector:@selector(save)
                                                         name:URLString
                                                       object:nil];
        }
    }
}

- (void)removeObserversWithURLStrings:(NSArray *)URLStrings {
    @synchronized (self) {
        for (NSString *URLString in URLStrings) {
            [[NSNotificationCenter defaultCenter] removeObserver:self
                                                            name:URLString
                                                          object:nil];
        }
    }
}

- (void)save {
    [NSKeyedArchiver archiveRootObject:self toFile:self.path];
}

#pragma mark -
#pragma mark Public

- (NSString *)URLStringForFileName:(NSString *)fileName {
    @synchronized (self) {
        NSArray *URLStrings = self.cachedFiles.allKeys;
        NSDictionary *dictionary = [self.cachedFiles copy];
        for (NSString *URLString in URLStrings) {
            if ([[dictionary objectForKey:URLString] isEqualToString:fileName]) {
                return URLString;
            }
        }
    }
    
    return nil;
}

- (BOOL)isCachedForURLString:(NSString *)URLString {
    @synchronized (self) {
        return [self.cachedFiles objectForKey:URLString];
    }
}

- (void)addFileName:(NSString *)fileName ForURLString:(NSString *)URLString {
    @synchronized (self) {
        if ([self isCachedForURLString:URLString]) {
            return;
        } else {
            NSString *stringURLString = [self URLStringForFileName:fileName];
            if (stringURLString) {
                [self removeFileNameForURLString:stringURLString];
            }
            
            [self.cachedFiles setObject:fileName forKey:URLString];
        }
    }
}

- (void)removeFileNameForURLString:(NSString *)URLString {
    @synchronized (self) {
        [self.cachedFiles removeObjectForKey:URLString];
    }
}

#pragma mark -
#pragma mark NSCoding Protocol

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.cachedFiles forKey:kAKStringCachedFiles];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        self.cachedFiles = [aDecoder decodeObjectForKey:kAKStringCachedFiles];
    }
    
    return self;
}

@end
