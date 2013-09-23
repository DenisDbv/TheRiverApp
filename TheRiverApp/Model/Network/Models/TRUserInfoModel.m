//
//  TRUserInfoModel.m
//  TheRiverApp
//
//  Created by DenisDbv on 22.09.13.
//  Copyright (c) 2013 axbx. All rights reserved.
//

#import "TRUserInfoModel.h"

@implementation TRUserInfoModel
@synthesize id, first_name, last_name, sex, age, city, logo, business;
@synthesize interests;

+ (Class)interests_class {
    return [TRUserResolutionModel class];
}

+ (Class)business_class {
    return [TRBusinessUserModel class];
}

@end
