//
//  UICollectionView+AKCategory.m
//  AKFacebook
//
//  Created by Admin on 23.06.16.
//  Copyright © 2016 Karpov Andrey. All rights reserved.
//

#import "UICollectionView+AKCategory.h"

@implementation UICollectionView (AKCategory)

- (id)dequeueReusableCellFromNibWithClass:(Class)theClass indexPath:(NSIndexPath *)indexPath; {
    
    id cell = [self dequeueReusableCellWithReuseIdentifier:NSStringFromClass(theClass) forIndexPath:indexPath];
    if (!cell) {
        cell = [UINib loadFromNibWithClass:(theClass)];
    }
    
    return cell;
}

@end
