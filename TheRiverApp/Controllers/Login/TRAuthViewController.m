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
@end

@implementation TRAuthViewController
{
    NVUIGradientButton *addButton;
}

@synthesize scrollView, loginContainerView;
@synthesize loginField, passwordField, loginButton;
@synthesize logoImageView;
@synthesize authIndicator;

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
    
    //NSLog(@"%@", NSStringFromCGSize([UIScreen mainScreen].bounds.size)); //NSStringFromCGSize(self.view.bounds.size));
    
    //loginField.text = @"denisdbv@gmail.com";
    //passwordField.text = @"12345678";
    
    //[loginField becomeFirstResponder];
    
    UIImage *buttonImage = [[UIImage imageNamed:@"blueButton.png"]
                            resizableImageWithCapInsets:UIEdgeInsetsMake(18, 18, 18, 18)];
    UIImage *buttonImageHighlight = [[UIImage imageNamed:@"blueButtonHighlight.png"]
                                     resizableImageWithCapInsets:UIEdgeInsetsMake(18, 18, 18, 18)];
    [loginButton setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [loginButton setBackgroundImage:buttonImageHighlight forState:UIControlStateHighlighted];
    
    loginField.layer.borderWidth = 1.0f;
    loginField.layer.borderColor = [[UIColor blackColor] CGColor];
    loginField.layer.cornerRadius = 4;
    loginField.clipsToBounds      = YES;
    
    passwordField.layer.borderWidth = 1.0f;
    passwordField.layer.borderColor = [[UIColor blackColor] CGColor];
    passwordField.layer.cornerRadius = 4;
    passwordField.clipsToBounds      = YES;
    
    /*[scrollView initialiseTapHandler:^(UIGestureRecognizer *sender) {
        [self resignFromAllFields];
    } forTaps:1];*/
    
    [scrollView initialiseSwipeUpHandler:^(UIGestureRecognizer *sender) {
        [self resignFromAllFields];
    }];
    
    [scrollView initialiseSwipeDownHandler:^(UIGestureRecognizer *sender) {
        [self resignFromAllFields];
    }];
    
    /*[loginContainerView initialiseTapHandler:^(UIGestureRecognizer *sender) {
        [self resignFromAllFields];
    } forTaps:1];*/
    
    [loginContainerView initialiseSwipeUpHandler:^(UIGestureRecognizer *sender) {
        [self resignFromAllFields];
    }];
    
    [loginContainerView initialiseSwipeDownHandler:^(UIGestureRecognizer *sender) {
        [self resignFromAllFields];
    }];
    
    addButton = [[NVUIGradientButton alloc] initWithFrame:CGRectMake(15, 119, 250, 44) style:NVUIGradientButtonStyleDefault];
    [addButton addTarget:self action:@selector(onLognClick:) forControlEvents:UIControlEventTouchUpInside];
    addButton.tintColor = addButton.highlightedTintColor = [UIColor colorWithRed:77.0/255.0 green:112.0/255.0 blue:255.0/255.0 alpha:1.0];
    addButton.borderColor = [UIColor clearColor];
    addButton.highlightedBorderColor = [UIColor blueColor];
    [addButton setCornerRadius:4.0f];
    [addButton setGradientEnabled:NO];
    addButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:16];
    addButton.textColor = addButton.highlightedTextColor = [UIColor whiteColor];
    addButton.textShadowColor = [UIColor clearColor];
    addButton.highlightedTextShadowColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.2];
    addButton.text = @"Войти";
    [loginContainerView addSubview:addButton];
    
    authIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(70, 12, 20, 20)];
    [authIndicator setColor:[UIColor whiteColor]];
    [addButton addSubview:authIndicator];
    
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
    //NSLog(@"%@", NSStringFromCGRect(scrollView.frame));
    [scrollView setContentSize:CGSizeMake(1, 1)];
    
    CGRect rectLoginContainer = loginContainerView.frame;
    rectLoginContainer.origin.y = (([UIScreen mainScreen].bounds.size.height) - rectLoginContainer.size.height)/2 + ((IS_IPHONE5)?50:110);
    loginContainerView.frame = rectLoginContainer;
    
    logoImageView.image = [UIImage imageNamed:@"logo@2x.png"];
    logoImageView.frame = CGRectMake((self.view.bounds.size.width-logoImageView.frame.size.width)/2,
                                     (loginContainerView.frame.origin.y - logoImageView.frame.size.height)/2,
                                    logoImageView.frame.size.width,
                                    logoImageView.frame.size.height);
    
    //NSLog(@"%@", NSStringFromCGRect(rectLoginContainer));
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
    [loginField resignFirstResponder];
    [passwordField resignFirstResponder];
}

- (void) keyboardShown:(NSNotification *)note{
    
    CGRect keyboardFrame;
    UIViewAnimationCurve *keyboardCurve;
    double keyboardDuration;
    
    [[[note userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] getValue:&keyboardFrame];
    [[[note userInfo] objectForKey:UIKeyboardAnimationCurveUserInfoKey] getValue:&keyboardCurve];
    [[[note userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] getValue:&keyboardDuration];
    
    NSInteger yOffset = abs((keyboardFrame.origin.y - loginContainerView.frame.size.height)/2 - loginContainerView.frame.origin.y) + ((IS_IPHONE5)?0:-15);
    [scrollView setContentOffset:CGPointMake(0, yOffset) animated:YES];
    
    [UIView animateWithDuration:keyboardDuration animations:^{
        logoImageView.alpha = 0;
    }];
    
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
    
    [UIView animateWithDuration:keyboardDuration animations:^{
        logoImageView.alpha = 1;
    }];
    
    [scrollView setScrollEnabled:YES];
}

-(void) onLognClick:(id)sender
{
    if(loginField.text.length == 0)   {
        [self shakeIt:loginField withDelta:-2.0];
        return;
    }
    if(passwordField.text.length == 0)   {
        [self shakeIt:passwordField withDelta:3.0];
        return;
    }
    
    [authIndicator startAnimating];
    [addButton setEnabled:NO];
    
    [[TRAuthManager client] authByLogin:loginField.text
                            andPassword:passwordField.text
                   withSuccessOperation:^(LRRestyResponse *response) {
                       NSLog(@"User token: %@", [TRAuthManager client].iamData.token);
                    
                       if([[TRAuthManager client] isAuth] == YES)   {
                           [AppDelegateInstance() presentTheRiverControllers];
                       } else   {
                           [authIndicator stopAnimating];
                           [addButton setEnabled:YES];
                           
                           [self shakeIt:logoImageView withDelta:-1.0];
                           [self shakeIt:loginField withDelta:-2.0];
                           [self shakeIt:passwordField withDelta:3.0];
                           
                           passwordField.text = @"";
                       }
                   } andFailedOperation:^(LRRestyResponse *response) {
                       [authIndicator stopAnimating];
                       [addButton setEnabled:YES];
                   }];
}

-(void) shakeIt:(UIView*)view withDelta:(CGFloat)delta
{
    CAKeyframeAnimation *anim = [ CAKeyframeAnimation animationWithKeyPath:@"transform" ] ;
    anim.values = [ NSArray arrayWithObjects:
                   [ NSValue valueWithCATransform3D:CATransform3DMakeTranslation(delta, 0.0f, 0.0f) ],
                   [ NSValue valueWithCATransform3D:CATransform3DMakeTranslation(-delta, 0.0f, 0.0f) ],
                   nil ] ;
    anim.autoreverses = YES ;
    anim.repeatCount = 8.0f ;
    anim.duration = 0.03f ;
    
    [view.layer addAnimation:anim forKey:nil ];
}

@end
