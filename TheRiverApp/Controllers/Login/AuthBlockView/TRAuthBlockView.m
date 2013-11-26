//
//  TRAuthBlockView.m
//  TheRiverApp
//
//  Created by DenisDbv on 17.11.13.
//  Copyright (c) 2013 axbx. All rights reserved.
//

#import "TRAuthBlockView.h"
#import <QuartzCore/QuartzCore.h>
#import <NVUIGradientButton/NVUIGradientButton.h>
#import <SSToolkit/SSLineView.h>

@interface TRAuthBlockView()
@property (nonatomic, retain) UIActivityIndicatorView *authIndicator;
@end

@implementation TRAuthBlockView
{
    NVUIGradientButton *loginButton;
}
@synthesize loginBlockView;
@synthesize emailTextField, passwordTextField;
@synthesize authIndicator;

- (id)init {
    self = [super initWithFrame:CGRectZero];
    
    if (self) {
        NSArray* nib = [[NSBundle mainBundle] loadNibNamed:@"TRAuthBlockView" owner:self options:nil];
        [[nib objectAtIndex:0] setFrame:CGRectMake(10, 100, 290, 233)];
        self = [nib objectAtIndex:0];
        
        //self.backgroundColor = [UIColor redColor];
        self.layer.cornerRadius = 8.0;
        self.layer.borderWidth = 0.5;
        self.layer.borderColor = [UIColor colorWithRed:48.0/255.0 green:48.0/255.0 blue:48.0/255.0 alpha:1.0].CGColor;
        
        [self initialized];
    }
    
    return self;
}

-(void) initialized
{
    loginBlockView.layer.cornerRadius = 4.0;
    loginBlockView.layer.borderWidth = 0.5;
    loginBlockView.layer.borderColor = [UIColor colorWithRed:21.0/255.0 green:21.0/255.0 blue:21.0/255.0 alpha:1.0].CGColor;
    
    SSLineView *sepEmailPassword = [[SSLineView alloc] initWithFrame:CGRectMake(2, loginBlockView.frame.size.height/2, loginBlockView.frame.size.width-4, 0.5)];
    sepEmailPassword.backgroundColor = [UIColor colorWithRed:205.0/255.0 green:205.0/255.0 blue:205.0/255.0 alpha:1.0];
    [loginBlockView addSubview:sepEmailPassword];
    
    loginButton = [[NVUIGradientButton alloc] initWithFrame:CGRectMake(21, 161, 250, 44) style:NVUIGradientButtonStyleDefault];
    [loginButton addTarget:self action:@selector(onLoginClick:) forControlEvents:UIControlEventTouchUpInside];
    loginButton.tintColor = loginButton.highlightedTintColor = [UIColor colorWithRed:77.0/255.0 green:112.0/255.0 blue:255.0/255.0 alpha:1.0];
    loginButton.borderColor = [UIColor clearColor];
    loginButton.highlightedBorderColor = [UIColor blueColor];
    [loginButton setCornerRadius:4.0f];
    [loginButton setGradientEnabled:NO];
    loginButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:16];
    loginButton.textColor = loginButton.highlightedTextColor = [UIColor whiteColor];
    loginButton.textShadowColor = [UIColor clearColor];
    loginButton.highlightedTextShadowColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.2];
    loginButton.text = @"Войти";
    [self addSubview:loginButton];
    
    authIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(70, 12, 20, 20)];
    [authIndicator setColor:[UIColor whiteColor]];
    [loginButton addSubview:authIndicator];
    
    //Так как в ios7 исчезает мигающий индикатор
    if(IS_OS_7_OR_LATER)    {
        emailTextField.tintColor = [UIColor colorWithRed:77.0/255.0 green:112.0/255.0 blue:255.0/255.0 alpha:1.0];
        passwordTextField.tintColor = [UIColor colorWithRed:77.0/255.0 green:112.0/255.0 blue:255.0/255.0 alpha:1.0];
    }
}

-(BOOL)textFieldShouldReturn:(UITextField*)textField
{
    if(textField.tag == 1)  {
        [passwordTextField becomeFirstResponder];
    } else  {
        [self onLoginClick:nil];
    }
    
    return YES;
}

-(void) onLoginClick:(id)sender
{
    if([self.delegate respondsToSelector:@selector(onClickLoginWithEmail:andPassword:)])
    {
        [self.delegate onClickLoginWithEmail:emailTextField.text
                                 andPassword:passwordTextField.text];
    }
}

-(void) startSpinner
{
    [authIndicator startAnimating];
    [loginButton setEnabled:NO];
}

-(void) stopSpinner
{
    [authIndicator stopAnimating];
    [loginButton setEnabled:YES];
}

-(void) shakeLoginView
{
    [self shakeIt:loginBlockView withDelta:-2.0];
}

-(void) resignFromAllFields
{
    [emailTextField resignFirstResponder];
    [passwordTextField resignFirstResponder];
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
