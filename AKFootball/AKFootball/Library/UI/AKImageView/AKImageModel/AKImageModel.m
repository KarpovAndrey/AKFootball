//
//  AKImageModel.m
//  AKStudy
//
//  Created by Admin on 25.05.16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import "AKImageModel.h"
#import "AKDispatch.h"
#import "AKSharedCacheModel.h"

@interface AKImageModel ()
@property (nonatomic, readonly, getter = isCached)  BOOL                cached;
@property (nonatomic, readonly)                     NSString            *fileName;
@property (nonatomic, readonly)                     NSString            *path;
@property (nonatomic, readonly)                     AKSharedCacheModel  *sharedCacheModel;
@property (nonatomic, readonly)                     NSString            *absoluteStringValue;

@property (nonatomic, strong)   NSURLSession                *session;
@property (nonatomic, strong)   NSURLSessionDownloadTask    *downloadTask;

- (void)loadFromFileSystem;
- (void)deleteIfNeeded;
- (void)performDownload;
- (void)dump;

@end

@implementation AKImageModel

@dynamic fileName;
@dynamic path;
@dynamic cached;
@dynamic sharedCacheModel;
@dynamic absoluteStringValue;

#pragma mark -
#pragma mark Initializations & Deallocations

- (instancetype)init {
    self = [super init];
    if (self) {
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        self.session = [NSURLSession sessionWithConfiguration:config];
    }
    
    return self;
}

#pragma mark -
#pragma mark Accessors

- (void)setURL:(NSURL *)URL {
    if (![_URL isEqual:URL]) {
        _URL = URL;
        
        [self dump];
    }
    
    [self load];
}

- (void)setDownloadTask:(NSURLSessionDownloadTask *)downloadTask {
    if (_downloadTask != downloadTask) {
        [_downloadTask cancel];
        
        _downloadTask = downloadTask;
        [_downloadTask resume];
    }
}

- (BOOL)isCached {
    return [self.sharedCacheModel isCachedForURLString:self.absoluteStringValue];
}

- (NSString *)fileName {
    NSArray *paths = [self.URL pathComponents];
    NSString *fileName = [NSString stringWithFormat:@"%@_%@",paths[paths.count - 2],
                          [self.URL lastPathComponent]];
    return fileName;
}

- (NSString *)path {
    return [NSFileManager pathToFileWithName:self.fileName];
}

- (NSString *)absoluteStringValue {
    return self.URL.absoluteString;
}

- (AKSharedCacheModel *)sharedCacheModel {
    return [AKSharedCacheModel sharedCache];
}

#pragma mark -
#pragma mark Private

- (void)deleteIfNeeded {
    if (self.isCached) {
        NSError *error = nil;
        if ([[NSFileManager defaultManager] removeItemAtPath:self.path error:&error]) {
            [self.sharedCacheModel removeFileNameForURLString:self.absoluteStringValue];
        }
    }
}

- (void)performDownload {
    @synchronized (self) {
        id block = ^(NSURL *location, NSURLResponse *response, NSError *error) {
            if (!error) {
                NSError *fileError = nil;
                NSString *path = self.path;
                NSFileManager *fileManager = [NSFileManager defaultManager];
                
                if (!self.isCached && [fileManager fileExistsAtPath:path]) {
                    [fileManager removeItemAtPath:path error:&fileError];
                }
                
                [fileManager copyItemAtURL:location toURL:[NSURL fileURLWithPath:path] error:&fileError];
                
                if (!fileError) {
                    [self.sharedCacheModel addFileName:self.fileName ForURLString:self.absoluteStringValue];
                }
                
                [self loadFromFileSystem];
            }
        };
        
        self.downloadTask = [self.session downloadTaskWithURL:self.URL completionHandler:block];
    }
}

#pragma mark -
#pragma mark Public

- (void)loadFromFileSystem {
    if (self.isCached) {
        UIImage *image = [UIImage imageWithContentsOfFile:self.path];
        
        if (!image) {
            [self deleteIfNeeded];
        } else {
            self.image = image;
        }
    }
    
    [self completeLoading];
}

- (void)prepareToLoading {
    if (self.URL.isFileURL || self.isCached) {
        [self loadFromFileSystem];
    } else {
        [self performDownload];
    }
}

- (void)dump {
    self.state = kAKModelUndefinedState;
}

- (void)completeLoading {
    AKWeakify;
    AKDispatchAsyncOnMainThread(^{
        AKStrongifySelfWithClass(AKImageModel);
        NSUInteger state = strongSelf.image ? kAKModelLoadedState : kAKModelFailedState;
        [strongSelf setState:state withObject:strongSelf.image];
    });
}

@end