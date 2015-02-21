//
//  GifFetcher.m
//  CatJiff
//
//  Created by Mattias Bergström on 21/02/15.
//  Copyright (c) 2015 Mattias Bergström. All rights reserved.
//

#import "GifFetcher.h"
#import "Gif.h"

#import <FLAnimatedImage.h>

static NSInteger const kItemsPerPage = 40;
static NSString * const kBaseUrl = @"http://www.reddit.com/r/catgifs.json";

@interface GifFetcher ()

@property (nonatomic, strong) NSOperationQueue *gifQueue;
@property (nonatomic, strong) NSString *afterId;

@end

@implementation GifFetcher

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.gifQueue = [[NSOperationQueue alloc] init];
        self.gifQueue.maxConcurrentOperationCount = 1;
    }
    return self;
}

- (void)fetchCatGifs
{
    NSString *catUrl = [kBaseUrl stringByAppendingString:[NSString stringWithFormat:@"?limit=%li", kItemsPerPage]];

    if (self.afterId) {
        catUrl = [catUrl stringByAppendingString:[NSString stringWithFormat:@"&after=%@", self.afterId]];
    }

    __weak typeof(self)welf = self;
    NSURLSession *session = [NSURLSession sharedSession];
    [[session dataTaskWithURL:[NSURL URLWithString:catUrl]
            completionHandler:^(NSData *data,
                                NSURLResponse *response,
                                NSError *error) {

                    NSDictionary* parsedResponse = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];

                        parsedResponse = parsedResponse[@"data"];
                        NSArray* catsResponse = parsedResponse[@"children"];
                        NSMutableArray* cats = [NSMutableArray arrayWithCapacity:catsResponse.count];
                        for(NSDictionary* catJson in catsResponse) {
                            NSDictionary* catJsonData = catJson[@"data"];
                            NSString* url = catJsonData[@"url"];
                            if([url rangeOfString:@".gif"].location == url.length - 4) {
                                Gif* catGif = [Gif fromJson:catJsonData];
                                [cats addObject:catGif];

                                [welf.gifQueue addOperationWithBlock:^{
                                    FLAnimatedImage *image = [FLAnimatedImage animatedImageWithGIFData:[NSData dataWithContentsOfURL:[NSURL URLWithString:catGif.url]]];
                                    if (image) {
                                        dispatch_async(dispatch_get_main_queue(), ^{
                                            if (welf.delegate) {
                                                [welf.delegate gifWasDownloaded:catGif withImage:image];
                                            }
                                        });
                                    }

                                }];
                            }
                        }

                        Gif *lastCat = cats.lastObject;
                        welf.afterId = [NSString stringWithFormat:@"t3_%@", lastCat.identifier];
            }] resume];
}

@end
