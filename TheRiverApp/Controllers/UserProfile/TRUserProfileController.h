//
//  TRUserProfileController.h
//  TheRiverApp
//
//  Created by DenisDbv on 03.09.13.
//  Copyright (c) 2013 axbx. All rights reserved.
//

#import "TRCenterRootController.h"

@class TRUserModel;

@interface TRUserProfileController : TRCenterRootController

@property (nonatomic, retain) TRUserModel *userDataObject;

-(id) initByUserModel:(TRUserModel*)userObject;

@end
