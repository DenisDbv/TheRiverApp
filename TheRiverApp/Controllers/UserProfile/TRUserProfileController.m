//
//  TRUserProfileController.m
//  TheRiverApp
//
//  Created by DenisDbv on 03.09.13.
//  Copyright (c) 2013 axbx. All rights reserved.
//

#import "TRUserProfileController.h"
#import <MGBox2/MGBox.h>
#import <MGBox2/MGScrollView.h>
#import <MGBox2/MGTableBoxStyled.h>
#import <MGBox2/MGLineStyled.h>
#import "MFSideMenu.h"

#import "TRHeadBox.h"
#import "TRSecondHeadBox.h"

@interface TRUserProfileController ()
@property (nonatomic, retain) MGScrollView *scrollView;
@end

@implementation TRUserProfileController

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
    
    self.menuContainerViewController.panMode = MFSideMenuPanModeCenterViewController;
    
    [self createRootScrollView];
    
    [self createBackgroundHeadBlock];
    [self createSecondHeadBlock];
    
    [_scrollView layoutWithSpeed:0.3 completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark Create data views for controller

-(void) createRootScrollView
{
    _scrollView = [[MGScrollView alloc] initWithFrame:self.view.bounds];
    _scrollView.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.95 alpha:1];
    _scrollView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:_scrollView];
}

-(void) createBackgroundHeadBlock
{
    TRHeadBox *headBox = [TRHeadBox initBox:self.view.bounds.size];
    [_scrollView.boxes addObject: headBox];
}

-(void) createSecondHeadBlock
{
    TRSecondHeadBox *headBox = [TRSecondHeadBox initBox:self.view.bounds.size];
    [_scrollView.boxes addObject: headBox];
}

@end
