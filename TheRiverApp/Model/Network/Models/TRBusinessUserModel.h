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

@property (nonatomic, copy) NSNumber *id;
@property (nonatomic, copy) NSString *logo;
@property (nonatomic, copy) NSString *company_name;
@property (nonatomic, copy) NSString *about;
@property (nonatomic, copy) NSString *profit;
@property (nonatomic, copy) NSString *employees;
@property (nonatomic, copy) NSString *desc;

@property (nonatomic, retain) NSArray *industries;

@end
