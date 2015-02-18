//
//  SwipeView.h
//  CatJiff
//
//  Created by Mattias Bergström on 18/02/15.
//  Copyright (c) 2015 Mattias Bergström. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SwipeView;

@protocol SwipeViewDelegate <NSObject>

- (void)swipeViewWasDismissed:(SwipeView *)swipeView;
- (void)swipeViewDidMove:(SwipeView *)swipeView;

@end

@interface SwipeView : UIView

@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, weak) id<SwipeViewDelegate> delegate;

@end
