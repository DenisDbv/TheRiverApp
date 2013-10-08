//
//  TRNavigationController.m
//  TheRiverApp
//
//  Created by DenisDbv on 08.10.13.
//  Copyright (c) 2013 axbx. All rights reserved.
//

#import "TRNavigationController.h"
#import "AMPNavigationBar.h"

@interface TRNavigationController ()

@end

@implementation TRNavigationController

- (id)initWithRootViewController:(UIViewController *)rootViewController
{
    self = [super initWithNavigationBarClass:[AMPNavigationBar class] toolbarClass:[UIToolbar class]];
    if (self) {
        self.viewControllers = @[ rootViewController ];
        NSLog(@"!!!!");
    }
    return self;
}

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
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
