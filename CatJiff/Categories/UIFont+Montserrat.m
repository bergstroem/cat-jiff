//
//  UIFont+Montserrat.m
//  CatJiff
//
//  Created by Mattias Bergström on 21/02/15.
//  Copyright (c) 2015 Mattias Bergström. All rights reserved.
//

#import "UIFont+Montserrat.h"

@implementation UIFont (Montserrat)

+ (UIFont *)montserratRegularWithSize:(CGFloat)size
{
    return [UIFont fontWithName:@"Montserrat-Regular" size:size];
}

+ (UIFont *)montserratBoldWithSize:(CGFloat)size
{
    return [UIFont fontWithName:@"Montserrat-Bold" size:size];
}

@end
