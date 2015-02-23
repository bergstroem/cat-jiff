//
//  CardView.h
//  CatJiff
//
//  Created by Mattias Bergström on 21/02/15.
//  Copyright (c) 2015 Mattias Bergström. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FLAnimatedImageView;
@class ShareButton;
@class CardView;

@protocol CardViewDelegate <NSObject>

- (void)cardViewDidSelectShare:(CardView *)cardView;

@end

@interface CardView : UIView

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) FLAnimatedImageView *imageView;
@property (nonatomic, strong) ShareButton *shareButton;

@property (nonatomic, assign) BOOL expanded;

@property (nonatomic, weak) id<CardViewDelegate> delegate;

@end
