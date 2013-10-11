//
//  TRBusinessModel.h
//  TheRiverApp
//
//  Created by DenisDbv on 29.09.13.
//  Copyright (c) 2013 axbx. All rights reserved.
//

#import "Jastor.h"

@interface TRBusinessModel : Jastor

@property (nonatomic, copy) NSString *first_name;
@property (nonatomic, copy) NSString *last_name;
@property (nonatomic, copy) NSString *age;
@property (nonatomic, copy) NSString *city;

@property (nonatomic, copy) NSString *logo;
@property (nonatomic, copy) NSString *logo_desc;
@property (nonatomic, copy) NSString *logo_cell;
@property (nonatomic, copy) NSString *company_name;
@property (nonatomic, copy) NSString *about;
@property (nonatomic, copy) NSString *profit;

@end
