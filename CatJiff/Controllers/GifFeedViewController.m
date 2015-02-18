//
//  GifFeedViewController.m
//  CatJiff
//
//  Created by Mattias Bergström on 21/02/15.
//  Copyright (c) 2015 Mattias Bergström. All rights reserved.
//

#import "GifFeedViewController.h"
#import "PagedView.h"
#import "CardView.h"

#import <PureLayout/PureLayout.h>

@interface GifFeedViewController ()

@property (nonatomic, strong) PagedView *pagedView;

@end

@implementation GifFeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.pagedView = [PagedView newAutoLayoutView];
    self.pagedView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:self.pagedView];
    [self.pagedView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];

    [self createPage];
    [self createPage];
    [self createPage];
    [self createPage];
    [self createPage];
}

- (void)createPage
{
    CardView *cardView = [CardView newAutoLayoutView];
    SwipeView *swipeView = [SwipeView newAutoLayoutView];
    swipeView.delegate = self;

    [swipeView setContentView:cardView];
    [self.pagedView addPage:swipeView];

    [cardView autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:self.view withOffset:-20];
    [cardView autoCenterInSuperview];
    [swipeView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
}

#pragma mark - SwipeViewDelegate

- (void)swipeViewWasDismissed:(SwipeView *)swipeView
{
    [self createPage];
}

- (void)swipeViewDidMove:(SwipeView *)view
{
    if (!CGRectIntersectsRect(self.view.bounds, view.contentView.frame)) {
        [self.pagedView removePage:view];
    }
}

@end
