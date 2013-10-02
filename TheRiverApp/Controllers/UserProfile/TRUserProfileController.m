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
#import "TRContactBox.h"
#import "TRTagsBox.h"
#import "TRExMenuBox.h"
#import "TRBusinessTitleBox.h"
#import "TRBusinessBox.h"
#import "TRProfileWebViewBox.h"

@interface TRUserProfileController ()
@property (nonatomic, retain) MGScrollView *scrollView;
@end

@implementation TRUserProfileController

-(id) initByUserModel:(TRUserInfoModel*)userObject
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        _userDataObject = userObject;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationController.navigationBar.clipsToBounds = YES;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(menuStateEventOccurred:)
                                                 name:MFSideMenuStateNotificationEvent
                                               object:nil];
    
    [self createRootScrollView];

    [self createBackgroundHeadBlock];
    [self createContactBox];
    [self createTagsBox];
    [self createExMenuBox];
    [self createBusinessTitleBox];
    [self createBusinessBox];
    [self createBusinessWebViewBox];
    
    [_scrollView layoutWithSpeed:0.3 completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
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
    _scrollView.backgroundColor = [UIColor whiteColor]; //[UIColor colorWithRed:0.94 green:0.94 blue:0.95 alpha:1];
    _scrollView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    _scrollView.bottomPadding = 10.0;
    [self.view addSubview:_scrollView];
}

-(void) createBackgroundHeadBlock
{
    TRHeadBox *headBox = (TRHeadBox*)[TRHeadBox initBox: self.view.bounds.size
                                      withUserData:_userDataObject];
    [_scrollView.boxes addObject: headBox];
}

-(void) createContactBox
{
    TRContactBox *contactBox = (TRContactBox*)[TRContactBox initBox: self.view.bounds.size
                                               withUserData:_userDataObject];
    [_scrollView.boxes addObject: contactBox];
}

-(void) createTagsBox
{
    TRTagsBox *tagsBox = (TRTagsBox*)[TRTagsBox initBox: self.view.bounds.size
                                      withUserData:_userDataObject byTarget:self];
    [_scrollView.boxes addObject: tagsBox];
}

-(void) createExMenuBox
{
    TRExMenuBox *menuBox = (TRExMenuBox*)[TRExMenuBox initBox: self.view.bounds.size
                                          withUserData:_userDataObject byTarget:self];
    [_scrollView.boxes addObject: menuBox];
}

-(void) createBusinessTitleBox
{
    TRBusinessTitleBox *titleBox = (TRBusinessTitleBox*)[TRBusinessTitleBox initBox: self.view.bounds.size
                                                         withUserData:_userDataObject];
    [_scrollView.boxes addObject: titleBox];
}

-(void) createBusinessBox
{
    TRBusinessBox *businessBox = (TRBusinessBox*)[TRBusinessBox initBox: self.view.bounds.size
                                                  withUserData:_userDataObject];
    [_scrollView.boxes addObject: businessBox];
}

-(void) createBusinessWebViewBox
{
    TRProfileWebViewBox *businessWebViewBox = (TRProfileWebViewBox*)[TRProfileWebViewBox initBox: self.view.bounds.size
                                                              withUserData:_userDataObject];
    [_scrollView.boxes addObject: businessWebViewBox];
}

@end
