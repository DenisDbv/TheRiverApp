//
//  TRBusinessNewItemCell.m
//  TheRiverApp
//
//  Created by DenisDbv on 14.10.13.
//  Copyright (c) 2013 axbx. All rights reserved.
//

#import "TRBusinessNewItemCell.h"
#import <QuartzCore/QuartzCore.h>
#import "UIImage+Resize.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <UIActivityIndicator-for-SDWebImage/UIImageView+UIActivityIndicatorForSDWebImage.h>

@implementation TRBusinessNewItemCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initialized];
    }
    return self;
}

-(void) awakeFromNib
{
    [self initialized];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void) initialized
{
    /*self.imageView.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    self.imageView.layer.shadowOffset = CGSizeMake(1, 1);
    self.imageView.layer.shadowOpacity = 0.5;
    self.imageView.layer.shadowRadius = 1.0;
    self.imageView.clipsToBounds = NO;*/
    
    self.userLogo.layer.borderWidth = 0;
    self.userLogo.layer.borderColor = [UIColor whiteColor].CGColor;
    self.userLogo.layer.cornerRadius = CGRectGetHeight(self.userLogo.bounds) / 2;
    self.userLogo.clipsToBounds = YES;
    
    self.businessName.highlightedTextColor = [UIColor whiteColor];
    self.businessName.font = [UIFont fontWithName:@"HypatiaSansPro-Bold" size:16.0];
    self.businessAbout.highlightedTextColor = [UIColor whiteColor];
}

/*-(void) setFrame:(CGRect)frame
{
    if(IS_OS_7_OR_LATER)    {
        float inset = 5.0f;
        frame.origin.x += inset;
        frame.size.width -= 2 * inset;
    } else  {
        float inset = -3.0f;
        frame.origin.x += inset;
        frame.size.width -= 2 * inset;
    }
    
    [super setFrame:frame];
}*/

/*-(void) layoutSubviews
{
    [super layoutSubviews];
    
    NSInteger xOffset = 0;
    
    if(IS_OS_7_OR_LATER)
        xOffset = -20;
    
    self.imageView.frame = CGRectMake(self.imageView.frame.origin.x+xOffset,
                                      self.imageView.frame.origin.y,
                                      self.imageView.frame.size.width,
                                      self.imageView.frame.size.height);
}*/

-(void) reloadWithBusinessModel:(TRBusinessModel*)businessObject
{
    if(businessObject.logo_cell.length != 0) {
        NSString *logoURLString = [SERVER_HOSTNAME stringByAppendingString:businessObject.logo_cell];
        
        UIImage *imgLogoCellFromDisk = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:logoURLString];
        if(imgLogoCellFromDisk == nil) {
            [self.businessLogo setImageWithURL:[NSURL URLWithString:logoURLString] placeholderImage:[UIImage imageNamed:@"business_logo.png"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
                if(image != nil)
                {
                    /*image = [image resizedImageWithContentMode:UIViewContentModeScaleAspectFill bounds:CGSizeMake(85, 85) interpolationQuality:kCGInterpolationHigh];
                     image = [image croppedImage:CGRectMake(0, 0, 85, 85)];
                     [self.imageView setImage:image];*/
                    
                    [[SDImageCache sharedImageCache] storeImage:image forKey:logoURLString toDisk:YES];
                }
            } usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        } else  {
            //UIImage *image = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:logoURLString];
            /*image = [image resizedImageWithContentMode:UIViewContentModeScaleAspectFill bounds:CGSizeMake(85, 85) interpolationQuality:kCGInterpolationHigh];
            image = [image croppedImage:CGRectMake(0, 0, 85, 85)];*/
            [self.businessLogo setImage: imgLogoCellFromDisk];
        }
    }   else    {
        [self.businessLogo setImage:[UIImage imageNamed:@"business_logo.png"]];
    }
    
    if(businessObject.user_logo.length != 0) {
        NSString *logoURLString = [SERVER_HOSTNAME stringByAppendingString:businessObject.user_logo];
        
        UIImage *imgLogoCellFromDisk = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:logoURLString];
        //NSLog(@"%@ %@ %@", businessObject.first_name, businessObject.last_name, NSStringFromCGSize(imgLogoCellFromDisk.size));
        if(imgLogoCellFromDisk == nil) {
            [self.userLogo setImageWithURL:[NSURL URLWithString:logoURLString] placeholderImage:[UIImage imageNamed:@"userpic.png"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
                if(image != nil)
                {
                    //image = [image resizedImageWithContentMode:UIViewContentModeScaleAspe ctFill bounds:CGSizeMake(20, 20) interpolationQuality:kCGInterpolationHigh];
                    //image = [image croppedImage:CGRectMake(0, 0, 20, 20)];
                    //[self.userLogo setImage:image];
                    
                    [[SDImageCache sharedImageCache] storeImage:image forKey:logoURLString toDisk:YES];
                }
            }];
        } else  {
            //UIImage *image = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:logoURLString];
            //image = [image resizedImageWithContentMode:UIViewContentModeScaleAspectFill bounds:CGSizeMake(20, 20) interpolationQuality:kCGInterpolationHigh];
            //image = [image croppedImage:CGRectMake(0, 0, 20, 20)];
            [self.userLogo setImage:imgLogoCellFromDisk];
        }
    } else    {
        [self.userLogo setImage:[UIImage imageNamed:@"userpic.png"]];
    }
    
    self.businessName.text = businessObject.company_name;
    self.businessAbout.text = businessObject.about;
}

@end
