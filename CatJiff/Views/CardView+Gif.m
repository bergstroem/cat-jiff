//
//  CardView+Gif.m
//  CatJiff
//
//  Created by Mattias Bergström on 21/02/15.
//  Copyright (c) 2015 Mattias Bergström. All rights reserved.
//

#import "CardView+Gif.h"
#import "Gif.h"

#import <FLAnimatedImageView.h>

@implementation CardView (Gif)

- (void)configureViewWithGif:(Gif *)gif image:(FLAnimatedImage *)image
{
    self.titleLabel.text = gif.title;
    self.imageView.animatedImage = image;
}

@end
