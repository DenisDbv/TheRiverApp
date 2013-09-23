//
//  TRAuthViewController.m
//  TheRiverApp
//
//  Created by DenisDbv on 21.09.13.
//  Copyright (c) 2013 axbx. All rights reserved.
//

#import "TRAuthViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface TRAuthViewController ()

@end

@implementation TRAuthViewController

@synthesize loginField, passwordField, loginButton;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        //
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    loginField.text = @"denisdbv@gmail.com";
    passwordField.text = @"12345678";
    
    [loginField becomeFirstResponder];
    
    UIImage *buttonImage = [[UIImage imageNamed:@"blueButton.png"]
                            resizableImageWithCapInsets:UIEdgeInsetsMake(18, 18, 18, 18)];
    UIImage *buttonImageHighlight = [[UIImage imageNamed:@"blueButtonHighlight.png"]
                                     resizableImageWithCapInsets:UIEdgeInsetsMake(18, 18, 18, 18)];
    [loginButton setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [loginButton setBackgroundImage:buttonImageHighlight forState:UIControlStateHighlighted];
    
    loginField.layer.borderWidth = 1.0f;
    loginField.layer.borderColor = [[UIColor blackColor] CGColor];
    loginField.layer.cornerRadius = 4;
    loginField.clipsToBounds      = YES;
    
    passwordField.layer.borderWidth = 1.0f;
    passwordField.layer.borderColor = [[UIColor blackColor] CGColor];
    passwordField.layer.cornerRadius = 4;
    passwordField.clipsToBounds      = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(IBAction)onLognClick:(id)sender
{
    [[TRAuthManager client] authByLogin:loginField.text
                            andPassword:passwordField.text
                   withSuccessOperation:^(LRRestyResponse *response) {
                       NSLog(@"User token: %@", [TRAuthManager client].iamData.token);
                       
                       if([[TRAuthManager client] isAuth] == YES)   {
                           [AppDelegateInstance() presentTheRiverControllers];
                       }
                   } andFailedOperation:nil];
}

@end
