//
//  TRAuthPhotoBox.h
//  TheRiverApp
//
//  Created by DenisDbv on 18.11.13.
//  Copyright (c) 2013 axbx. All rights reserved.
//

#import "MGBox.h"

@interface TRAuthPhotoBox : MGBox

@property (nonatomic, strong) NSString *photoName;

+ (TRAuthPhotoBox *)photoAddBoxWithFileName:(NSString*)fileName andTag:(NSInteger)tag;

-(void) changePhotoTo:(NSString*)fileName;

@end
