//
//  UIView+GestureBlocks.h
//  TheRiverApp
//
//  Created by DenisDbv on 02.09.13.
//  Copyright (c) 2013 axbx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <objc/runtime.h>

@interface UIView (GestureBlocks)

@property (readwrite, nonatomic, copy) void (^tapHandler)(UIGestureRecognizer *sender);

- (void)initialiseTapHandler:(void (^) (UIGestureRecognizer *sender))block forTaps:(int)numberOfTaps;
- (IBAction)handleTap:(UIGestureRecognizer *)sender;

@end