//
//  TRMeetTitleBox.m
//  TheRiverApp
//
//  Created by DenisDbv on 14.09.13.
//  Copyright (c) 2013 axbx. All rights reserved.
//

#import "TRMeetTitleBox.h"
#import <MGBox2/MGLineStyled.h>

@implementation TRMeetTitleBox

- (void)setup {
    
    self.backgroundColor = [UIColor whiteColor];
    
    self.leftMargin = self.rightMargin = 9;
}

+(MGBox *) initBox:(CGSize)bounds withMeetData:(TREventModel *)meetObject
{
    TRMeetTitleBox *box = [TRMeetTitleBox boxWithSize: CGSizeMake(bounds.width, 10)];
    box.meetingData = meetObject;
    
    box.contentLayoutMode = MGLayoutTableStyle;
    
    MGLineStyled *titleLine = [MGLineStyled lineWithMultilineLeft:box.meetingData.title right:nil width:300.0 minHeight:10];
    titleLine.backgroundColor = [UIColor clearColor];
    titleLine.topMargin = 10;
    titleLine.leftPadding = titleLine.rightPadding = 0;
    titleLine.borderStyle = MGBorderNone;
    titleLine.font = [UIFont fontWithName:@"HypatiaSansPro-Bold" size:23];
    [box.boxes addObject:titleLine];
    
    UILabel *pointLabel = [[UILabel alloc] init];
    pointLabel.text = meetObject.place;
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
    
    
    MGLineStyled *authorLine = [MGLineStyled lineWithMultilineLeft:box.meetingData.group right:blockView width:300 minHeight:10];
    authorLine.backgroundColor = [UIColor clearColor];
    authorLine.topMargin = 10.0f;
    authorLine.leftPadding = authorLine.rightPadding = 0;
    authorLine.borderStyle = MGBorderNone;
    authorLine.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:13];
    authorLine.textColor = [UIColor lightGrayColor];
    [box.boxes addObject:authorLine];
    
    if(box.meetingData.isEnded == NO)   {
        box.agreeButton = [[ACPButton alloc] initWithFrame:CGRectMake(0, 0, 300, 40)];
        [box.agreeButton addTarget:box action:@selector(onSbscrClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [box.agreeButton setLabelTextColor:[UIColor whiteColor] highlightedColor:[UIColor whiteColor] disableColor:nil];
        [box.agreeButton setCornerRadius:4];
        [box.agreeButton setBorderStyle:nil andInnerColor:nil];
        if(meetObject.isAccept == NO) {
            [box.agreeButton setStyle:[UIColor colorWithRed:77.0/255.0 green:112.0/255.0 blue:255.0/255.0 alpha:1.0] andBottomColor:[UIColor colorWithRed:77.0/255.0 green:112.0/255.0 blue:255.0/255.0 alpha:1.0]];
            [box.agreeButton setLabelTextShadow:CGSizeMake(0.5, 1) normalColor:nil highlightedColor:[UIColor blueColor] disableColor:nil];
            [box.agreeButton setTitle:@"Я пойду" forState:UIControlStateNormal];
        } else  {
            [box.agreeButton setStyle:[UIColor colorWithRed:110.0/255.0 green:206.0/255.0 blue:15.0/255.0 alpha:1.0] andBottomColor:[UIColor colorWithRed:110.0/255.0 green:206.0/255.0 blue:15.0/255.0 alpha:1.0]];
            [box.agreeButton setLabelTextShadow:CGSizeMake(0.5, 1) normalColor:nil highlightedColor:[UIColor greenColor] disableColor:nil];
            [box.agreeButton setTitle:@"Я иду" forState:UIControlStateNormal];
        }
        
        MGBox *buttonLine = [MGBox boxWithSize:CGSizeMake(300, 40)];
        buttonLine.backgroundColor = [UIColor clearColor];
        buttonLine.topMargin = 20.0;
        buttonLine.leftPadding = authorLine.rightPadding = 0;
        buttonLine.leftMargin = buttonLine.rightMargin = 0;
        buttonLine.borderStyle = MGBorderNone;
        [buttonLine addSubview: box.agreeButton];
        [box.boxes addObject:buttonLine];
    }
    
    return box;
}

-(void) onSbscrClick:(id)sender
{
    self.agreeButton.enabled = NO;
    self.agreeButton.userInteractionEnabled = NO;
    
    [[TRMeetingManager client] subscribeMeetingByID:self.meetingData.objectId successOperation:^(LRRestyResponse *response) {
        if(self.meetingData.isAccept == NO)
        {
            self.meetingData.isAccept = YES;
            
            [self.agreeButton setStyle:[UIColor colorWithRed:110.0/255.0 green:206.0/255.0 blue:15.0/255.0 alpha:1.0] andBottomColor:[UIColor colorWithRed:110.0/255.0 green:206.0/255.0 blue:15.0/255.0 alpha:1.0]];
            [self.agreeButton setLabelTextShadow:CGSizeMake(0.5, 1) normalColor:nil highlightedColor:[UIColor greenColor] disableColor:nil];
            [self.agreeButton setTitle:@"Я иду" forState:UIControlStateNormal];
        } else  {
            self.meetingData.isAccept = NO;
            
            [self.agreeButton setStyle:[UIColor colorWithRed:77.0/255.0 green:112.0/255.0 blue:255.0/255.0 alpha:1.0] andBottomColor:[UIColor colorWithRed:77.0/255.0 green:112.0/255.0 blue:255.0/255.0 alpha:1.0]];
            [self.agreeButton setLabelTextShadow:CGSizeMake(0.5, 1) normalColor:nil highlightedColor:[UIColor blueColor] disableColor:nil];
            [self.agreeButton setTitle:@"Я пойду" forState:UIControlStateNormal];
        }
        self.agreeButton.enabled = YES;
        self.agreeButton.userInteractionEnabled = YES;
    } andFailedOperation:^(LRRestyResponse *response) {
        self.agreeButton.enabled = YES;
        self.agreeButton.userInteractionEnabled = YES;
    }];
}

@end
