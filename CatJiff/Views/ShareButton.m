//
//  ShareButton.m
//  CatJiff
//
//  Created by Mattias Bergström on 23/02/15.
//  Copyright (c) 2015 Mattias Bergström. All rights reserved.
//

#import "ShareButton.h"

#import "UIColor+FlatUIColors.h"
#import "UIFont+Montserrat.h"

@implementation ShareButton

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.clipsToBounds = YES;
        self.backgroundColor = [UIColor alizarin];
        self.titleLabel.font = [UIFont montserratBoldWithSize:16];
    }
    return self;
}

@end
