//
//  TRMeetingItemCell.m
//  TheRiverApp
//
//  Created by DenisDbv on 13.09.13.
//  Copyright (c) 2013 axbx. All rights reserved.
//

#import "TRMeetingItemCell.h"

@implementation TRMeetingItemCell
{
    TREventModel *eventItem;
}
@synthesize labelCity, labelDay, labelGroup, labelMonth, labelTitle, agreeButton, labelIfDisable;

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

-(void) reloadWithMeetingModel:(TREventModel*)meetingObject
{
    eventItem = meetingObject;
    
    labelDay.font = [UIFont fontWithName:@"HelveticaNeue" size:30];
    labelMonth.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:15];
    
    labelDay.textColor = labelMonth.textColor = [UIColor redColor];
    
    labelCity.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:15];
    labelTitle.font = [UIFont fontWithName:@"HypatiaSansPro-Bold" size:18];
    labelGroup.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:14];
    labelIfDisable.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:14];
    
    if(meetingObject.isEnded == YES)
    {
        labelDay.textColor = labelCity.textColor = labelGroup.textColor = labelMonth.textColor = labelTitle.textColor = labelIfDisable.textColor = [UIColor lightGrayColor];
    }

    NSInteger maxDateBlock = 76.0; //[self getMaxWidthFromStrings:meetingObject];
    //NSLog(@"==>%i", maxDateBlock);
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"dd.MM.yyyy HH:mm"];
    NSDate *myDate = [df dateFromString: meetingObject.start_date];
    NSLog(@"%@", myDate.description);
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd"];
    
    [self changeSizeLabel:labelDay atString:[dateFormatter stringFromDate:myDate]];
    labelDay.frame = [self changeWidthInFrame:labelDay.frame byWidth:maxDateBlock];
    labelDay.frame = [self changeXInFrame:labelDay.frame byX:13];
    
    [dateFormatter setDateFormat:@"MMMM"];
    [self changeSizeLabel:labelMonth atString:[dateFormatter stringFromDate:myDate]];
    labelMonth.frame = [self changeWidthInFrame:labelMonth.frame byWidth:maxDateBlock];
    labelMonth.frame = [self changeYInFrame:labelMonth.frame byY:labelDay.frame.origin.y+labelDay.frame.size.height+3];
    labelMonth.frame = [self changeXInFrame:labelMonth.frame byX:13];
    
    [self changeSizeLabel:labelCity atString:meetingObject.place];
    labelCity.frame = [self changeWidthInFrame:labelCity.frame byWidth:maxDateBlock];
    labelCity.frame = [self changeYInFrame:labelCity.frame byY:labelMonth.frame.origin.y+labelMonth.frame.size.height+5];
    labelCity.frame = [self changeXInFrame:labelCity.frame byX:13];
    
    CGSize sizeTitle = [meetingObject.title sizeWithFont:labelTitle.font
                                            constrainedToSize:CGSizeMake(320-(maxDateBlock+35), 50)
                                                lineBreakMode:NSLineBreakByWordWrapping];
    labelTitle.text = meetingObject.title;
    labelTitle.frame = CGRectMake(maxDateBlock+35, 10, 320-(maxDateBlock+35), sizeTitle.height);
    
    CGSize sizeGroup = [meetingObject.group sizeWithFont:labelGroup.font
                                              constrainedToSize:CGSizeMake(320-(maxDateBlock+35), 50)
                                                  lineBreakMode:NSLineBreakByWordWrapping];
    labelGroup.text = meetingObject.group;
    labelGroup.frame = CGRectMake(maxDateBlock+35, labelTitle.frame.origin.y+labelTitle.frame.size.height, 320-(maxDateBlock+35), sizeGroup.height);
    
    if(meetingObject.isEnded == NO)    {
        labelIfDisable.hidden = YES;
        agreeButton.hidden = NO;
        
        agreeButton.frame = CGRectMake(maxDateBlock+35, labelGroup.frame.origin.y+labelGroup.frame.size.height+10, 125, 35);
        [agreeButton addTarget:self action:@selector(onSbscrClick:) forControlEvents:UIControlEventTouchUpInside];
        [agreeButton setLabelTextColor:[UIColor whiteColor] highlightedColor:[UIColor whiteColor] disableColor:nil];
        [agreeButton setCornerRadius:4];
        [agreeButton setBorderStyle:nil andInnerColor:nil];
        //NSLog(@"%i", meetingObject.isAccept);
        if(meetingObject.isAccept == NO) {
            [agreeButton setStyle:[UIColor colorWithRed:77.0/255.0 green:112.0/255.0 blue:255.0/255.0 alpha:1.0] andBottomColor:[UIColor colorWithRed:77.0/255.0 green:112.0/255.0 blue:255.0/255.0 alpha:1.0]];
            [agreeButton setLabelTextShadow:CGSizeMake(0.5, 1) normalColor:nil highlightedColor:[UIColor blueColor] disableColor:nil];
            [agreeButton setTitle:@"Я пойду" forState:UIControlStateNormal];
        } else  {
            [agreeButton setStyle:[UIColor colorWithRed:110.0/255.0 green:206.0/255.0 blue:15.0/255.0 alpha:1.0] andBottomColor:[UIColor colorWithRed:110.0/255.0 green:206.0/255.0 blue:15.0/255.0 alpha:1.0]];
            [agreeButton setLabelTextShadow:CGSizeMake(0.5, 1) normalColor:nil highlightedColor:[UIColor greenColor] disableColor:nil];
            [agreeButton setTitle:@"Я иду" forState:UIControlStateNormal];
        }
    } else  {
        agreeButton.hidden = YES;
        labelIfDisable.hidden = NO;
        
        CGSize sizeGroup = [@"Мероприятие окончено" sizeWithFont:labelIfDisable.font
                                                  constrainedToSize:CGSizeMake(320-(maxDateBlock+35), 50)
                                                      lineBreakMode:NSLineBreakByWordWrapping];
        labelIfDisable.text = @"Мероприятие окончено";
        NSLog(@"%f", labelTitle.frame.size.height);
        if(labelTitle.frame.size.height > 25)
            labelIfDisable.frame = CGRectMake(maxDateBlock+35, labelGroup.frame.origin.y+labelGroup.frame.size.height+10, 320-(maxDateBlock+35), sizeGroup.height);
        else
            labelIfDisable.frame = CGRectMake(maxDateBlock+35, labelCity.frame.origin.y + roundf((labelCity.frame.size.height-sizeGroup.height)/2), 320-(maxDateBlock+35), sizeGroup.height);
    }
}

