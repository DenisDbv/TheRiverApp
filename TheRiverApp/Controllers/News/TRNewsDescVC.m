//
//  TRNewsDescVC.m
//  TheRiverApp
//
//  Created by DenisDbv on 15.11.13.
//  Copyright (c) 2013 axbx. All rights reserved.
//

#import "TRNewsDescVC.h"

#import "MFSideMenu.h"
#import "UIBarButtonItem+BarButtonItemExtended.h"

#import "WDActivityIndicator.h"

#import <MGBox2/MGBox.h>
#import <MGBox2/MGScrollView.h>
#import <MGBox2/MGTableBoxStyled.h>
#import <MGBox2/MGLineStyled.h>

#import "TRNewsLogoBox.h"
#import "TRNewsUnitTitleBox.h"
#import "TRNewsWebViewBox.h"

@interface TRNewsDescVC ()
@property (nonatomic, retain) WDActivityIndicator *activityIndicator;
@property (nonatomic, retain) MGScrollView *scrollView;
@property (nonatomic, copy) NSString *newsID;
@property (nonatomic, retain) TRNewsItem *_newsItem;
@end

@implementation TRNewsDescVC
@synthesize activityIndicator;
@synthesize _newsItem;

-(id) initByNewsItem:(TRNewsItem*)newsItem
{
    self = [super initWithNibName:@"TRNewsDescVC" bundle:[NSBundle mainBundle]];
    if (self)
    {
        _newsID = newsItem.objectId;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self addSwipeGestureRecognizer];
    
    UIBarButtonItem *onCancelButton = [UIBarButtonItem barItemWithImage:[UIImage imageNamed:@"toolbar-back-button@2x.png"] target:self action:@selector(onBack)];
    [onCancelButton setBackgroundImage:[UIImage new] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [self.navigationItem setLeftBarButtonItem:onCancelButton animated:YES];
    
    [self refreshNewsByID:_newsID];
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

-(void) refreshNewsByID:(NSString*)newsID
{
    if(activityIndicator == nil)    {
        activityIndicator = [[WDActivityIndicator alloc] initWithFrame:CGRectMake(self.view.bounds.size.width/2, (self.view.bounds.size.height-100)/2, 0, 0)];
        [activityIndicator setIndicatorStyle:WDActivityIndicatorStyleGradient];
        [self.view addSubview:activityIndicator];
        [activityIndicator startAnimating];
    }
    
    [[TRNewsManager client] downloadNewsDescByID:newsID successOperation:^(LRRestyResponse *response, TRNewsItem *newsItem) {
        [self endRefreshNews:newsItem];
    } andFailedOperation:^(LRRestyResponse *response) {
        [self endRefreshNews:nil];
    }];
}

-(void) endRefreshNews:(TRNewsItem*)newsItem
{
    [activityIndicator stopAnimating];
    [activityIndicator removeFromSuperview];
    activityIndicator = nil;
    
    _newsItem = newsItem;
    
    [self createRootScrollView];
    [self showNewsLogo];
    [self showNewsTitle];
    [self showNewsWebView];
    [_scrollView layoutWithSpeed:0.3 completion:nil];
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

-(void) showNewsLogo
{
    TRNewsLogoBox *logoBox = (TRNewsLogoBox*)[TRNewsLogoBox initBox: CGSizeMake(300, 0)
                                                       withNewsData: _newsItem];
    [_scrollView.boxes addObject: logoBox];
}

-(void) showNewsTitle
{
    TRNewsUnitTitleBox *titleBox = (TRNewsUnitTitleBox*)[TRNewsUnitTitleBox initBox: CGSizeMake(300, 0)
                                                           withNewsData: _newsItem];
    [_scrollView.boxes addObject: titleBox];
}

-(void) showNewsWebView
{
    TRNewsWebViewBox *webViewBox = (TRNewsWebViewBox*)[TRNewsWebViewBox initBox: CGSizeMake(300, 0)
                                                                   withNewsData: _newsItem];
    [_scrollView.boxes addObject: webViewBox];
}

@end
