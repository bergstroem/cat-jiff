//
//  GifFeedViewController.h
//  CatJiff
//
//  Created by Mattias Bergström on 21/02/15.
//  Copyright (c) 2015 Mattias Bergström. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SwipeView.h"
#import "CardView.h"
#import "GifFetcher.h"

@interface GifFeedViewController : UIViewController <SwipeViewDelegate, GifFetcherDelegate, CardViewDelegate>

@end
