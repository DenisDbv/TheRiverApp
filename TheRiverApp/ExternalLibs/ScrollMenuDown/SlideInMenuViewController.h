//
//  SlideInMenuViewController.h
//  FINN
//
//  Created by Langstrand, Alexander on 29.01.13.
//  Copyright (c) 2013 FINN.no. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum {
    Upwards = -1,
    None = 0,
    Downwards = 1
} ScrollDirection;

@interface SlideInMenuViewController : UIViewController<UIScrollViewDelegate>
-(id)initWithMenuView:(UIView *)menu;

@end


