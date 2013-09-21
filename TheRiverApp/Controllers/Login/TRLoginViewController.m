//
//  TRLoginViewController.m
//  TheRiverApp
//
//  Created by DenisDbv on 21.09.13.
//  Copyright (c) 2013 axbx. All rights reserved.
//

#import "TRLoginViewController.h"
#import "TRAuthViewController.h"

@interface TRLoginViewController ()

@end

@implementation TRLoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onAuthClick:(id)sender
{
    TRAuthViewController *authViewController = [[TRAuthViewController alloc] init];
    [self presentViewController:authViewController animated:YES completion:nil];
}

- (IBAction)onRegistrationClick:(id)sender
{
    //
}

@end
