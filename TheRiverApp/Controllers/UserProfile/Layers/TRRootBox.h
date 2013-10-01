//
//  TRRootBox.h
//  TheRiverApp
//
//  Created by DenisDbv on 06.09.13.
//  Copyright (c) 2013 axbx. All rights reserved.
//

#import "MGBox.h"

@interface TRRootBox : MGBox

@property (nonatomic, strong) TRUserInfoModel *userData;

+(MGBox *) initBox:(CGSize)bounds;
+(MGBox *) initBox:(CGSize)bounds withUserData:(TRUserInfoModel*)userObject;
+(MGBox *) initBox:(CGSize)bounds withUserData:(TRUserInfoModel*)userObject byTarget:(id)target;

@end
