//
//  UISearchBar+cancelButton.h
//  TheRiverApp
//
//  Created by DenisDbv on 06.09.13.
//  Copyright (c) 2013 axbx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UISearchBar (cancelButton)

@property (readonly) UIButton* cancelButton;

- (UIButton *) cancelButton;

-(void) renameGlobalCancelButonsByTitle:(NSString*)title;

@end
