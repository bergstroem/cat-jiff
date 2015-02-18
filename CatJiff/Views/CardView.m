//
//  CardView.m
//  CatJiff
//
//  Created by Mattias Bergström on 21/02/15.
//  Copyright (c) 2015 Mattias Bergström. All rights reserved.
//

#import "CardView.h"

#import "UIColor+FlatUIColors.h"
#import "UIFont+Montserrat.h"

#import <PureLayout/PureLayout.h>
#import <FLAnimatedImageView.h>

static CGFloat const kPadding = 24.0f;

@implementation CardView

-(instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor clouds];

        self.imageView = [FLAnimatedImageView newAutoLayoutView];
        self.imageView.backgroundColor = [UIColor orangeColor];
        [self addSubview:self.imageView];
        [self.imageView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeBottom];
        [self.imageView autoMatchDimension:ALDimensionHeight toDimension:ALDimensionWidth ofView:self.imageView withMultiplier:0.6];


        self.titleLabel = [UILabel newAutoLayoutView];
        self.titleLabel.text = @"Text";
        self.titleLabel.font = [UIFont montserratBoldWithSize:16];
        [self addSubview:self.titleLabel];
        [self.titleLabel autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(kPadding, kPadding, kPadding, kPadding) excludingEdge:ALEdgeTop];

        [self.titleLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.imageView withOffset:kPadding];
    }
    return self;
}

@end
