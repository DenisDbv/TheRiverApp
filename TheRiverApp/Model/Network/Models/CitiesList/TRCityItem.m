//
//  TRCityItem.m
//  TheRiverApp
//
//  Created by DenisDbv on 20.10.13.
//  Copyright (c) 2013 axbx. All rights reserved.
//

#import "TRCityItem.h"

@implementation TRCityItem
@synthesize name;

-(id)copyWithZone:(NSZone *)zone
{
    id copy = [[[self class] allocWithZone:zone] init];
    [copy setName:[self name]];
    return copy;
}

@end
