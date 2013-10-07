//
//  TRUserProfileController.h
//  TheRiverApp
//
//  Created by DenisDbv on 03.09.13.
//  Copyright (c) 2013 axbx. All rights reserved.
//

#import "TRCenterRootController.h"

@class TRUserInfoModel;

@interface TRUserProfileController : TRCenterRootController

@property (nonatomic, retain) TRUserInfoModel *userDataObject;

-(id) initByUserModel:(TRUserInfoModel*)userObject isIam:(BOOL)isIam;

@end
