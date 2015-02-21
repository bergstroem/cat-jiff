//
//  Gif.m
//  CatJiff
//
//  Created by Mattias Bergström on 21/02/15.
//  Copyright (c) 2015 Mattias Bergström. All rights reserved.
//

#import "Gif.h"

@implementation Gif

+(Gif*)fromJson:(NSDictionary*)catJson {
    Gif* gif = [Gif new];
    gif.title = catJson[@"title"];
    gif.url = catJson[@"url"];
    gif.identifier = catJson[@"id"];
    return gif;
}

@end
