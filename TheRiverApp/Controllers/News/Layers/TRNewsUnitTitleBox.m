//
//  TRBusinessTitleBox.m
//  TheRiverApp
//
//  Created by DenisDbv on 10.09.13.
//  Copyright (c) 2013 axbx. All rights reserved.
//

#import "TRNewsUnitTitleBox.h"
#import <MGBox2/MGLineStyled.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import <UIActivityIndicator-for-SDWebImage/UIImageView+UIActivityIndicatorForSDWebImage.h>
#import "TRUserProfileController.h"

@implementation TRNewsUnitTitleBox

- (void)setup {
    
    self.backgroundColor = [UIColor whiteColor];
    
    self.leftMargin = self.rightMargin = 9;
}

+(TRNewsUnitTitleBox *)initBox:(CGSize)bounds withNewsData:(TRNewsItem *)newsItem
{
    TRNewsUnitTitleBox *box = [TRNewsUnitTitleBox boxWithSize: CGSizeMake(bounds.width, 10)];
    box.newsItem = newsItem;
    
    box.contentLayoutMode = MGLayoutTableStyle;
    
    MGLineStyled *titleLine = [MGLineStyled lineWithMultilineLeft:newsItem.title right:nil width:300.0 minHeight:10];
    titleLine.backgroundColor = [UIColor clearColor];
    titleLine.topMargin = 20;
    titleLine.leftPadding = titleLine.rightPadding = 0;
    titleLine.borderStyle = MGBorderNone;
    titleLine.font = [UIFont fontWithName:@"HypatiaSansPro-Bold" size:23];
    [box.boxes addObject:titleLine];
    
    MGLineStyled *aboutLine = [MGLineStyled lineWithMultilineLeft:[box time:newsItem.date_create] right:nil width:300 minHeight:10];
    aboutLine.backgroundColor = [UIColor clearColor];
    aboutLine.topMargin = 0;
    aboutLine.leftPadding = aboutLine.rightPadding = 0;
    aboutLine.borderStyle = MGBorderNone;
    aboutLine.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:14];
    [box.boxes addObject:aboutLine];
    
    return box;
}

-(NSString*) time:(NSString*)time
{
    //time = @"2013-11-14 15:53:47";
    //NSLog(@"%@", time);
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
    [dateFormatter setTimeZone:timeZone];
    [dateFormatter setDateFormat:@"yyyy.MM.dd HH:mm:ss"];
    
    //NSString *dateString = [dateFormatter stringFromDate:[NSDate date]];
    
    NSDate *date = [dateFormatter dateFromString:time];
    //NSLog(@"->%@", [date description]);
    
    dateFormatter = [[NSDateFormatter alloc] init];
    timeZone = [NSTimeZone localTimeZone];
    [dateFormatter setTimeZone:timeZone];
    [dateFormatter setDateFormat:@"dd.MM.YYYY, HH:mm"];
    return [dateFormatter stringFromDate:date];
}

@end
