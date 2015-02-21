//
//  Gif.h
//  CatJiff
//
//  Created by Mattias Bergström on 21/02/15.
//  Copyright (c) 2015 Mattias Bergström. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Gif : NSObject

+(Gif*)fromJson:(NSDictionary*)catJson;

@property (nonatomic, strong) NSString* url;
@property (nonatomic, strong) NSString* title;
@property (nonatomic, strong) NSString* identifier;


@end
