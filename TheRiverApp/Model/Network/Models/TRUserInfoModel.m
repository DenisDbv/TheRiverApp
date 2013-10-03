//
//  TRUserInfoModel.m
//  TheRiverApp
//
//  Created by DenisDbv on 22.09.13.
//  Copyright (c) 2013 axbx. All rights reserved.
//

#import "TRUserInfoModel.h"

@implementation TRUserInfoModel
@synthesize id, first_name, last_name, sex, age, city, logo, profit, business, contact_data;
@synthesize interests;

+ (Class)interests_class {
    return [TRUserResolutionModel class];
}

@end
