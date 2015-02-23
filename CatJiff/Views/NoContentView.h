//
//  NoContentView.h
//  CatJiff
//
//  Created by Mattias Bergström on 23/02/15.
//  Copyright (c) 2015 Mattias Bergström. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NoContentView : UIView

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *descriptionLabel;
@property (nonatomic, strong) UIActivityIndicatorView *loadingSpinner;

@property (nonatomic, assign) BOOL loadingMoreContent;

@end
