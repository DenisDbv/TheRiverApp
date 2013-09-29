//
//  TRBusinessUserModel.h
//  TheRiverApp
//
//  Created by DenisDbv on 23.09.13.
//  Copyright (c) 2013 axbx. All rights reserved.
//

#import "Jastor.h"
#import "TRBusinessScopeModel.h"

@interface TRBusinessUserModel : Jastor

@property (nonatomic, copy) NSString *logo_url;
@property (nonatomic, copy) NSString *company_name;
@property (nonatomic, copy) NSString *activity_description;
@property (nonatomic, copy) NSString *turnover_per_month;
@property (nonatomic, copy) NSString *text;

@property (nonatomic, retain) NSArray *scope_work;

@end
