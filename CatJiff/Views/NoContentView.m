//
//  NoContentView.m
//  CatJiff
//
//  Created by Mattias Bergström on 23/02/15.
//  Copyright (c) 2015 Mattias Bergström. All rights reserved.
//

#import "NoContentView.h"
#import "UIFont+Montserrat.h"
#import <PureLayout/PureLayout.h>

static CGFloat const kLoadingSpinnerSize = 48.0f;

@implementation NoContentView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.titleLabel = [UILabel newAutoLayoutView];
        self.titleLabel.font = [UIFont montserratBoldWithSize:18];
        self.titleLabel.textColor = [UIColor whiteColor];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.titleLabel];
        [self.titleLabel autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero excludingEdge:ALEdgeBottom];

        self.descriptionLabel = [UILabel newAutoLayoutView];
        self.descriptionLabel.font = [UIFont montserratRegularWithSize:16];
        self.descriptionLabel.textColor = [UIColor lightGrayColor];
        self.descriptionLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.descriptionLabel];
        [self.descriptionLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [self.descriptionLabel autoPinEdgeToSuperviewEdge:ALEdgeRight];
        [self.descriptionLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.titleLabel];

        self.loadingSpinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        self.loadingSpinner.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:self.loadingSpinner];
        [self.loadingSpinner autoSetDimensionsToSize:CGSizeMake(kLoadingSpinnerSize, kLoadingSpinnerSize)];
        [self.loadingSpinner autoAlignAxisToSuperviewAxis:ALAxisVertical];
        [self.loadingSpinner autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.descriptionLabel];
        [self.loadingSpinner autoPinEdgeToSuperviewEdge:ALEdgeBottom];
    }
    return self;
}

-(void)setLoadingMoreContent:(BOOL)loadingMoreContent
{
    if (loadingMoreContent) {
        [self.loadingSpinner startAnimating];
    } else {
        [self.loadingSpinner stopAnimating];
    }
    _loadingMoreContent = loadingMoreContent;
}

@end
