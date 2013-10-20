//
//  TRCitiesListModel.m
//  TheRiverApp
//
//  Created by DenisDbv on 20.10.13.
//  Copyright (c) 2013 axbx. All rights reserved.
//

#import "TRCitiesListModel.h"
#import "TRCityItem.h"

@implementation TRCitiesListModel
@synthesize citys;

+ (Class)citys_class {
    return [TRCityItem class];
}

@end
