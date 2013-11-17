//
//  TRAuthViewController.h
//  TheRiverApp
//
//  Created by DenisDbv on 21.09.13.
//  Copyright (c) 2013 axbx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TRAuthBlockView.h"

@interface TRAuthViewController : UIViewController <TRAuthBlockViewDelegate>

@property (nonatomic, strong) IBOutlet UIScrollView *scrollView;
@property (nonatomic, retain) IBOutlet UIView *loginContainerView;
@property (nonatomic, retain) IBOutlet UIImageView *logoImageView;
@property (nonatomic, retain) IBOutlet UITextField *loginField;
@property (nonatomic, retain) IBOutlet UITextField *passwordField;

@property (nonatomic, retain) IBOutlet UIButton *loginButton;

@end
