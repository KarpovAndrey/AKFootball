//
//  AKObserverArray.m
//  AKStudy
//
//  Created by Admin on 13.04.16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import "AKObserverArray.h"
#import "AKObserverObject.h"

@interface AKObserverArray ()
@property (nonatomic, retain) NSMutableArray *handlers;

@end

@implementation AKObserverArray

#pragma mark -
#pragma mark Initializations & Deallocations

- (void)dealloc {
    self.handlers = nil;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.handlers = [NSMutableArray array];
    }
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (NSArray *)handlersObjects {
    return [self.handlers copy];
}

#pragma mark -
#pragma mark Public

- (void)addHandler:(AKObjectHandler)handler forObject:(id)object {
    @synchronized (self) {
        AKObserverObject *observerObject = [AKObserverObject observerObjectWithObject:object handler:handler];
        [self.handlers addObject:observerObject];
    }
}

- (void)removeHandlersForObject:(id)object {
    @synchronized (self) {
        NSArray *objects = [self.handlersObjects copy];
        for (AKObserverObject *observerObject in objects) {
            if (observerObject.object == object) {
                [self.handlers removeObject:observerObject];
            }
        }
    }
}

- (void)removeAllHandlers {
    @synchronized (self) {
        [self.handlers removeAllObjects];
    }
}

@end
