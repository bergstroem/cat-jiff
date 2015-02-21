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
#import "CardView+Gif.h"

#import <PureLayout/PureLayout.h>

@interface GifFeedViewController ()

@property (nonatomic, strong) PagedView *pagedView;
@property (nonatomic, strong) GifFetcher *gifFetcher;

@end

@implementation GifFeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.pagedView = [PagedView newAutoLayoutView];
    self.pagedView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:self.pagedView];
    [self.pagedView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];

    self.gifFetcher = [[GifFetcher alloc] init];
    self.gifFetcher.delegate = self;

    [self.gifFetcher fetchCatGifs];
}

- (void)createSwipePageWithGif:(Gif *)gif image:(FLAnimatedImage *)image
{
    CardView *cardView = [CardView newAutoLayoutView];
    [cardView configureViewWithGif:gif image:image];
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

}

- (void)swipeViewDidMove:(SwipeView *)view
{
    if (!CGRectIntersectsRect(self.view.bounds, view.contentView.frame)) {
        [self.pagedView removePage:view];
    }
}

#pragma mark - GifFetcherDelegate

- (void)gifWasDownloaded:(Gif *)gif withImage:(FLAnimatedImage *)image
{
    [self createSwipePageWithGif:gif image:(FLAnimatedImage *)image];
}

@end
