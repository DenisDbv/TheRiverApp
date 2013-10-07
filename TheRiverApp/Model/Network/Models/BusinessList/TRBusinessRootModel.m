//
//  TRBusinessRootModel.m
//  TheRiverApp
//
//  Created by DenisDbv on 29.09.13.
//  Copyright (c) 2013 axbx. All rights reserved.
//

#import "TRBusinessRootModel.h"
#import "TRBusinessModel.h"

@implementation TRBusinessRootModel
@synthesize business;

+ (Class)business_class {
    return [TRBusinessModel class];
}

@end
