//
//  TRMeetingItemCell.m
//  TheRiverApp
//
//  Created by DenisDbv on 13.09.13.
//  Copyright (c) 2013 axbx. All rights reserved.
//

#import "TRMeetingItemCell.h"

@implementation TRMeetingItemCell
@synthesize labelCity, labelDay, labelGroup, labelMonth, labelTitle, agreeButton;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

-(void) reloadWithMeetingModel:(TRMeetingModel*)meetingObject
{
    labelDay.font = [UIFont fontWithName:@"HelveticaNeue" size:20];
    labelMonth.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:15];
    labelCity.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:15];
    labelTitle.font = [UIFont fontWithName:@"HypatiaSansPro-Bold" size:18];
    labelGroup.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:14];

    NSInteger maxDateBlock = [self getMaxWidthFromStrings:meetingObject];
    
    [self changeSizeLabel:labelDay atString:meetingObject.meetingDay];
    labelDay.frame = [self changeWidthInFrame:labelDay.frame byWidth:maxDateBlock];
    
    [self changeSizeLabel:labelMonth atString:meetingObject.meetingMonth];
    labelMonth.frame = [self changeWidthInFrame:labelMonth.frame byWidth:maxDateBlock];
    labelMonth.frame = [self changeYInFrame:labelMonth.frame byY:labelDay.frame.origin.y+labelDay.frame.size.height];
    
    [self changeSizeLabel:labelCity atString:meetingObject.meetingCity];
    labelCity.frame = [self changeWidthInFrame:labelCity.frame byWidth:maxDateBlock];
    labelCity.frame = [self changeYInFrame:labelCity.frame byY:labelMonth.frame.origin.y+labelMonth.frame.size.height];
    
    CGSize sizeTitle = [meetingObject.meetingTitle sizeWithFont:labelTitle.font
                                            constrainedToSize:CGSizeMake(320-(maxDateBlock+35), 50)
                                                lineBreakMode:NSLineBreakByWordWrapping];
    labelTitle.text = meetingObject.meetingTitle;
    labelTitle.frame = CGRectMake(maxDateBlock+35, 5, 320-(maxDateBlock+35), sizeTitle.height);
    
    CGSize sizeGroup = [meetingObject.meetingGroup sizeWithFont:labelGroup.font
                                              constrainedToSize:CGSizeMake(320-(maxDateBlock+35), 50)
                                                  lineBreakMode:NSLineBreakByWordWrapping];
    labelGroup.text = meetingObject.meetingGroup;
    labelGroup.frame = CGRectMake(maxDateBlock+35, labelTitle.frame.origin.y+labelTitle.frame.size.height, 320-(maxDateBlock+35), sizeGroup.height);
    
    //agreeButton = [[ACPButton alloc] initWithFrame:CGRectMake(5, labelGroup.frame.origin.y+labelGroup.frame.size.height+10, 320-10, 30)];
    agreeButton.frame = CGRectMake(5, labelGroup.frame.origin.y+labelGroup.frame.size.height+10, 320-10, 30);
    [agreeButton setStyle:[UIColor yellowColor]  andBottomColor:[UIColor orangeColor]];
    [agreeButton setLabelTextColor:[UIColor orangeColor] highlightedColor:[UIColor redColor] disableColor:nil];
    [agreeButton setCornerRadius:4];
    [agreeButton setBorderStyle:[UIColor blueColor] andInnerColor:nil];
    [agreeButton setLabelTextColor:[UIColor blackColor] highlightedColor:[UIColor lightGrayColor] disableColor:nil];
    [agreeButton setTitle:@"Я иду" forState:UIControlStateNormal];
}

-(NSInteger) getMaxWidthFromStrings:(TRMeetingModel*)meetingObject
{
    CGSize sizeMonth = [meetingObject.meetingMonth sizeWithFont:labelMonth.font
                          constrainedToSize:CGSizeMake(FLT_MAX, FLT_MAX)
                              lineBreakMode:NSLineBreakByWordWrapping];
    CGSize sizeCity = [meetingObject.meetingCity sizeWithFont:labelCity.font
                                              constrainedToSize:CGSizeMake(FLT_MAX, FLT_MAX)
                                                  lineBreakMode:NSLineBreakByWordWrapping];
    
    return MAX(sizeMonth.width, sizeCity.width);
}

-(void) changeSizeLabel:(UILabel*)label atString:(NSString*)text
{
    CGSize size = [text sizeWithFont:label.font constrainedToSize:CGSizeMake(FLT_MAX, FLT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
    label.text = text;
    label.frame = CGRectMake(label.frame.origin.x, label.frame.origin.y, size.width, size.height);
}

-(CGRect) changeWidthInFrame:(CGRect)frame byWidth:(NSInteger)width
{
    return CGRectMake(frame.origin.x, frame.origin.y, width, frame.size.height);
}

-(CGRect) changeYInFrame:(CGRect)frame byY:(NSInteger)coord
{
    return CGRectMake(frame.origin.x, coord, frame.size.width, frame.size.height);
}

@end
