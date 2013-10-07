//
//  TRRootController.m
//  TheRiverApp
//
//  Created by DenisDbv on 02.09.13.
//  Copyright (c) 2013 axbx. All rights reserved.
//

#import "TRRootController.h"
#import "MFSideMenu.h"

#define MENU_BAR_FULL_WIDTH  320.0
#define MENU_BAR_SHORT_WIDTH  270.0

@interface TRRootController ()

@end

@implementation TRRootController

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
    
    self.navigationController.navigationBar.clipsToBounds = YES;
    
    self.navigationController.navigationBarHidden = YES;
    
    [self.navigationController.navigationBar setTintColor:[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.9]];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    
    //[self toShortWidth];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void) changeControllerWidth:(NSInteger)width
{
    [self.menuContainerViewController setMenuWidth: width];
}

-(void) toFullWidth
{
    [self.menuContainerViewController setMenuWidth: MENU_BAR_FULL_WIDTH];
}

-(void) toShortWidth
{
    [self.menuContainerViewController setMenuWidth: MENU_BAR_SHORT_WIDTH];
}

@end
