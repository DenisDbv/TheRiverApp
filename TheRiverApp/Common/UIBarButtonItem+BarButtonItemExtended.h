//
//  UIBarButtonItem+BarButtonItemExtended.h
//  TheRiverApp
//
//  Created by DenisDbv on 10.09.13.
//  Copyright (c) 2013 axbx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (BarButtonItemExtended)
+ (UIBarButtonItem*)barItemWithImage:(UIImage*)image target:(id)target action:(SEL)action;
@end
