//
//  CardView.m
//  CatJiff
//
//  Created by Mattias Bergström on 21/02/15.
//  Copyright (c) 2015 Mattias Bergström. All rights reserved.
//

#import "CardView.h"
#import "ShareButton.h"

#import "UIColor+FlatUIColors.h"
#import "UIFont+Montserrat.h"

#import <PureLayout/PureLayout.h>
#import <FLAnimatedImageView.h>
#import <FLAnimatedImage.h>

static CGFloat const kPadding = 24.0f;
static CGFloat const kDefaultAspectRatio = 0.6f;
static CGFloat const kShareButtonHeight = 60.0f;

@interface CardView ()

@property (nonatomic, strong) NSLayoutConstraint *imageViewHeightConstraint;
@property (nonatomic, strong) NSLayoutConstraint *shareButtonHeightConstraint;

@end

@implementation CardView

-(instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor clouds];

        self.imageView = [FLAnimatedImageView newAutoLayoutView];
        self.imageView.backgroundColor = [UIColor orangeColor];
        self.imageView.contentMode = UIViewContentModeScaleAspectFill;
        self.imageView.clipsToBounds = YES;
        [self addSubview:self.imageView];
        [self.imageView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeBottom];
        self.imageViewHeightConstraint = [self.imageView autoMatchDimension:ALDimensionHeight toDimension:ALDimensionWidth ofView:self.imageView withMultiplier:kDefaultAspectRatio];

        self.titleLabel = [UILabel newAutoLayoutView];
        self.titleLabel.font = [UIFont montserratBoldWithSize:16];
        [self addSubview:self.titleLabel];
        [self.titleLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:kPadding];
        [self.titleLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:kPadding];
        [self.titleLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.imageView withOffset:kPadding];

        self.shareButton = [ShareButton newAutoLayoutView];
        [self.shareButton setTitle:@"SHARE" forState:UIControlStateNormal];
        [self.shareButton addTarget:self action:@selector(shareAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.shareButton];
        [self.shareButton autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsMake(0, 0, 0, 0) excludingEdge:ALEdgeTop];
        [self.shareButton autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.titleLabel withOffset:kPadding];
        self.shareButtonHeightConstraint = [self.shareButton autoSetDimension:ALDimensionHeight toSize:0];

        UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
        [self addGestureRecognizer:tapRecognizer];
    }
    return self;
}

- (void)handleTap:(id)sender
{
    self.expanded = !self.expanded;

    if (self.expanded) {
        [self setupExpandedConstraints];
    } else {
        [self setupContractedConstraints];
    }

    [UIView animateWithDuration:0.4 delay:0.0 usingSpringWithDamping:0.6 initialSpringVelocity:0.8 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        [self layoutIfNeeded];
    } completion:nil];
}

- (void)setupExpandedConstraints
{
    [self.imageView removeConstraint:self.imageViewHeightConstraint];
    CGFloat expandedAspectRatio = self.imageView.animatedImage.size.height / self.imageView.animatedImage.size.width;
    self.imageViewHeightConstraint = [self.imageView autoMatchDimension:ALDimensionHeight toDimension:ALDimensionWidth ofView:self.imageView withMultiplier:expandedAspectRatio];
    self.shareButtonHeightConstraint.constant = kShareButtonHeight;
}

- (void)setupContractedConstraints
{
    [self.imageView removeConstraint:self.imageViewHeightConstraint];
    self.imageViewHeightConstraint = [self.imageView autoMatchDimension:ALDimensionHeight toDimension:ALDimensionWidth ofView:self.imageView withMultiplier:kDefaultAspectRatio];
    self.shareButtonHeightConstraint.constant = 0;
}

#pragma mark - Actions

- (void)shareAction:(id)sender
{
    if (self.delegate) {
        [self.delegate cardViewDidSelectShare:self];
    }
}

@end
