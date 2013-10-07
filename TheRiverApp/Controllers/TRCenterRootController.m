//
//  TRCenterRootController.m
//  TheRiverApp
//
//  Created by DenisDbv on 05.09.13.
//  Copyright (c) 2013 axbx. All rights reserved.
//

#import "TRCenterRootController.h"
#import "MFSideMenu.h"

#import "TRMindBaseListVC.h"
#import "TRSearchPartnersListVC.h"

#import "UIView+GestureBlocks.h"
#import "UIBarButtonItem+BarButtonItemExtended.h"

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
    
    [self.navigationController.navigationBar setTintColor:[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.9]];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
	
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
    
    if( self.navigationController.viewControllers.count > 1)    {
        UIBarButtonItem *onCancelButton = [UIBarButtonItem barItemWithImage:[UIImage imageNamed:@"toolbar-back-button@2x.png"] target:self action:@selector(onBack)];
        [onCancelButton setBackgroundImage:[UIImage new] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
        [self.navigationItem setLeftBarButtonItem:onCancelButton animated:YES];
    } else  {
        UIButton *settingsView = [[UIButton alloc] initWithFrame:CGRectMake(5, roundf(((15+13)-13)/2), 18, 13)];
        settingsView.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 15+settingsView.frame.size.width, settingsView.frame.size.height+15)];
        [leftView initialiseTapHandler:^(UIGestureRecognizer *sender) {
            [self leftSideMenuButtonPressed:nil];
        } forTaps:1];
        leftView.backgroundColor = [UIColor clearColor];
        [leftView addSubview:settingsView];
        [settingsView addTarget:self action:@selector(leftSideMenuButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [settingsView setBackgroundImage:[UIImage imageNamed:@"toolbar-menu-icon@2x.png"] forState:UIControlStateNormal];
        UIBarButtonItem *settingsButton = [[UIBarButtonItem alloc] initWithCustomView:leftView];
        [self.navigationItem setLeftBarButtonItem:settingsButton];
    }
    
    UIButton *settingsView2 = [[UIButton alloc] initWithFrame:CGRectMake(5, roundf(((20+15)-20)/2), 23, 20)];
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10+settingsView2.frame.size.width, settingsView2.frame.size.height+15)];
    [rightView initialiseTapHandler:^(UIGestureRecognizer *sender) {
        [self rightSideMenuButtonPressed:nil];
    } forTaps:1];
    rightView.backgroundColor = [UIColor clearColor];
    [rightView addSubview:settingsView2];
    [settingsView2 addTarget:self action:@selector(rightSideMenuButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [settingsView2 setBackgroundImage:[UIImage imageNamed:@"toolbar-contacts-icon@2x.png"] forState:UIControlStateNormal];
    UIBarButtonItem *settingsButton2 = [[UIBarButtonItem alloc] initWithCustomView:rightView];
    [self.navigationItem setRightBarButtonItem:settingsButton2];
    
    
    
    UIImage *knowImage = [UIImage imageNamed:@"toolbar-knowledge-base-icon@2x.png"];
    UIImage *messageImage = [UIImage imageNamed:@"toolbar-messages-icon@2x.png"];
    UIImage *searchImage = [UIImage imageNamed:@"toolbar-search-icon@2x.png"];
    NSInteger width = knowImage.size.width/2+messageImage.size.width/2+searchImage.size.width/2+40;
    NSInteger height = MAX(knowImage.size.height/2, messageImage.size.height/2);
    height = MAX(height, searchImage.size.height/2);
    
    NSString *text = @"Поиск";
    CGSize size = [text sizeWithFont:[UIFont fontWithName:@"HelveticaNeue" size:14] constrainedToSize:CGSizeMake(100, 100)];
    width = searchImage.size.width + size.width - 5;
    
    UIView *buttonView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    [buttonView initialiseTapHandler:^(UIGestureRecognizer *sender) {
        [self onSearchClick];
    } forTaps:1];
    //buttonView.backgroundColor = [UIColor redColor];
    /*UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button1 addTarget:self action:@selector(onKnowledgeBaseClick) forControlEvents:UIControlEventTouchUpInside];
    [button1 setImage:knowImage forState:UIControlStateNormal];
    button1.frame = CGRectMake(0, 0, 26, 16);
    
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button2 addTarget:self action:@selector(onMessageClick) forControlEvents:UIControlEventTouchUpInside];
    [button2 setImage:messageImage forState:UIControlStateNormal];
    button2.frame = CGRectMake(46, 0, 18, 14);*/
    
    UIButton *button3 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button3 addTarget:self action:@selector(onSearchClick) forControlEvents:UIControlEventTouchUpInside];
    [button3 setImage:searchImage forState:UIControlStateNormal];
    button3.frame = CGRectMake(0, 0, 18, 18);
    
    UILabel *labelText = [[UILabel alloc] initWithFrame:CGRectMake(23, 0, 0, 0)];
    labelText.userInteractionEnabled = YES;
    labelText.backgroundColor = [UIColor clearColor];
    labelText.textColor = [UIColor lightGrayColor];
    labelText.font = [UIFont fontWithName:@"HelveticaNeue" size:14];
    labelText.text = @"Поиск";
    [labelText sizeToFit];
    
    [buttonView addSubview:button3];
    [buttonView addSubview:labelText];
    /*UIButton *button3 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button3 addTarget:self action:@selector(onSearchClick) forControlEvents:UIControlEventTouchUpInside];
    [button3 setImage:searchImage forState:UIControlStateNormal];
    button3.frame = CGRectMake(84, 0, 18, 18);*/
    
    /*[buttonView addSubview:button1];
    [buttonView addSubview:button2];*/
    //[buttonView addSubview:button3];
    //buttonView.backgroundColor = [UIColor redColor];
    
    self.navigationItem.titleView = buttonView;
}

-(void) onBack
{
    [self.navigationController popViewControllerAnimated:YES];
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

-(void) onKnowledgeBaseClick
{
    TRMindBaseListVC *mindBaseList = [[TRMindBaseListVC alloc] init];
    [AppDelegateInstance() changeCenterViewController:mindBaseList];
}

-(void) onMessageClick
{
    //
}

-(void) onSearchClick
{
    TRSearchPartnersListVC *searchPartnersVC = [[TRSearchPartnersListVC alloc] init];
    [AppDelegateInstance() pushCenterViewController:searchPartnersVC];
}

@end
