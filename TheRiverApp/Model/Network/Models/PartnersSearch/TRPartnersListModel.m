//
//  TRPartnersListModel.m
//  TheRiverApp
//
//  Created by DenisDbv on 28.09.13.
//  Copyright (c) 2013 axbx. All rights reserved.
//

#import "TRPartnersListModel.h"

@implementation TRPartnersListModel
@synthesize fio, cities, industries, interests, query;

+ (Class)fio_class {
    return [TRUserInfoModel class];
}

+ (Class)cities_class {
    return [TRUserInfoModel class];
}

+ (Class)industries_class {
    return [TRUserInfoModel class];
}

+ (Class)interests_class {
    return [TRUserInfoModel class];
}

@end
