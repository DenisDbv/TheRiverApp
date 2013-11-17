//
//  TRNewsModel.m
//  TheRiverApp
//
//  Created by DenisDbv on 14.11.13.
//  Copyright (c) 2013 axbx. All rights reserved.
//

#import "TRNewsModel.h"

@implementation TRNewsModel
@synthesize status, news, num_pages, count_last_news;

+ (Class)news_class {
    return [TRNewsItem class];
}

@end

@implementation TRNewsItem
@synthesize date_create, text, title, logo;

@end
