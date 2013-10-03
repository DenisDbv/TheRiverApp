//
//  TRContactCell.m
//  TheRiverApp
//
//  Created by DenisDbv on 02.10.13.
//  Copyright (c) 2013 axbx. All rights reserved.
//

#import "TRContactCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <UIActivityIndicator-for-SDWebImage/UIImageView+UIActivityIndicatorForSDWebImage.h>
#import "UIImage+Resize.h"

@implementation TRContactCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setBackgroundColor:[UIColor clearColor]];
        [self.textLabel setTextColor:[UIColor whiteColor]];
        [self.textLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:19]];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void) reloadWithModel:(TRUserInfoModel*)userInfo
{
    self.textLabel.text = [NSString stringWithFormat:@"%@ %@", userInfo.first_name, userInfo.last_name];
    
    NSString *logoURLString = [SERVER_HOSTNAME stringByAppendingString:userInfo.logo];
    
    [self.imageView setImage:[UIImage imageNamed:@"avatar_placeholder.png"]];
    
    if([[SDImageCache sharedImageCache] imageFromDiskCacheForKey:[logoURLString stringByAppendingString:@"_small"]] == nil) {
        [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:[NSURL URLWithString:logoURLString]
                                                              options:SDWebImageDownloaderUseNSURLCache progress:nil
                                                            completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished)
         {
             
             if(image != nil)
             {
                 UIImage *logoImageTest = [image resizedImageWithContentMode:UIViewContentModeScaleAspectFill bounds:CGSizeMake(59, 59) interpolationQuality:kCGInterpolationHigh];
                 logoImageTest = [logoImageTest croppedImage:CGRectMake(0, 0, 59, 59)];
                 [self.imageView setImage:logoImageTest];
                 
                 [[SDImageCache sharedImageCache] storeImage:logoImageTest forKey:[logoURLString stringByAppendingString:@"_small"] toDisk:YES];
             }
         }];
    } else  {
        [self.imageView setImage:[[SDImageCache sharedImageCache] imageFromDiskCacheForKey:[logoURLString stringByAppendingString:@"_small"]]];
    }
    
    NSMutableArray *hightResolution = [[NSMutableArray alloc] init];
    for(TRUserResolutionModel *userResolution in userInfo.interests)
    {
        [hightResolution addObject:userResolution.name];
    }
    self.detailTextLabel.text = [hightResolution componentsJoinedByString:@", "];
}

@end
