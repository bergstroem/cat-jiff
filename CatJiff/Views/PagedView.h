//
//  PagedView.h
//  CatJiff
//
//  Created by Mattias Bergström on 18/02/15.
//  Copyright (c) 2015 Mattias Bergström. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PagedView : UIView

@property (nonatomic, strong) NSArray *pages;

- (void)addPage:(UIView *)page;
- (void)removePage:(UIView *)page;

@end
