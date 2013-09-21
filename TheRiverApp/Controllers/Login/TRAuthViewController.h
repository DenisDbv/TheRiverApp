//
//  TRAuthViewController.h
//  TheRiverApp
//
//  Created by DenisDbv on 21.09.13.
//  Copyright (c) 2013 axbx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TRAuthViewController : UIViewController

@property (nonatomic, retain) IBOutlet UITextField *loginField;
@property (nonatomic, retain) IBOutlet UITextField *passwordField;

-(IBAction)onLognClick:(id)sender;

@end
