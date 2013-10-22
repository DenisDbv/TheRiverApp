//
//  TRIndustriesListModel.m
//  TheRiverApp
//
//  Created by DenisDbv on 20.10.13.
//  Copyright (c) 2013 axbx. All rights reserved.
//

#import "TRIndustriesListModel.h"
#import "TRIndustriesItem.h"

@implementation TRIndustriesListModel
@synthesize scope_works;

+ (Class)scope_works_class {
    return [TRIndustriesItem class];
}

@end
