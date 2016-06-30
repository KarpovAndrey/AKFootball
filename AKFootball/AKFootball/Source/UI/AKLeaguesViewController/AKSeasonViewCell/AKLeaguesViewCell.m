//
//  AKLeaguesViewCell.m
//  AKFootball
//
//  Created by Admin on 29.06.16.
//  Copyright © 2016 Karpov Andrey. All rights reserved.
//

#import "AKLeaguesViewCell.h"

@implementation AKLeaguesViewCell

#pragma mark -
#pragma mark Public

- (void)fillWithModel:(NSString *)year {
    self.cellLabel.text = [NSString stringWithFormat:@"LEAGUE"];
}

@end
