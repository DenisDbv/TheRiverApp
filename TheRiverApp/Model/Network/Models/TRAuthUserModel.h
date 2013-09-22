//
//  TRAuthUserModel.h
//  TheRiverApp
//
//  Created by DenisDbv on 21.09.13.
//  Copyright (c) 2013 axbx. All rights reserved.
//

#import "Jastor.h"
#import "TRUserInfoModel.h"

@interface TRAuthUserModel : Jastor <NSCoding>

@property (nonatomic, copy) NSString *token;
@property (nonatomic, copy) NSString *email;
@property (nonatomic, retain) TRUserInfoModel *user;

@end
