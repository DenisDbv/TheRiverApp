//
//  TRMindRootBox.h
//  TheRiverApp
//
//  Created by DenisDbv on 09.09.13.
//  Copyright (c) 2013 axbx. All rights reserved.
//

#import "MGBox.h"

@interface TRMindRootBox : MGBox

@property (nonatomic, strong) TRMindModel *mindData;

+(MGBox *) initBox:(CGSize)bounds;
+(MGBox *) initBox:(CGSize)bounds withMindData:(TRMindModel *)mindObject;
+(MGBox *) initBox:(CGSize)bounds withUserData:(TRUserModel*)userObject byTarget:(id)target;

@end
