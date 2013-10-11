//
//  TRUserInfoModel.h
//  TheRiverApp
//
//  Created by DenisDbv on 22.09.13.
//  Copyright (c) 2013 axbx. All rights reserved.
//

#import "Jastor.h"
#import "TRUserResolutionModel.h"
#import "TRBusinessUserModel.h"
#import "TRContactDataModel.h"

@interface TRUserInfoModel : Jastor

@property (nonatomic, copy) NSNumber *id;
@property (nonatomic, copy) NSString *logo;
@property (nonatomic, copy) NSString *logo_profile;
@property (nonatomic, copy) NSString *logo_cell;
@property (nonatomic, copy) NSString *first_name;
@property (nonatomic, copy) NSString *last_name;
@property (nonatomic, copy) NSString *age;
@property (nonatomic, copy) NSString *city;
@property (nonatomic, copy) NSString *sex;
@property (nonatomic, copy) NSString *profit;
@property (nonatomic, copy) NSString *email;

@property (nonatomic, retain) NSArray *interests;
@property (nonatomic, retain) TRBusinessUserModel *business;
@property (nonatomic, retain) TRContactDataModel *contact_data;

@end
