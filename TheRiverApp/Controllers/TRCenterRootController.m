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
    //self.navigationItem.rightBarButtonItem = [self rightMenuBarButtonItem];
    //self.navigationItem.leftBarButtonItem = [self leftMenuBarButtonItem];
    
    UIButton *settingsView = [[UIButton alloc] initWithFrame:CGRectMake(5, 0, 18, 13)];
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10+settingsView.frame.size.width, settingsView.frame.size.height)];
    leftView.backgroundColor = [UIColor clearColor];
    [leftView addSubview:settingsView];
    [settingsView addTarget:self action:@selector(leftSideMenuButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [settingsView setBackgroundImage:[UIImage imageNamed:@"toolbar-menu-icon@2x.png"] forState:UIControlStateNormal];
    UIBarButtonItem *settingsButton = [[UIBarButtonItem alloc] initWithCustomView:leftView];
    [self.navigationItem setLeftBarButtonItem:settingsButton];
    
    UIButton *settingsView2 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 23, 20)];
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5+settingsView2.frame.size.width, settingsView2.frame.size.height)];
    rightView.backgroundColor = [UIColor clearColor];
    [rightView addSubview:settingsView2];
    [settingsView2 addTarget:self action:@selector(rightSideMenuButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [settingsView2 setBackgroundImage:[UIImage imageNamed:@"toolbar-contacts-icon@2x.png"] forState:UIControlStateNormal];
    UIBarButtonItem *settingsButton2 = [[UIBarButtonItem alloc] initWithCustomView:rightView];
    [self.navigationItem setRightBarButtonItem:settingsButton2];
}

- (UIBarButtonItem *)leftMenuBarButtonItem {
    return [[UIBarButtonItem alloc]
            initWithImage:[UIImage imageNamed:@"toolbar-menu-icon.png"] style:UIBarButtonItemStyleBordered
            target:self
            action:@selector(leftSideMenuButtonPressed:)];
}

- (UIBarButtonItem *)rightMenuBarButtonItem {
    return [[UIBarButtonItem alloc]
            initWithImage:[UIImage imageNamed:@"toolbar-contacts-icon.png"] style:UIBarButtonItemStyleBordered
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
