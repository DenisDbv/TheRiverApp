//
//  TRPartnersListModel.m
//  TheRiverApp
//
//  Created by DenisDbv on 28.09.13.
//  Copyright (c) 2013 axbx. All rights reserved.
//

#import "TRPartnersListModel.h"

@implementation TRPartnersListModel
@synthesize fio, cities, scope_work, interests;

+ (Class)fio_class {
    return [TRUserInfoModel class];
}

+ (Class)cities_class {
    return [TRUserInfoModel class];
}

+ (Class)scope_work_class {
    return [TRUserInfoModel class];
}

+ (Class)interests_class {
    return [TRUserInfoModel class];
}

@end
