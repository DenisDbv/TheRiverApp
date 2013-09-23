//
//  TRBusinessUserModel.m
//  TheRiverApp
//
//  Created by DenisDbv on 23.09.13.
//  Copyright (c) 2013 axbx. All rights reserved.
//

#import "TRBusinessUserModel.h"

@implementation TRBusinessUserModel
@synthesize text, logo_url, scope_work;

+ (Class)scope_work_class {
    return [TRBusinessScopeModel class];
}

@end
