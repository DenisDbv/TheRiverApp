//
//  TRBindingManager.m
//  TheRiverApp
//
//  Created by DenisDbv on 03.10.13.
//  Copyright (c) 2013 axbx. All rights reserved.
//

#import "TRBindingManager.h"
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>
#import <MessageUI/MFMessageComposeViewController.h>
#import <QuartzCore/QuartzCore.h>
#import <SIAlertView/SIAlertView.h>

@implementation TRBindingManager

+ (instancetype)sharedInstance
{
    return [ABMultiton sharedInstanceOfClass:[self class]];
}

-(id) init
{
    return [super init];
}

-(void) skypeBinding:(TRUserInfoModel*)userModel
{
    if(userModel.contact_data.skype.length == 0) return;
    
    BOOL installed = [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"skype:"]];
    if(installed)
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"skype:%@?call", userModel.contact_data.skype]]];
    }
    else
    {
        SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:nil andMessage:@"У Вас не установлено приложение Skype.\n Установить?"];
        alertView.messageFont = [UIFont fontWithName:@"HypatiaSansPro-Regular" size:18];
        [alertView addButtonWithTitle:@"НЕТ"
                                 type:SIAlertViewButtonTypeCancel
                              handler:^(SIAlertView *alertView) {
                                  NSLog(@"Cancel Clicked");
                              }];
        [alertView addButtonWithTitle:@"ДА"
                                 type:SIAlertViewButtonTypeDefault
                              handler:^(SIAlertView *alertView) {
                                  [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://itunes.com/apps/skype/skype"]];
                              }];
        [alertView show];
    }
}

-(void) callBinding:(TRUserInfoModel*)userModel
{
    NSString *phoneNumber = [@"tel://" stringByAppendingString: [userModel.contact_data.phone objectAtIndex:0] ];
    if(phoneNumber.length > 0)
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString: phoneNumber]];
}

-(void) vkBinding:(TRUserInfoModel*)userModel
{
    if(userModel.contact_data.vk.length == 0) return;
    
    NSURL *url = [NSURL URLWithString:userModel.contact_data.vk];
    [[UIApplication sharedApplication] openURL:url];
}

-(void) fbBinding:(TRUserInfoModel*)userModel
{
    if(userModel.contact_data.fb.length == 0) return;
    
    NSURL *url = [NSURL URLWithString:userModel.contact_data.fb];
    [[UIApplication sharedApplication] openURL:url];
}

-(void) emailBinding:(TRUserInfoModel*)userModel
{
    if(userModel.email.length == 0) return;
    
    if ([MFMailComposeViewController canSendMail]) {
        
        //NSLog(@"%@", userModel.email);
        MFMailComposeViewController *mailViewController = [[MFMailComposeViewController alloc] init];
        mailViewController.mailComposeDelegate = (id)self;
        [mailViewController setToRecipients:@[userModel.email]];
        [mailViewController setSubject:@""];
        [mailViewController setMessageBody:@"" isHTML:NO];
        
        UIViewController *rootViewController = [UIApplication sharedApplication].delegate.window.rootViewController;
        [rootViewController presentModalViewController:mailViewController animated:YES];
    }
    
    else {
        NSLog(@"Device is unable to send email in its current state.");
    }
}

-(void)mailComposeController:(MFMailComposeViewController*)controller
         didFinishWithResult:(MFMailComposeResult)result
                       error:(NSError *)error
{
    [controller dismissModalViewControllerAnimated:YES];
}

-(void) smsBinding:(TRUserInfoModel*)userModel
{
    MFMessageComposeViewController *controller = [[MFMessageComposeViewController alloc] init];
    if([MFMessageComposeViewController canSendText]){
        controller.body = @"";
        controller.recipients = [NSArray arrayWithObjects:[userModel.contact_data.phone objectAtIndex:0],nil];
        controller.messageComposeDelegate = (id)self;
        
        UIViewController *rootViewController = [UIApplication sharedApplication].delegate.window.rootViewController;
        [rootViewController presentModalViewController:controller animated:YES];
    }
}

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    [controller dismissModalViewControllerAnimated:YES];
}
@end
