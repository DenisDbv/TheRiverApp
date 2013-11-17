//
//  TRAuthViewController.m
//  TheRiverApp
//
//  Created by DenisDbv on 21.09.13.
//  Copyright (c) 2013 axbx. All rights reserved.
//

#import "TRAuthViewController.h"
#import <QuartzCore/QuartzCore.h>
#import <NVUIGradientButton/NVUIGradientButton.h>
#import "UIView+GestureBlocks.h"

@interface TRAuthViewController ()
@property (nonatomic, retain) UIActivityIndicatorView *authIndicator;

@property (nonatomic, retain) TRAuthBlockView *authBlockView;
@end

@implementation TRAuthViewController
{
    NVUIGradientButton *addButton;
}

@synthesize scrollView, loginContainerView;
@synthesize loginField, passwordField, loginButton;
@synthesize logoImageView;
@synthesize authIndicator;

@synthesize authBlockView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        //
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    authBlockView = [[TRAuthBlockView alloc] init];
    authBlockView.delegate = self;
    [self.scrollView addSubview:authBlockView];
    
    [scrollView initialiseSwipeUpHandler:^(UIGestureRecognizer *sender) {
        [self resignFromAllFields];
    }];
    
    [scrollView initialiseSwipeDownHandler:^(UIGestureRecognizer *sender) {
        [self resignFromAllFields];
    }];
    
    [loginContainerView initialiseSwipeUpHandler:^(UIGestureRecognizer *sender) {
        [self resignFromAllFields];
    }];
    
    [loginContainerView initialiseSwipeDownHandler:^(UIGestureRecognizer *sender) {
        [self resignFromAllFields];
    }];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShown:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHidden:) name:UIKeyboardWillHideNotification object:nil];
}

-(void) viewWillDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:UIKeyboardDidShowNotification];
    [[NSNotificationCenter defaultCenter] removeObserver:UIKeyboardWillHideNotification];
}

-(void) viewWillAppear:(BOOL)animated
{
    scrollView.frame = CGRectMake(0, 0, self.view.bounds.size.width, ([UIScreen mainScreen].bounds.size.height));
    [scrollView setContentSize:CGSizeMake(1, 1)];
    
    CGRect rectLoginContainer = authBlockView.frame;
    rectLoginContainer.origin.y = [UIScreen mainScreen].bounds.size.height - rectLoginContainer.size.height - 23.0f - ((IS_IPHONE5)?30:0);
    //(([UIScreen mainScreen].bounds.size.height) - rectLoginContainer.size.height)/2 + ((IS_IPHONE5)?50:110);
    authBlockView.frame = rectLoginContainer;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self resignFromAllFields];
}

-(void) resignFromAllFields
{
    [authBlockView resignFromAllFields];
}

- (void) keyboardShown:(NSNotification *)note{
    
    CGRect keyboardFrame;
    UIViewAnimationCurve *keyboardCurve;
    double keyboardDuration;
    
    [[[note userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] getValue:&keyboardFrame];
    [[[note userInfo] objectForKey:UIKeyboardAnimationCurveUserInfoKey] getValue:&keyboardCurve];
    [[[note userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] getValue:&keyboardDuration];
    
    NSInteger yOffset = abs((keyboardFrame.origin.y - authBlockView.frame.size.height)/2 - authBlockView.frame.origin.y);// + ((IS_IPHONE5)?0:-15);
    [scrollView setContentOffset:CGPointMake(0, yOffset) animated:YES];
    
    [scrollView setScrollEnabled:NO];
}

- (void) keyboardHidden:(NSNotification *)note{
    
    CGRect keyboardFrame;
    UIViewAnimationCurve *keyboardCurve;
    double keyboardDuration;
    
    [[[note userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] getValue:&keyboardFrame];
    [[[note userInfo] objectForKey:UIKeyboardAnimationCurveUserInfoKey] getValue:&keyboardCurve];
    [[[note userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] getValue:&keyboardDuration];
    
    [scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    
    [scrollView setScrollEnabled:YES];
}

-(void) onClickLoginWithEmail:(NSString*)email andPassword:(NSString*)password
{
    if(email.length == 0 || password.length == 0)   {
        [authBlockView shakeLoginView];
        return;
    }
    
    [authBlockView startSpinner];
    
    [[TRAuthManager client] authByLogin:email
                            andPassword:password
                   withSuccessOperation:^(LRRestyResponse *response) {
                       NSLog(@"User token: %@", [TRAuthManager client].iamData.token);
                       
                       if([[TRAuthManager client] isAuth] == YES)   {
                           [AppDelegateInstance() registerUserForFeedBack];
                           
                           [AppDelegateInstance() presentTheRiverControllers];
                           
                           [AppDelegateInstance() checkBusinessURL];
                       } else   {
                           [authBlockView stopSpinner];
                           
                           [authBlockView shakeLoginView];
                       }
                   } andFailedOperation:^(LRRestyResponse *response) {
                       [authBlockView shakeLoginView];
                   }];
}

@end
