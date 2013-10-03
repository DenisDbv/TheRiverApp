//
//  TRContactsListModel.m
//  TheRiverApp
//
//  Created by DenisDbv on 02.10.13.
//  Copyright (c) 2013 axbx. All rights reserved.
//

#import "TRContactsListModel.h"

@implementation TRContactsListModel

@synthesize user;

+ (Class)user_class {
    return [TRUserInfoModel class];
}

@end
