//
//  TRMeetLogoBox.m
//  TheRiverApp
//
//  Created by DenisDbv on 14.09.13.
//  Copyright (c) 2013 axbx. All rights reserved.
//

#import "TRMeetLogoBox.h"
#import <SSToolkit/SSToolkit.h>
#import "UIImage+Resize.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <UIActivityIndicator-for-SDWebImage/UIImageView+UIActivityIndicatorForSDWebImage.h>

@implementation TRMeetLogoBox
{
    UILabel *dayLabel;
    UILabel *monthLabel;
    UILabel *timeLabel;
    
    SSGradientView *layerView;
}

- (void)setup {
    
    self.backgroundColor = [UIColor whiteColor];
    
    self.leftMargin = self.rightMargin = 10;
    
}

+(MGBox *) initBox:(CGSize)bounds withMeetData:(TREventModel *)meetObject
{
    TRMeetLogoBox *box = [TRMeetLogoBox boxWithSize: CGSizeMake(bounds.width, 210)];
    box.meetingData = meetObject;
    
    [box showLogo];
    [box showInfoBlock];
    
    return box;
}

-(void) showLogo
{
    /*UIImage *image = [UIImage imageNamed: self.meetingData.logo];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    
    if(image.size.width > self.bounds.size.width)
        imageView.size = self.bounds.size;
    else
        imageView.frame = CGRectMake((self.bounds.size.width-image.size.width)/2,
                                     0,
                                     image.size.width, image.size.height);
    
    imageView.alpha = 0;
    imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self addSubview:imageView];
    
    [UIView animateWithDuration:0.1 animations:^{
        imageView.alpha = 1;
    }];*/
    
    __block UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.bounds];
    imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self addSubview:imageView];
    
    if(self.meetingData.logo.length != 0) {
        NSString *logoURLString = [SERVER_HOSTNAME stringByAppendingString:self.meetingData.logo];
        
        [imageView setImageWithURL:[NSURL URLWithString:logoURLString] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
            if(image != nil)
            {
                UIImage *logoImageTest = [image resizedImageWithContentMode:UIViewContentModeScaleAspectFill bounds:CGSizeMake(self.bounds.size.width, self.bounds.size.height) interpolationQuality:kCGInterpolationHigh];
                logoImageTest = [logoImageTest croppedImage:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
                [imageView setImage:logoImageTest];
            }
        } usingActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    }
    
    layerView = [[SSGradientView alloc] initWithFrame:self.bounds];
    layerView.backgroundColor = [UIColor clearColor];
    [self addSubview:layerView];
}

-(void) layoutSubviews
{
    [super layoutSubviews];
    
    layerView.bottomColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
    layerView.topColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    [layerView layoutSubviews];
}

-(void) showInfoBlock
{
    dayLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    dayLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:30];
    dayLabel.textColor = [UIColor whiteColor];
    dayLabel.textAlignment = NSTextAlignmentCenter;
    dayLabel.backgroundColor = [UIColor clearColor];
    
    monthLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    monthLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:15];
    monthLabel.textColor = [UIColor whiteColor];
    monthLabel.textAlignment = NSTextAlignmentCenter;
    monthLabel.backgroundColor = [UIColor clearColor];
    
    timeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    timeLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:15];
    timeLabel.textColor = [UIColor whiteColor];
    timeLabel.textAlignment = NSTextAlignmentCenter;
    timeLabel.backgroundColor = [UIColor clearColor];
    
    NSInteger maxDateBlock = [self getMaxWidthFromStrings:self.meetingData] + 4;
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"dd.MM.yyyy HH:mm"];
    NSDate *myDate = [df dateFromString: self.meetingData.start_date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd"];
    
    [self changeSizeLabel:dayLabel atString:[dateFormatter stringFromDate:myDate]];
    dayLabel.frame = [self changeWidthInFrame:dayLabel.frame byWidth:maxDateBlock];
    
    [dateFormatter setDateFormat:@"MMMM"];
    [self changeSizeLabel:monthLabel atString:[dateFormatter stringFromDate:myDate]];
    monthLabel.frame = [self changeWidthInFrame:monthLabel.frame byWidth:maxDateBlock];
    monthLabel.frame = [self changeYInFrame:monthLabel.frame byY:dayLabel.frame.origin.y+dayLabel.frame.size.height];
    
    [dateFormatter setDateFormat:@"HH:mm"];
    [self changeSizeLabel:timeLabel atString:[dateFormatter stringFromDate:myDate]];
    timeLabel.frame = [self changeWidthInFrame:timeLabel.frame byWidth:maxDateBlock];
    timeLabel.frame = [self changeYInFrame:timeLabel.frame byY:monthLabel.frame.origin.y+monthLabel.frame.size.height];

    UIView *infoView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, maxDateBlock,
                                                                CGRectGetHeight(dayLabel.frame)+CGRectGetHeight(monthLabel.frame)+CGRectGetHeight(timeLabel.frame))];
    infoView.backgroundColor = [UIColor clearColor];
    infoView.autoresizesSubviews = NO;
    //infoView.alpha = 1.0;
    
    [infoView addSubview:dayLabel];
    [infoView addSubview:monthLabel];
    [infoView addSubview:timeLabel];
    
    infoView.frame = CGRectOffset(infoView.frame, 5.0, self.frame.size.height-infoView.frame.size.height-5);
    
    [self addSubview:infoView];
}

-(NSInteger) getMaxWidthFromStrings:(TREventModel*)meetingObject
{
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"dd.MM.yyyy HH:mm"];
    NSDate *myDate = [df dateFromString: meetingObject.start_date];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MMMM"];
    
    CGSize sizeMonth = [[dateFormatter stringFromDate:myDate] sizeWithFont:monthLabel.font
                                              constrainedToSize:CGSizeMake(FLT_MAX, FLT_MAX)
                                                  lineBreakMode:NSLineBreakByWordWrapping];
    
    [dateFormatter setDateFormat:@"HH:mm"];
    CGSize sizeTime = [[dateFormatter stringFromDate:myDate] sizeWithFont:timeLabel.font
                                            constrainedToSize:CGSizeMake(FLT_MAX, FLT_MAX)
                                                lineBreakMode:NSLineBreakByWordWrapping];
    
    return MAX(sizeMonth.width, sizeTime.width);
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
