//
//  UICollectionView+AKCategory.h
//  AKFacebook
//
//  Created by Admin on 23.06.16.
//  Copyright © 2016 Karpov Andrey. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UICollectionView (AKCategory)

- (id)dequeueReusableCellFromNibWithClass:(Class)theClass indexPath:(NSIndexPath *)indexPath;

@end
