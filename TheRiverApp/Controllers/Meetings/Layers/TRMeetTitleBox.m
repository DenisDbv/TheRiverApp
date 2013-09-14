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
    
    MGLineStyled *authorLine = [MGLineStyled lineWithMultilineLeft:box.meetingData.meetingGroup right:nil width:300 minHeight:10];
    authorLine.backgroundColor = [UIColor clearColor];
    authorLine.leftPadding = authorLine.rightPadding = 0;
    authorLine.borderStyle = MGBorderNone;
    authorLine.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:13];
    authorLine.textColor = [UIColor lightGrayColor];
    [box.boxes addObject:authorLine];
    
    return box;
}

@end
