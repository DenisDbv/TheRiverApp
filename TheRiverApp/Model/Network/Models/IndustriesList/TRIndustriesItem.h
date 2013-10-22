//
//  TRIndustriesItem.h
//  TheRiverApp
//
//  Created by DenisDbv on 20.10.13.
//  Copyright (c) 2013 axbx. All rights reserved.
//

#import "Jastor.h"

@interface TRIndustriesItem : Jastor

@property (nonatomic, copy) NSString *name;

-(id)copyWithZone:(NSZone *)zone;

@end
