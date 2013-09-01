//
//  UISearchBar+CancelBtnShow.m
//  TheRiverApp
//
//  Created by DenisDbv on 02.09.13.
//  Copyright (c) 2013 axbx. All rights reserved.
//

#import "UISearchBar+CancelBtnShow.h"

@implementation UISearchBar (CancelBtnShow)

- (BOOL)resignFirstResponder
{
    for (UIView *v in self.subviews) {
        // Force the cancel button to stay enabled
        if ([v isKindOfClass:[UIControl class]]) {
            ((UIControl *)v).enabled = YES;
        }
        
        // Dismiss the keyboard
        if ([v isKindOfClass:[UITextField class]]) {
            [(UITextField *)v resignFirstResponder];
        }
    }
    
    return YES;
}

@end
