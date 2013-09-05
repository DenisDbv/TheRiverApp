//
//  TRScrollViewController.m
//  TheRiverApp
//
//  Created by DenisDbv on 05.09.13.
//  Copyright (c) 2013 axbx. All rights reserved.
//

#import "TRScrollViewController.h"
#import "MFSideMenu.h"

@interface TRScrollViewController ()
@property (nonatomic, retain) UIScrollView *scrollView;
@end

@implementation TRScrollViewController

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
    
    _scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:_scrollView];
    
    for(int i=0; i< 10; i++)
    {
        [self addView];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) addView
{
    static int inc = 10;
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(inc, 10, 100, 100)];
    view.backgroundColor = [UIColor redColor];
    
    [_scrollView addSubview:view];
    _scrollView.contentSize = CGSizeMake(view.frame.origin.x+view.frame.size.width, _scrollView.bounds.size.height );
    
    inc += 110;
}

@end
