//
//  TRPUserListModel.m
//  TheRiverApp
//
//  Created by DenisDbv on 27.09.13.
//  Copyright (c) 2013 axbx. All rights reserved.
//

#import "TRPUserListModel.h"
#import "TRUserInfoModel.h"

@implementation TRPUserListModel
@synthesize user;

+ (Class)user_class {
    return [TRUserInfoModel class];
}

@end
