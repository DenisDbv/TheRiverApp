//
//  TRMindModel.m
//  TheRiverApp
//
//  Created by DenisDbv on 26.11.13.
//  Copyright (c) 2013 axbx. All rights reserved.
//

#import "TRMindModel.h"

@implementation TRMindModel
@synthesize status, items_in_page, num_pages, bd;

+ (Class)bd_class {
    return [TRMindItem class];
}

@end

@implementation TRMindItem
@synthesize id, logo, date_create, title, text;

@end

