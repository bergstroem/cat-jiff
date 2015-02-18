//
//  PagedView.h
//  CatJiff
//
//  Created by Mattias Bergström on 18/02/15.
//  Copyright (c) 2015 Mattias Bergström. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PagedView : UIView

- (void)addPage:(UIView *)page;
- (void)removePage:(UIView *)page;

@end
