//
//  AKSeasonsViewCell.m
//  AKFootball
//
//  Created by Admin on 29.06.16.
//  Copyright © 2016 Karpov Andrey. All rights reserved.
//

#import "AKSeasonsViewCell.h"

@implementation AKSeasonsViewCell

#pragma mark -
#pragma mark Public

- (void)fillWithModel:(NSString *)year {
    self.cellLabel.text = [NSString stringWithFormat:@"SEASON OF %@ YEAR", year];
    //NEED TO FIX PROBLEM WITH STRINGS
}

@end
