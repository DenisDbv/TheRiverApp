//
//  TRMeetTitleBox.m
//  TheRiverApp
//
//  Created by DenisDbv on 14.09.13.
//  Copyright (c) 2013 axbx. All rights reserved.
//

#import "TRMeetTitleBox.h"
#import <MGBox2/MGLineStyled.h>
#import <ACPButton/ACPButton.h>

@implementation TRMeetTitleBox

- (void)setup {
    
    self.backgroundColor = [UIColor whiteColor];
    
    self.leftMargin = self.rightMargin = 9;
}

+(MGBox *) initBox:(CGSize)bounds withMeetData:(TRMeetingModel *)meetObject
{
    TRMeetTitleBox *box = [TRMeetTitleBox boxWithSize: CGSizeMake(bounds.width, 10)];
    box.meetingData = meetObject;
    
    box.contentLayoutMode = MGLayoutTableStyle;
    
    MGLineStyled *titleLine = [MGLineStyled lineWithMultilineLeft:box.meetingData.meetingTitle right:nil width:300.0 minHeight:10];
    titleLine.backgroundColor = [UIColor clearColor];
    titleLine.topMargin = 10;
    titleLine.leftPadding = titleLine.rightPadding = 0;
    titleLine.borderStyle = MGBorderNone;
    titleLine.font = [UIFont fontWithName:@"HypatiaSansPro-Bold" size:23];
    [box.boxes addObject:titleLine];
    
    UILabel *pointLabel = [[UILabel alloc] init];
    pointLabel.text = meetObject.meetingCity;
    pointLabel.backgroundColor = [UIColor clearColor];
    pointLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:13];
    pointLabel.textColor = [UIColor lightGrayColor];
    [pointLabel sizeToFit];
    UIImage *locationImage = [UIImage imageNamed:@"location-icon-gray@2x.png"];
    UIView *blockView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,
                                                                pointLabel.frame.size.width+5+locationImage.size.width,
                                                                pointLabel.frame.size.height)];
    UIImageView *imgView = [[UIImageView alloc] initWithImage:locationImage];
    imgView.frame = CGRectOffset(imgView.frame, 0, (blockView.frame.size.height-imgView.frame.size.height)/2);
    [blockView addSubview:imgView];
    [blockView addSubview:pointLabel];
    pointLabel.frame = CGRectOffset(pointLabel.frame, imgView.frame.size.width+5, 0);
    
    
    MGLineStyled *authorLine = [MGLineStyled lineWithMultilineLeft:box.meetingData.meetingGroup right:blockView width:300 minHeight:10];
    authorLine.backgroundColor = [UIColor clearColor];
    authorLine.leftPadding = authorLine.rightPadding = 0;
    authorLine.borderStyle = MGBorderNone;
    authorLine.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:13];
    authorLine.textColor = [UIColor lightGrayColor];
    [box.boxes addObject:authorLine];
    
    ACPButton *agreeButton = [[ACPButton alloc] initWithFrame:CGRectMake(0, 0,
                                                                         300, 40)];
    [agreeButton setLabelTextColor:[UIColor whiteColor] highlightedColor:[UIColor whiteColor] disableColor:nil];
    [agreeButton setCornerRadius:4];
    [agreeButton setBorderStyle:nil andInnerColor:nil];
    if(meetObject.isCheck == NO) {
        [agreeButton setStyle:[UIColor colorWithRed:77.0/255.0 green:112.0/255.0 blue:255.0/255.0 alpha:1.0] andBottomColor:[UIColor colorWithRed:77.0/255.0 green:112.0/255.0 blue:255.0/255.0 alpha:1.0]];
        [agreeButton setLabelTextShadow:CGSizeMake(0.5, 1) normalColor:nil highlightedColor:[UIColor blueColor] disableColor:nil];
        [agreeButton setTitle:@"Я пойду" forState:UIControlStateNormal];
    } else  {
        [agreeButton setStyle:[UIColor colorWithRed:110.0/255.0 green:206.0/255.0 blue:15.0/255.0 alpha:1.0] andBottomColor:[UIColor colorWithRed:110.0/255.0 green:206.0/255.0 blue:15.0/255.0 alpha:1.0]];
        [agreeButton setLabelTextShadow:CGSizeMake(0.5, 1) normalColor:nil highlightedColor:[UIColor greenColor] disableColor:nil];
        [agreeButton setTitle:@"Я иду" forState:UIControlStateNormal];
    }
    
    MGBox *buttonLine = [MGBox boxWithSize:CGSizeMake(300, 40)];
    buttonLine.backgroundColor = [UIColor clearColor];
    buttonLine.topMargin = 10.0;
    buttonLine.leftPadding = authorLine.rightPadding = 0;
    buttonLine.leftMargin = buttonLine.rightMargin = 0;
    buttonLine.borderStyle = MGBorderNone;
    [buttonLine addSubview:agreeButton];
    [box.boxes addObject:buttonLine];
    
    return box;
}

@end
