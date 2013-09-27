//
//  TRSearchPartnersListVC.m
//  TheRiverApp
//
//  Created by DenisDbv on 27.09.13.
//  Copyright (c) 2013 axbx. All rights reserved.
//

#import "TRSearchPartnersListVC.h"
#import "UIBarButtonItem+BarButtonItemExtended.h"

@interface TRSearchPartnersListVC ()

@end

@implementation TRSearchPartnersListVC

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
    
    UIBarButtonItem *onCancelButton = [UIBarButtonItem barItemWithImage:[UIImage imageNamed:@"toolbar-back-button@2x.png"] target:self action:@selector(onBack)];
    [onCancelButton setBackgroundImage:[UIImage new] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [self.navigationItem setLeftBarButtonItem:onCancelButton animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) onBack
{
    [self.navigationController popViewControllerAnimated:YES];
}


@end
