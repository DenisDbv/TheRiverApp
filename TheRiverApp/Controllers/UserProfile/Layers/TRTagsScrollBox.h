//
//  TRTagsScrollBox.h
//  TheRiverApp
//
//  Created by DenisDbv on 04.09.13.
//  Copyright (c) 2013 axbx. All rights reserved.
//

#import "TRRootBox.h"
#import <DWTagList/DWTagList.h>
#import "TRTagsBox.h"

@interface TRTagsScrollBox : TRRootBox <DWTagListDelegate>

@property (nonatomic, retain) TRTagsBox *rootBox;

+(TRTagsScrollBox *)initBoxWithTitle:(NSString*)title andTagsArray:(NSArray*)tagsArray byTarget:(TRTagsBox*)target;

@end
