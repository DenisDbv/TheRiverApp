//
//  TRAuthViewController.m
//  TheRiverApp
//
//  Created by DenisDbv on 21.09.13.
//  Copyright (c) 2013 axbx. All rights reserved.
//

#import "TRAuthViewController.h"

@interface TRAuthViewController ()

@end

@implementation TRAuthViewController

@synthesize loginField, passwordField;

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
