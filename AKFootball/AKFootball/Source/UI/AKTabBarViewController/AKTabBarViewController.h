//
//  AKTabBarViewController.h
//  AKFootball
//
//  Created by Admin on 18.07.16.
//  Copyright © 2016 Karpov Andrey. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AKLeague;
@class AKTabBarView;

@interface AKTabBarViewController : UITabBarController
@property (nonatomic, strong)                           AKLeague              *league;
@property (nonatomic, readonly)                         AKTabBarView          *rootView;
@property (nonatomic, strong) IBOutletCollection(UIViewController)  NSArray   *controllersCollection;


@end