-(void) onSbscrClick:(id)sender
{
    agreeButton.enabled = NO;
    agreeButton.userInteractionEnabled = NO;
    
    [[TRMeetingManager client] subscribeMeetingByID:eventItem.objectId successOperation:^(LRRestyResponse *response) {
        if(eventItem.isAccept == NO)
        {
            eventItem.isAccept = YES;
            
            [agreeButton setStyle:[UIColor colorWithRed:110.0/255.0 green:206.0/255.0 blue:15.0/255.0 alpha:1.0] andBottomColor:[UIColor colorWithRed:110.0/255.0 green:206.0/255.0 blue:15.0/255.0 alpha:1.0]];
            [agreeButton setLabelTextShadow:CGSizeMake(0.5, 1) normalColor:nil highlightedColor:[UIColor greenColor] disableColor:nil];
            [agreeButton setTitle:@"Я иду" forState:UIControlStateNormal];
        } else  {
            eventItem.isAccept = NO;
            
            [agreeButton setStyle:[UIColor colorWithRed:77.0/255.0 green:112.0/255.0 blue:255.0/255.0 alpha:1.0] andBottomColor:[UIColor colorWithRed:77.0/255.0 green:112.0/255.0 blue:255.0/255.0 alpha:1.0]];
            [agreeButton setLabelTextShadow:CGSizeMake(0.5, 1) normalColor:nil highlightedColor:[UIColor blueColor] disableColor:nil];
            [agreeButton setTitle:@"Я пойду" forState:UIControlStateNormal];
        }
        agreeButton.enabled = YES;
        agreeButton.userInteractionEnabled = YES;
    } andFailedOperation:^(LRRestyResponse *response) {
        agreeButton.enabled = YES;
        agreeButton.userInteractionEnabled = YES;
    }];
}

-(NSInteger) getMaxWidthFromStrings:(TREventModel*)meetingObject
{
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"dd.MM.yyyy HH:mm"];
    NSDate *myDate = [df dateFromString: meetingObject.start_date];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MMMM"];
    
    CGSize sizeMonth = [[dateFormatter stringFromDate:myDate] sizeWithFont:labelMonth.font
                          constrainedToSize:CGSizeMake(FLT_MAX, FLT_MAX)
                              lineBreakMode:NSLineBreakByWordWrapping];
    CGSize sizeCity = [meetingObject.place sizeWithFont:labelCity.font
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

-(CGRect) changeXInFrame:(CGRect)frame byX:(NSInteger)coord
{
    return CGRectMake(coord, frame.origin.y, frame.size.width, frame.size.height);
}

@end
