//
//  CardView.h
//  CatJiff
//
//  Created by Mattias Bergström on 21/02/15.
//  Copyright (c) 2015 Mattias Bergström. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FLAnimatedImageView;

@interface CardView : UIView

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) FLAnimatedImageView *imageView;
@property (nonatomic, strong) UIButton *shareButton;

@property (nonatomic, assign) BOOL expanded;

@end
