//
//  TRContactsSearchBar.m
//  TheRiverApp
//
//  Created by DenisDbv on 03.10.13.
//  Copyright (c) 2013 axbx. All rights reserved.
//

#import "TRContactsSearchBar.h"
#import <QuartzCore/QuartzCore.h>

@implementation TRContactsSearchBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if([AppDelegateInstance() osVersion] < 7)   {
        
        for (UIView *subview in self.subviews) {
            // Remove the default background
            if ([subview isKindOfClass:NSClassFromString(@"UISearchBarBackground")]) {
                [subview removeFromSuperview];
            }
            
            // Remove the rounded corners
            if ([subview isKindOfClass:NSClassFromString(@"UITextField")]) {
                UITextField *textField = (UITextField *)subview;
                //textField.font = [UIFont fontWithName:@"HypatiaSansPro-Regular" size:16];
                textField.frame = CGRectMake(textField.frame.origin.x, textField.frame.origin.y, textField.frame.size.width-6, 35);
                textField.backgroundColor = [UIColor whiteColor];
                textField.layer.borderWidth = 1.0f;
                textField.layer.cornerRadius = 6;
                textField.layer.borderColor = [[UIColor lightGrayColor] CGColor];
                
                for (UIView *subsubview in textField.subviews) {
                    if ([subsubview isKindOfClass:NSClassFromString(@"UITextFieldBorderView")]) {
                        [subsubview removeFromSuperview];
                    }
                }
            }
            
            if ([subview isKindOfClass:[UIButton class]])
            {
                UIButton *cancelButton = (UIButton*)subview;
                
                [cancelButton setTintColor: [UIColor clearColor]];
                [cancelButton setBackgroundColor:[UIColor clearColor]];
                [cancelButton setBackgroundImage:[UIImage new] forState:UIControlStateNormal];
                [cancelButton setBackgroundImage:[UIImage new] forState:UIControlStateHighlighted];
                
                cancelButton.frame = CGRectOffset(cancelButton.frame, -7, 2);
            }
        }
        
    } else  {
    
        NSArray *searchBarSubViews = [[self.subviews objectAtIndex:0] subviews];
        for (UIView *subsubview in searchBarSubViews)   {
            
            if ([subsubview isKindOfClass:NSClassFromString(@"UISearchBarBackground")]) {
                [subsubview removeFromSuperview];
            }
            
            if ([subsubview isKindOfClass:NSClassFromString(@"UITextField")]) {
                UITextField *textField = (UITextField *)subsubview;
                //textField.font = [UIFont fontWithName:@"HypatiaSansPro-Regular" size:16];
                textField.frame = CGRectMake(textField.frame.origin.x, textField.frame.origin.y, textField.frame.size.width-6, 35);
                textField.backgroundColor = [UIColor whiteColor];
                textField.layer.borderWidth = 1.0f;
                textField.layer.cornerRadius = 6;
                textField.layer.borderColor = [[UIColor lightGrayColor] CGColor];
                
                for (UIView *subsubview in textField.subviews) {
                    if ([subsubview isKindOfClass:NSClassFromString(@"UITextFieldBorderView")]) {
                        [subsubview removeFromSuperview];
                    }
                }
            }
            
            if ([subsubview isKindOfClass:[UIButton class]])
            {
                UIButton *cancelButton = (UIButton*)subsubview;
                
                [cancelButton setTintColor: [UIColor clearColor]];
                [cancelButton setBackgroundColor:[UIColor clearColor]];
                [cancelButton setBackgroundImage:[UIImage new] forState:UIControlStateNormal];
                [cancelButton setBackgroundImage:[UIImage new] forState:UIControlStateHighlighted];
                
                cancelButton.frame = CGRectOffset(cancelButton.frame, -7, 5);
            }
        }
        
    }
}

@end
