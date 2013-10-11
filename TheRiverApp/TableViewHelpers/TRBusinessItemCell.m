//
//  TRBusinessItemCell.m
//  TheRiverApp
//
//  Created by DenisDbv on 09.09.13.
//  Copyright (c) 2013 axbx. All rights reserved.
//

#import "TRBusinessItemCell.h"
#import <QuartzCore/QuartzCore.h>
#import "UIImage+Resize.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <UIActivityIndicator-for-SDWebImage/UIImageView+UIActivityIndicatorForSDWebImage.h>

@implementation TRBusinessItemCell

@synthesize logo, title, subTitle, layerView, layerView2, layerShortTitleLabel, layerAfterLabel;

-(void) reloadWithBusinessModel:(TRBusinessModel*)businessObject
{
    if(businessObject.logo_cell.length != 0) {
        NSString *logoURLString = [SERVER_HOSTNAME stringByAppendingString:businessObject.logo_cell];
        
        if([[SDImageCache sharedImageCache] imageFromDiskCacheForKey:logoURLString] == nil) {
            [logo setImageWithURL:[NSURL URLWithString:logoURLString] placeholderImage:[UIImage new] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
                if(image != nil)
                {
                    /*UIImage *logoImageTest = [image resizedImageWithContentMode:UIViewContentModeScaleAspectFill bounds:CGSizeMake(300, 180) interpolationQuality:kCGInterpolationHigh];
                    logoImageTest = [logoImageTest croppedImage:CGRectMake(0, 0, 300, 180)];
                    [logo setImage:logoImageTest];*/
                    
                    [[SDImageCache sharedImageCache] storeImage:image forKey:logoURLString toDisk:YES];
                }
            } usingActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        } else  {
            [logo setImage:[[SDImageCache sharedImageCache] imageFromDiskCacheForKey:logoURLString]];
        }
    }
    
    title.text = businessObject.company_name;
    subTitle.text = [NSString stringWithFormat:@"%@ %@ %@, %@", businessObject.first_name, businessObject.last_name, businessObject.age, businessObject.city];
    
    [title sizeToFit];
    CGSize size = [title.text sizeWithFont: title.font
                              constrainedToSize: CGSizeMake(290.0, 50)
                                  lineBreakMode: NSLineBreakByWordWrapping ];
    if(size.height == 0) size.height = 20;
    
    title.frame = CGRectMake(5.0, 7.0,
                            size.width, size.height);
    
    [subTitle sizeToFit];
    subTitle.frame = CGRectMake(subTitle.frame.origin.x,
                                       title.frame.origin.y+title.frame.size.height+10,
                                       subTitle.bounds.size.width,
                                       subTitle.bounds.size.height);
    
    logo.frame = CGRectMake(-1, subTitle.frame.origin.y+subTitle.frame.size.height+5, 302, 180);
    layerView.frame = logo.frame;
    layerView2.frame = logo.frame;
    
    [self showBusinessTitle:businessObject];
}

-(void)awakeFromNib
{
    [self initialized];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initialized];
    }
    return self;
}

-(void) setFrame:(CGRect)frame
{
    if(IS_OS_7_OR_LATER)    {
        float inset = 10.0f;
        frame.origin.x += inset;
        frame.size.width -= 2 * inset;
    }
    
    [super setFrame:frame];
}

-(void) layoutSubviews
{
    [super layoutSubviews];
    
    layerView.bottomColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    layerView.topColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    
    //layerView2.bottomColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    //layerView2.topColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
    
    [layerView layoutSubviews];
    //[layerView2 layoutSubviews];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

-(void) initialized
{
    title.font = [UIFont fontWithName:@"HypatiaSansPro-Bold" size:19];
    
    layerShortTitleLabel.textColor = [UIColor whiteColor];
    layerShortTitleLabel.font = [UIFont fontWithName:@"HypatiaSansPro-Regular" size:20];
    layerShortTitleLabel.numberOfLines = 0;
    layerShortTitleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    layerShortTitleLabel.layer.shadowColor = [UIColor blackColor].CGColor;
    layerShortTitleLabel.layer.shadowOffset = CGSizeMake(0, 1);
    layerShortTitleLabel.layer.shadowRadius = 1;
    layerShortTitleLabel.layer.shadowOpacity = 0.2f;
    
    layerAfterLabel.backgroundColor = [UIColor clearColor];
    layerAfterLabel.textColor = [UIColor whiteColor];
    layerAfterLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:15];
    layerAfterLabel.numberOfLines = 1;
}

-(void) showBusinessTitle:(TRBusinessModel*)businessObject
{
    layerAfterLabel.text = [NSString stringWithFormat:@"Оборот в месяц: %@ р", businessObject.profit];
    [layerAfterLabel sizeToFit];
    layerAfterLabel.frame = CGRectMake(10,
                                       layerView.frame.size.height - layerAfterLabel.frame.size.height - 10,
                                       layerAfterLabel.frame.size.width, layerAfterLabel.frame.size.height);
    
    layerShortTitleLabel.text = businessObject.about;
    CGSize size = [layerShortTitleLabel.text sizeWithFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:20]
                                        constrainedToSize:CGSizeMake(280.0, FLT_MAX)
                                            lineBreakMode:NSLineBreakByWordWrapping];
    layerShortTitleLabel.frame = CGRectMake(10.0,
                                            layerAfterLabel.frame.origin.y - size.height,
                                            size.width, size.height);
}

/*-(void) showBusinessTitle:(TRBusinessModel*)businessObject
{
    layerAfterLabel.text = [NSString stringWithFormat:@"Стало: %@", businessObject.businessAfterTitle];
    [layerAfterLabel sizeToFit];
    layerAfterLabel.frame = CGRectMake(10,
                                       layerView.frame.size.height - layerAfterLabel.frame.size.height - 10,
                                       layerAfterLabel.frame.size.width, layerAfterLabel.frame.size.height);
    
    layerBeforeLabel.text = [NSString stringWithFormat:@"Было: %@", businessObject.businessBeforeTitle];
    [layerBeforeLabel sizeToFit];
    layerBeforeLabel.frame = CGRectMake(10,
                                        layerAfterLabel.frame.origin.y - layerBeforeLabel.frame.size.height,
                                        layerBeforeLabel.frame.size.width, layerBeforeLabel.frame.size.height);
    
    layerShortTitleLabel.text = businessObject.shortBusinessTitle;
    CGSize size = [layerShortTitleLabel.text sizeWithFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:20]
                                        constrainedToSize:CGSizeMake(280.0, FLT_MAX)
                                            lineBreakMode:NSLineBreakByWordWrapping];
    layerShortTitleLabel.frame = CGRectMake(10.0,
                                            layerBeforeLabel.frame.origin.y - size.height,
                                            size.width, size.height);
}*/

@end
