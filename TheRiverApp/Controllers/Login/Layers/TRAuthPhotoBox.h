//
//  TRAuthPhotoBox.h
//  TheRiverApp
//
//  Created by DenisDbv on 18.11.13.
//  Copyright (c) 2013 axbx. All rights reserved.
//

#import "MGBox.h"

@interface TRAuthPhotoBox : MGBox

+ (TRAuthPhotoBox *)photoAddBoxWithFileName:(NSString*)fileName andTag:(NSInteger)tag;

-(void) show;

@end
