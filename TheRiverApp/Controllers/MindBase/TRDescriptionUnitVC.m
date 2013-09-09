//
//  TRDescriptionUnitVC.m
//  TheRiverApp
//
//  Created by DenisDbv on 08.09.13.
//  Copyright (c) 2013 axbx. All rights reserved.
//

#import "TRDescriptionUnitVC.h"
#import "MFSideMenu.h"

#import <MGBox2/MGBox.h>
#import <MGBox2/MGScrollView.h>
#import <MGBox2/MGTableBoxStyled.h>
#import <MGBox2/MGLineStyled.h>

#import "TRMindLogoBox.h"
#import "TRMindTitleBox.h"
#import "TRMindWebViewBox.h"

@interface TRDescriptionUnitVC ()
@property (nonatomic, retain) MGScrollView *scrollView;
@property (nonatomic, retain) TRMindModel *mindDataObject;
@end

@implementation TRDescriptionUnitVC

-(id) initByMindModel:(TRMindModel*)mindObject
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        _mindDataObject = mindObject;
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
    
    [self createRootScrollView];
    
    [self showMindLogo];
    [self showMindTitle];
    [self showMindWebView];
    
    [_scrollView layoutWithSpeed:0.3 completion:nil];
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

#pragma mark Create data views for controller

-(void) createRootScrollView
{
    _scrollView = [[MGScrollView alloc] initWithFrame:self.view.bounds];
    _scrollView.backgroundColor = [UIColor whiteColor];
    _scrollView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    _scrollView.padding = UIEdgeInsetsMake(10.0, 0.0, 10.0, 0.0);
    [self.view addSubview:_scrollView];
}

-(void) showMindLogo
{
    TRMindLogoBox *logoBox = (TRMindLogoBox*)[TRMindLogoBox initBox: CGSizeMake(300, 0)
                                           withMindData:_mindDataObject];
    [_scrollView.boxes addObject: logoBox];
}

-(void) showMindTitle
{
    TRMindTitleBox *titleBox = (TRMindTitleBox*)[TRMindTitleBox initBox: CGSizeMake(300, 0)
                                                       withMindData:_mindDataObject];
    [_scrollView.boxes addObject: titleBox];
}

-(void) showMindWebView
{
    TRMindWebViewBox *webViewBox = (TRMindWebViewBox*)[TRMindWebViewBox initBox: CGSizeMake(320, 0)
                                                           withMindData:_mindDataObject];
    [_scrollView.boxes addObject: webViewBox];
}

@end
