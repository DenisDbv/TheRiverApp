//
//  TRSecondHeadBox.m
//  TheRiverApp
//
//  Created by DenisDbv on 03.09.13.
//  Copyright (c) 2013 axbx. All rights reserved.
//

#import "TRSecondHeadBox.h"
#import <MGBox2/MGButton.h>
#import <NVUIGradientButton/NVUIGradientButton.h>

#import "TRTagsScrollBox.h"
#import "TRMoreBoxes.h"

@implementation TRSecondHeadBox

- (void)setup {

    // background
    self.backgroundColor = [UIColor whiteColor];
    
}

+(TRSecondHeadBox *)initBox:(CGSize)bounds
{
    TRSecondHeadBox *box = [TRSecondHeadBox boxWithSize: CGSizeMake(bounds.width, 300)];
    
    MGBox *buttonsBox = [MGBox boxWithSize:CGSizeMake(box.bounds.size.width, 30)];
    buttonsBox.topMargin = 10;
    [box.boxes addObject:buttonsBox];
    //buttonsBox.backgroundColor = [UIColor purpleColor];
    
    NVUIGradientButton *subscribeButton = [[NVUIGradientButton alloc] initWithFrame:CGRectMake(10, 0, 145, 30) style:NVUIGradientButtonStyleDefault];
    subscribeButton.text = @"Подписаться";
    subscribeButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:12];
    subscribeButton.textColor = [UIColor blackColor];
    [subscribeButton setBorderColor:[UIColor colorWithWhite:0.12 alpha:0.3]];
    [subscribeButton setCornerRadius:2.0f];
    CGFloat gray = 220.0/255.0;
    subscribeButton.tintColor = [UIColor colorWithRed:gray green:gray blue:gray alpha:1];
    subscribeButton.highlightedTintColor = [UIColor colorWithRed:gray green:gray blue:gray alpha:1];
    subscribeButton.highlightedBorderColor = [UIColor colorWithWhite:0.12 alpha:1];
    [buttonsBox addSubview:subscribeButton];
    
    NVUIGradientButton *messageButton = [[NVUIGradientButton alloc] initWithFrame:CGRectMake(165, 0, 145, 30) style:NVUIGradientButtonStyleDefault];
    messageButton.text = @"Сообщение";
    messageButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:12];
    messageButton.textColor = [UIColor blackColor];
    [messageButton setBorderColor:[UIColor colorWithWhite:0.12 alpha:0.3]];
    [messageButton setCornerRadius:2.0f];
    messageButton.tintColor = [UIColor colorWithRed:gray green:gray blue:gray alpha:1];
    messageButton.highlightedTintColor = [UIColor colorWithRed:gray green:gray blue:gray alpha:1];
    messageButton.highlightedBorderColor = [UIColor colorWithWhite:0.12 alpha:1];
    [buttonsBox addSubview:messageButton];
    
    TRTagsScrollBox *tagsResolution = [TRTagsScrollBox initBoxWithTitle:@"высокое разрешение:" andTagsArray:[[NSArray alloc] initWithObjects:@"#iOS", @"#Android", @"#Ruby", @"#Rails", nil]];
    [box.boxes addObject:tagsResolution];
    
    TRTagsScrollBox *tagsCurrentBusiness = [TRTagsScrollBox initBoxWithTitle:@"текущие ниши:" andTagsArray:[[NSArray alloc] initWithObjects:@"AXBX software", @"Школа программирования", @"NEO", nil]];
    [box.boxes addObject:tagsCurrentBusiness];
    
    TRMoreBoxes *moreBoxes = [TRMoreBoxes initBoxes];
    [box.boxes addObject:moreBoxes];
    
    return box;
}

@end
