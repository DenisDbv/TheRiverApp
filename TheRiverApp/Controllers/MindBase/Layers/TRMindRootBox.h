//
//  TRMindRootBox.h
//  TheRiverApp
//
//  Created by DenisDbv on 09.09.13.
//  Copyright (c) 2013 axbx. All rights reserved.
//

#import "MGBox.h"

@interface TRMindRootBox : MGBox

@property (nonatomic, strong) TRMindItem *mindData;

+(MGBox *) initBox:(CGSize)bounds;
+(MGBox *) initBox:(CGSize)bounds withMindData:(TRMindItem *)mindObject;

@end
