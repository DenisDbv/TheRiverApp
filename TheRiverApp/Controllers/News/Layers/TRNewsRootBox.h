//
//  TRBusinessRootBox.h
//  TheRiverApp
//
//  Created by DenisDbv on 10.09.13.
//  Copyright (c) 2013 axbx. All rights reserved.
//

#import "MGBox.h"

@interface TRNewsRootBox : MGBox

@property (nonatomic, strong) TRNewsItem *newsItem;

+(MGBox *) initBox:(CGSize)bounds;
+(MGBox *) initBox:(CGSize)bounds withNewsData:(TRNewsItem*)newsItem;
+(MGBox *) initBox:(CGSize)bounds withNewsData:(TRNewsItem*)newsItem byTarget:(id)target;

@end
