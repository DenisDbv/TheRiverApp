//
//  UISearchBar+cancelButton.m
//  TheRiverApp
//
//  Created by DenisDbv on 06.09.13.
//  Copyright (c) 2013 axbx. All rights reserved.
//

#import "UISearchBar+cancelButton.h"

@implementation UISearchBar (cancelButton)

- (UIButton *) cancelButton {
    for (UIView *subView in self.subviews) {
        //Find the button
        if([subView isKindOfClass:[UIButton class]])
        {
            return (UIButton *)subView;
        }
    }
    
    NSLog(@"Error: no cancel button found on %@", self);
    
    return nil;
}

-(void) renameGlobalCancelButonsByTitle:(NSString *)title
{
    [[UIButton appearanceWhenContainedIn:[UISearchBar class], nil] setTitle:title forState:UIControlStateNormal];
}

@end
