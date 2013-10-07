//
//  TRTagsBox.h
//  TheRiverApp
//
//  Created by DenisDbv on 08.09.13.
//  Copyright (c) 2013 axbx. All rights reserved.
//

#import "TRRootBox.h"
#import "TRUserProfileController.h"

@interface TRTagsBox : TRRootBox

@property (nonatomic, retain) TRUserProfileController *rootBox;

-(void) selectTag:(NSInteger)tag atName:(NSString*)text;

@end
