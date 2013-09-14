//
//  TRBusinessRootBox.h
//  TheRiverApp
//
//  Created by DenisDbv on 10.09.13.
//  Copyright (c) 2013 axbx. All rights reserved.
//

#import "MGBox.h"

@interface TRBusinessRootBox : MGBox

@property (nonatomic, strong) TRBusinessModel *businessData;

+(MGBox *) initBox:(CGSize)bounds;
+(MGBox *) initBox:(CGSize)bounds withMindData:(TRBusinessModel *)businessObject;
+(MGBox *) initBox:(CGSize)bounds withUserData:(TRBusinessModel*)userObject byTarget:(id)target;

@end
