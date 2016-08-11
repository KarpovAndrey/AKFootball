//
//  AKCustomViewController.h
//  AKFacebook
//
//  Created by Admin on 13.06.16.
//  Copyright © 2016 Karpov Andrey. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AKContext;

@interface AKCustomViewController : UIViewController
@property (nonatomic, strong)       AKContext       *context;

@property (nonatomic, readonly) NSString            *leftButtonImageName;
@property (nonatomic, readonly) NSString            *rightButtonImageName;
@property (nonatomic, readonly) NSString            *loadingViewMessage;
@property (nonatomic, readonly) NSString            *navigationItemTitle;

- (void)showCustomNavigationBar;
- (void)showNavigationBarWithTitle:(NSString *)title
               leftButtonImageName:(NSString *)leftButtonImageName
              rightButtonImageName:(NSString *)rightButtonImageName;


//these methods are called in subclasses
//you should never call these method directly from outside subclasses
- (void)contextDidLoadWithObject:(id)object;
- (void)contextDidFailToLoad:(id)object;

@end
