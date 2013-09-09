//
//  TRCenterRootController.m
//  TheRiverApp
//
//  Created by DenisDbv on 05.09.13.
//  Copyright (c) 2013 axbx. All rights reserved.
//

#import "TRCenterRootController.h"
#import "MFSideMenu.h"

@interface TRCenterRootController ()

@end

@implementation TRCenterRootController

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
	
    [self setupMenuBarButtonItems];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark - UIBarButtonItems

- (void)setupMenuBarButtonItems
{
    self.navigationItem.rightBarButtonItem = [self rightMenuBarButtonItem];
    self.navigationItem.leftBarButtonItem = [self leftMenuBarButtonItem];
}

- (UIBarButtonItem *)leftMenuBarButtonItem {
    return [[UIBarButtonItem alloc]
            initWithImage:[UIImage imageNamed:@"menu-icon.png"] style:UIBarButtonItemStyleBordered
            target:self
            action:@selector(leftSideMenuButtonPressed:)];
}

- (UIBarButtonItem *)rightMenuBarButtonItem {
    return [[UIBarButtonItem alloc]
            initWithImage:[UIImage imageNamed:@"menu-icon.png"] style:UIBarButtonItemStyleBordered
            target:self
            action:@selector(rightSideMenuButtonPressed:)];
}

- (void)leftSideMenuButtonPressed:(id)sender {
    [self.menuContainerViewController toggleLeftSideMenuCompletion:^{
        //[self setupMenuBarButtonItems];
    }];
}

- (void)rightSideMenuButtonPressed:(id)sender {
    [self.menuContainerViewController toggleRightSideMenuCompletion:^{
        //[self setupMenuBarButtonItems];
    }];
}

@end
