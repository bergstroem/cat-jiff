//
//  PagedView.m
//  CatJiff
//
//  Created by Mattias Bergström on 18/02/15.
//  Copyright (c) 2015 Mattias Bergström. All rights reserved.
//

#import "PagedView.h"

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
            UIView *view = self.subviews[i-1];

            float scaleFactor = backIndex / (float)10;

            scaleFactor = MIN(1, scaleFactor);

            CATransform3D translation = CATransform3DMakeTranslation(0, 30 * backIndex, 0);
            CATransform3D scale = CATransform3DMakeScale(1 - scaleFactor, 1 - scaleFactor, 1 - scaleFactor);
            view.layer.transform = CATransform3DConcat(scale, translation);
            view.layer.opacity = i / (float)self.subviews.count;
        }
    } completion:nil];
}


@end
