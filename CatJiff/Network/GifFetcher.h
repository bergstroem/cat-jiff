//
//  GifFetcher.h
//  CatJiff
//
//  Created by Mattias Bergström on 21/02/15.
//  Copyright (c) 2015 Mattias Bergström. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Gif;
@class FLAnimatedImage;

@protocol GifFetcherDelegate <NSObject>

- (void)gifWasDownloaded:(Gif *)gif withImage:(FLAnimatedImage *)image;

@end

@interface GifFetcher : NSObject

- (void)fetchCatGifs;

@property (nonatomic, weak) id<GifFetcherDelegate> delegate;

@end
