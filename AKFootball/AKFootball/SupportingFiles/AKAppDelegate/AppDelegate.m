//
//  AppDelegate.m
//  AKFootball
//
//  Created by Admin on 29.06.16.
//  Copyright © 2016 Karpov Andrey. All rights reserved.
//

#import "IDPActiveRecordKit.h"

#import "AppDelegate.h"
#import "AKSeasonsViewController.h"
#import "AKFootballConstants.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    UIWindow *window = [UIWindow window];
    self.window = window;
    
    AKSeasonsViewController *viewController = [AKSeasonsViewController new];
    UINavigationController *controller = [[UINavigationController alloc]
                                          initWithRootViewController:viewController];
    
    [IDPCoreDataManager sharedManagerWithMomName:kAKMomName];
    
    [[UINavigationBar appearance] setBarTintColor:[UIColor grayColor]];
    
    window.rootViewController = controller;
    [window makeKeyAndVisible];
    
    return YES;
}

@end
