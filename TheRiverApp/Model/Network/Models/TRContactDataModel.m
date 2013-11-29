//
//  TRContactDataModel.m
//  TheRiverApp
//
//  Created by DenisDbv on 02.10.13.
//  Copyright (c) 2013 axbx. All rights reserved.
//

#import "TRContactDataModel.h"

@implementation TRContactDataModel
@synthesize phone, skype, fb, vk, thegame;

+ (Class)phone_class {
    return [NSArray class];
}

@end
