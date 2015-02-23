//
//  GifFeedViewController.m
//  CatJiff
//
//  Created by Mattias Bergström on 21/02/15.
//  Copyright (c) 2015 Mattias Bergström. All rights reserved.
//

#import "GifFeedViewController.h"
#import "Gif.h"
#import "NoContentView.h"
#import "PagedView.h"
#import "CardView.h"
#import "CardView+Gif.h"

#import "UIColor+FlatUIColors.h"
#import "UIColor+LightAndDark.h"

#import <PureLayout/PureLayout.h>

static NSInteger const kLoadMoreThreshold = 3;
static NSInteger const kMaxVisiblePages = 4;

@interface GifFeedViewController ()

@property (nonatomic, strong) NoContentView *noContentView;
@property (nonatomic, strong) PagedView *pagedView;
@property (nonatomic, strong) GifFetcher *gifFetcher;
@property (nonatomic, strong) NSMutableArray *gifs;

@property (nonatomic, assign) NSInteger loadedGifsCount;
@property (nonatomic, assign) NSInteger dismissedGifsCount;

@end

@implementation GifFeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor midnightBlue];

    self.gifs = [NSMutableArray new];
    self.dismissedGifsCount = 0;
    self.loadedGifsCount = 0;

    self.noContentView = [NoContentView newAutoLayoutView];
    self.noContentView.titleLabel.text = @"Loading cats";
    self.noContentView.descriptionLabel.text = @"Looking for more cats";
    self.noContentView.loadingMoreContent = YES;
    [self.view addSubview:self.noContentView];
    [self.noContentView autoCenterInSuperview];
    [self.noContentView autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:self.view withOffset:-40];

    self.pagedView = [PagedView newAutoLayoutView];
    [self.view addSubview:self.pagedView];
    [self.pagedView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];

    self.gifFetcher = [[GifFetcher alloc] init];
    self.gifFetcher.delegate = self;
    [self.gifFetcher fetchCatGifs];
}

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)createSwipePageWithGif:(Gif *)gif image:(FLAnimatedImage *)image
{
    CardView *cardView = [CardView newAutoLayoutView];
    cardView.delegate = self;
    [cardView configureViewWithGif:gif image:image];
    SwipeView *swipeView = [SwipeView newAutoLayoutView];
    swipeView.delegate = self;

    [swipeView setContentView:cardView];
    [self.pagedView addPage:swipeView];
    [self tintPages:self.pagedView.pages];

    [cardView autoMatchDimension:ALDimensionWidth toDimension:ALDimensionWidth ofView:self.view withOffset:-20];
    [UIView autoSetPriority:UILayoutPriorityRequired forConstraints:^{
        [cardView autoMatchDimension:ALDimensionHeight toDimension:ALDimensionHeight ofView:self.pagedView withOffset:-40 relation:NSLayoutRelationLessThanOrEqual];
    }];
    [cardView autoCenterInSuperview];
    [swipeView autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
}

- (void)tintPages:(NSArray *)pages
{
    for(int i = 0; i < pages.count; i++) {
        UIView *page = pages[i];
        CardView *cardView = page.subviews[0];
        if (i < kMaxVisiblePages) {
            [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
                cardView.backgroundColor = [[UIColor clouds] darkenColor:0.1 * i];
                cardView.alpha = 1;
            } completion:nil];
        } else {
            cardView.alpha = 0;
        }
    }
}

#pragma mark - SwipeViewDelegate

- (void)swipeViewWasDismissed:(SwipeView *)swipeView
{
    self.dismissedGifsCount++;

    if (self.loadedGifsCount < self.dismissedGifsCount + kLoadMoreThreshold) {
        [self.gifFetcher fetchCatGifs];
    }
}

- (void)swipeViewDidMove:(SwipeView *)view
{
    if (!CGRectIntersectsRect(self.view.bounds, view.contentView.frame)) {
        [self.pagedView removePage:view];
        [self tintPages:self.pagedView.pages];
    }
}

#pragma mark - CardViewDelegate

-(void)cardViewDidSelectShare:(CardView *)cardView
{
    Gif *gif = self.gifs[self.dismissedGifsCount];

    UIActivityViewController *activityViewController =
    [[UIActivityViewController alloc] initWithActivityItems:@[gif.title, gif.url]
                                      applicationActivities:nil];

    [self presentViewController:activityViewController animated:YES completion:nil];
}

#pragma mark - GifFetcherDelegate

- (void)gifWasDownloaded:(Gif *)gif withImage:(FLAnimatedImage *)image
{
    [self.gifs addObject:gif];
    [self createSwipePageWithGif:gif image:(FLAnimatedImage *)image];
    self.loadedGifsCount++;
}

@end
