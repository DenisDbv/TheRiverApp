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

@interface TRUserInfoModel : Jastor <NSCoding>

@property (nonatomic, copy) NSNumber *id;
@property (nonatomic, copy) NSString *logo;
@property (nonatomic, copy) NSString *first_name;
@property (nonatomic, copy) NSString *last_name;
@property (nonatomic, copy) NSString *age;
@property (nonatomic, copy) NSString *city;
@property (nonatomic, copy) NSString *sex;

@property (nonatomic, retain) NSArray *interests;
@property (nonatomic, retain) TRBusinessUserModel *business;

@end
