//
//  TRContactBox.m
//  TheRiverApp
//
//  Created by DenisDbv on 08.09.13.
//  Copyright (c) 2013 axbx. All rights reserved.
//

#import "TRContactBox.h"
#import <NVUIGradientButton/NVUIGradientButton.h>

@implementation TRContactBox

- (void)setup {
    
    self.backgroundColor = [UIColor whiteColor];
}

+(TRContactBox *)initBox:(CGSize)bounds withUserData:(TRUserModel *)userObject
{
    TRContactBox *box = [TRContactBox boxWithSize: CGSizeMake(bounds.width, 149)];
    box.userData = userObject;
    box.zIndex = -1;
    
    [box showFirstItemContactButtons];
    [box showSecondItemContactButtons];
    
    return box;
}

-(void) showFirstItemContactButtons
{
    MGBox *buttonsBox = [MGBox boxWithSize:CGSizeMake(self.bounds.size.width, 41)];
    buttonsBox.topMargin = 48;
    [self.boxes addObject:buttonsBox];
    
    UIImage *imgSbscrb = [UIImage imageNamed:@"subscribe-icon@2x.png"];
    UIImage *imgMessage = [UIImage imageNamed:@"send-message-icon@2x.png"];
    
    UIImageView *imgSbsView = [[UIImageView alloc] initWithImage:imgSbscrb];
    imgSbsView.frame = CGRectMake(10, 15, imgSbscrb.size.width/2, imgSbscrb.size.height/2);
    UIImageView *imgMessageView = [[UIImageView alloc] initWithImage:imgMessage];
    imgMessageView.frame = CGRectMake(13, 15, imgMessage.size.width/2, imgMessage.size.height/2);
    
    NVUIGradientButton *subscribeButton = [[NVUIGradientButton alloc] initWithFrame:CGRectMake(9, 0, 146, 41) style:NVUIGradientButtonStyleDefault];
    subscribeButton.leftAccessoryImage = [UIImage imageNamed:@"subscribe-icon.png"];
    subscribeButton.tintColor = subscribeButton.highlightedTintColor = [UIColor clearColor];
    subscribeButton.borderColor = [UIColor colorWithRed:77.0/255.0 green:112.0/255.0 blue:255.0/255.0 alpha:0.5];
    subscribeButton.highlightedBorderColor = [UIColor colorWithRed:77.0/255.0 green:112.0/255.0 blue:255.0/255.0 alpha:1.0];
    [subscribeButton setCornerRadius:4.0f];
    [subscribeButton setGradientEnabled:NO];
    subscribeButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:16];
    subscribeButton.textColor = subscribeButton.highlightedTextColor = [UIColor colorWithRed:77.0/255.0 green:112.0/255.0 blue:255.0/255.0 alpha:1.0];
    subscribeButton.textShadowColor = [UIColor whiteColor];
    subscribeButton.highlightedTextShadowColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.5];
    subscribeButton.text = @"Подписаться";
    [buttonsBox addSubview:subscribeButton];
    [subscribeButton addSubview:imgSbsView];
    
    NVUIGradientButton *messageButton = [[NVUIGradientButton alloc] initWithFrame:CGRectMake(164, 0, 146, 41) style:NVUIGradientButtonStyleDefault];
    messageButton.leftAccessoryImage = [UIImage imageNamed:@"send-message-icon.png"];
    messageButton.tintColor = messageButton.highlightedTintColor = [UIColor clearColor];
    messageButton.borderColor = [UIColor colorWithRed:77.0/255.0 green:112.0/255.0 blue:255.0/255.0 alpha:0.5];
    messageButton.highlightedBorderColor = [UIColor colorWithRed:77.0/255.0 green:112.0/255.0 blue:255.0/255.0 alpha:1.0];
    [messageButton setCornerRadius:4.0f];
    [messageButton setGradientEnabled:NO];
    messageButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:16];
    messageButton.textColor = messageButton.highlightedTextColor = [UIColor colorWithRed:77.0/255.0 green:112.0/255.0 blue:255.0/255.0 alpha:1.0];
    messageButton.textShadowColor = [UIColor whiteColor];
    messageButton.highlightedTextShadowColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.5];
    messageButton.text = @"Сообщение";
    [buttonsBox addSubview:messageButton];
    [messageButton addSubview:imgMessageView];
}

-(void) showSecondItemContactButtons
{
    MGBox *buttonsBox = [MGBox boxWithSize:CGSizeMake(self.bounds.size.width, 48)];
    buttonsBox.topMargin = 12;
    [self.boxes addObject:buttonsBox];
    
    UIImage *imgMessage = [UIImage imageNamed:@"add-contact-white-icon@2x.png"];
    UIImageView *imgSbsView = [[UIImageView alloc] initWithImage:imgMessage];
    imgSbsView.frame = CGRectMake(26, 17, imgMessage.size.width/2, imgMessage.size.height/2);
    
    NVUIGradientButton *addButton = [[NVUIGradientButton alloc] initWithFrame:CGRectMake(9, 0, 302, 48) style:NVUIGradientButtonStyleDefault];
    addButton.leftAccessoryImage = [UIImage imageNamed:@"add-contact-white-icon.png"];
    addButton.tintColor = addButton.highlightedTintColor = [UIColor colorWithRed:77.0/255.0 green:112.0/255.0 blue:255.0/255.0 alpha:1.0]; //[UIColor colorWithRed:252.0/255.0 green:189.0/255.0 blue:0.0 alpha:1.0];
    addButton.borderColor = [UIColor clearColor];
    addButton.highlightedBorderColor = [UIColor blueColor];
    [addButton setCornerRadius:6.0f];
    [addButton setGradientEnabled:NO];
    addButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:19];
    addButton.textColor = addButton.highlightedTextColor = [UIColor whiteColor];
    addButton.textShadowColor = [UIColor clearColor];
    addButton.highlightedTextShadowColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.2];
    addButton.text = @"Добавить в контакты";
    [buttonsBox addSubview:addButton];
    [addButton addSubview:imgSbsView];
}

@end
