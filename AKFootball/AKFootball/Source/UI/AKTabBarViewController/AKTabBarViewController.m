//
//  AKTabBarViewController.m
//  AKFootball
//
//  Created by Admin on 18.07.16.
//  Copyright © 2016 Karpov Andrey. All rights reserved.
//

#import "AKTabBarViewController.h"
#import "AKTabBarVIew.h"

@interface AKTabBarViewController ()
@property (nonatomic, readonly) AKTabBarView            *rootView;

@end

@implementation AKTabBarViewController

#pragma mark -
#pragma mark Accessors

AKRootViewAndReturnIfNil(AKTabBarView)

@end
