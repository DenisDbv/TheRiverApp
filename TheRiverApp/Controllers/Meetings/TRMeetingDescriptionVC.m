//
//  TRMeetingDescriptionVC.m
//  TheRiverApp
//
//  Created by DenisDbv on 14.09.13.
//  Copyright (c) 2013 axbx. All rights reserved.
//

#import "TRMeetingDescriptionVC.h"

#import "MFSideMenu.h"
#import "UIBarButtonItem+BarButtonItemExtended.h"

#import <MGBox2/MGBox.h>
#import <MGBox2/MGScrollView.h>
#import <MGBox2/MGTableBoxStyled.h>
#import <MGBox2/MGLineStyled.h>

#import "TRMeetLogoBox.h"
#import "TRMeetTitleBox.h"
#import "TRMeetWebViewBox.h"

@interface TRMeetingDescriptionVC ()
@property (nonatomic, retain) MGScrollView *scrollView;
@property (nonatomic, retain) TREventModel *meetDataObject;
@end

@implementation TRMeetingDescriptionVC

-(id) initByMindModel:(TREventModel*)meetObject
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        _meetDataObject = meetObject;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(menuStateEventOccurred:)
                                                 name:MFSideMenuStateNotificationEvent
                                               object:nil];
    
    [self addSwipeGestureRecognizer];
    
    UIBarButtonItem *onCancelButton = [UIBarButtonItem barItemWithImage:[UIImage imageNamed:@"toolbar-back-button@2x.png"] target:self action:@selector(onBack)];
    [onCancelButton setBackgroundImage:[UIImage new] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [self.navigationItem setLeftBarButtonItem:onCancelButton animated:YES];
    
    [self createRootScrollView];
    
    [self showMeetLogo];
    [self showMeetTitle];
    [self showMeetWebView];
    
    [_scrollView layoutWithSpeed:0.3 completion:nil];
}

-(void) onBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void) viewWillAppear:(BOOL)animated
{
    self.menuContainerViewController.panMode = MFSideMenuPanModeNone;
}

-(void) viewWillDisappear:(BOOL)animated
{
    self.menuContainerViewController.panMode = MFSideMenuPanModeDefault;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)menuStateEventOccurred:(NSNotification *)notification {
    MFSideMenuStateEvent event = [[[notification userInfo] objectForKey:@"eventType"] intValue];
    
    if(event == MFSideMenuStateEventMenuDragBegin)
    {
        _scrollView.scrollEnabled = NO;
    }
    else if(event == MFSideMenuStateEventMenuDragEnd)
    {
        _scrollView.scrollEnabled = YES;
    }
}

#pragma mark - Swipe gesture

- (void)addSwipeGestureRecognizer
{
    UISwipeGestureRecognizer *swipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeRecognized:)];
    [self.view addGestureRecognizer:swipeGestureRecognizer];
}

- (void)swipeRecognized:(UISwipeGestureRecognizer *)gestureRecognizer
{
    if (gestureRecognizer.state == UIGestureRecognizerStateEnded &&
        gestureRecognizer.direction & UISwipeGestureRecognizerDirectionRight) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark Create data views for controller

-(void) createRootScrollView
{
    _scrollView = [[MGScrollView alloc] initWithFrame:self.view.bounds];
    _scrollView.backgroundColor = [UIColor whiteColor];
    _scrollView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    _scrollView.padding = UIEdgeInsetsMake(10.0, 0.0, 10.0, 0.0);
    [self.view addSubview:_scrollView];
}

-(void) showMeetLogo
{
    TRMeetLogoBox *logoBox = (TRMeetLogoBox*)[TRMeetLogoBox initBox: CGSizeMake(300, 0)
                                                       withMeetData:_meetDataObject];
    [_scrollView.boxes addObject: logoBox];
}

-(void) showMeetTitle
{
    TRMeetTitleBox *titleBox = (TRMeetTitleBox*)[TRMeetTitleBox initBox: CGSizeMake(300, 0)
                                                           withMeetData:_meetDataObject];
    [_scrollView.boxes addObject: titleBox];
}

-(void) showMeetWebView
{
    TRMeetWebViewBox *webViewBox = (TRMeetWebViewBox*)[TRMeetWebViewBox initBox: CGSizeMake(320, 0)
                                                                   withMeetData:_meetDataObject];
    [_scrollView.boxes addObject: webViewBox];
}


@end
