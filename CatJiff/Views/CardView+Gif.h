//
//  CardView+Gif.h
//  CatJiff
//
//  Created by Mattias Bergström on 21/02/15.
//  Copyright (c) 2015 Mattias Bergström. All rights reserved.
//

#import "CardView.h"

@class Gif;
@class FLAnimatedImage;

@interface CardView (Gif)

- (void)configureViewWithGif:(Gif *)gif image:(FLAnimatedImage *)image;

@end
