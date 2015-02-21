//
//  PagedView.m
//  CatJiff
//
//  Created by Mattias Bergström on 18/02/15.
//  Copyright (c) 2015 Mattias Bergström. All rights reserved.
//

#import "PagedView.h"

static NSInteger const kVisiblePagesCount = 3;
static CGFloat const kScaleAmount = 20.0f;
static CGFloat const kTranslationAmount = 15.0f;

@implementation PagedView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit
{

}

- (void)addPage:(UIView *)page
{
    page.layer.opacity = 0;
    [self insertSubview:page atIndex:0];

    [self updatePageOverlays];
}

- (void)removePage:(UIView *)page
{
    [page removeFromSuperview];

    [self updatePageOverlays];
}

- (void)updatePageOverlays
{
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        for (int i = 1; i < self.subviews.count + 1; i++) {
            unsigned long backIndex = self.subviews.count - i;
            UIView *view = self.subviews[i - 1];

            float scaleFraction = backIndex / kScaleAmount;

            scaleFraction = MIN(1, scaleFraction);

            CATransform3D translation = CATransform3DMakeTranslation(0, kTranslationAmount * backIndex, 0);
            CATransform3D scale = CATransform3DMakeScale(1 - scaleFraction, 1 - scaleFraction, 1 - scaleFraction);
            view.layer.transform = CATransform3DConcat(scale, translation);

            if (backIndex < kVisiblePagesCount) {
                NSInteger lower = self.subviews.count - kVisiblePagesCount;
                view.layer.opacity = (i - lower) / (float)kVisiblePagesCount;
            } else {
                view.layer.opacity = 0;
            }
        }
    } completion:nil];
}


@end
