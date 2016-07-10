//
//  AKLeaguesViewCell.m
//  AKFootball
//
//  Created by Admin on 29.06.16.
//  Copyright © 2016 Karpov Andrey. All rights reserved.
//

#import "AKLeaguesViewCell.h"
#import "AKLeague.h"

@implementation AKLeaguesViewCell

#pragma mark -
#pragma mark Public

- (void)fillWithModel:(AKLeague *)league {
    self.cellLabel.text = league.name;
}

@end
