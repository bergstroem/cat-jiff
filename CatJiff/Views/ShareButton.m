//
//  ShareButton.m
//  CatJiff
//
//  Created by Mattias Bergström on 23/02/15.
//  Copyright (c) 2015 Mattias Bergström. All rights reserved.
//

#import "ShareButton.h"

#import "UIColor+FlatUIColors.h"
#import "UIColor+LightAndDark.h"
#import "UIFont+Montserrat.h"
#import "UIImage+Color.h"

@implementation ShareButton

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.clipsToBounds = YES;
        self.backgroundColor = [UIColor alizarin];
        self.titleLabel.font = [UIFont montserratBoldWithSize:16];
        [self setBackgroundImage:[UIImage imageWithColor:[[UIColor alizarin] darkenColor:0.2]] forState:UIControlStateHighlighted];
    }
    return self;
}



@end
