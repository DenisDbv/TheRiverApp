//
//  TRNewsModel.h
//  TheRiverApp
//
//  Created by DenisDbv on 14.11.13.
//  Copyright (c) 2013 axbx. All rights reserved.
//

#import "Jastor.h"

@class TRNewsItem;

@interface TRNewsModel : Jastor

@property (nonatomic, copy) NSString *status;
@property (nonatomic, strong) NSArray *news;
@property (nonatomic, copy) NSString *num_pages;
@property (nonatomic, copy) NSString *count_last_news;

@end

@interface TRNewsItem : Jastor

@property (nonatomic, copy) NSString *date_create;
@property (nonatomic, copy) NSString *text;
@property (nonatomic, copy) NSString *logo;
@property (nonatomic, copy) NSString *title;

@end
