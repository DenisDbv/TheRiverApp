//
//  TRWebView.h
//  TheRiverApp
//
//  Created by DenisDbv on 16.10.13.
//  Copyright (c) 2013 axbx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TRWebView : UIView <UIWebViewDelegate>
{
    UIButton* _closeButton;
    UIInterfaceOrientation _orientation;
    BOOL _showingKeyboard;
    
    // Ensures that UI elements behind the dialog are disabled.
    UIView* _modalBackgroundView;
}

@property (nonatomic) id delegate;

@property(nonatomic) UIWebView* webView;
@property(nonatomic) UIActivityIndicatorView* spinner;

-(void)show;

@end
