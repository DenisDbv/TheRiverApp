//
//  TRSearchPUsersCell.m
//  TheRiverApp
//
//  Created by DenisDbv on 27.09.13.
//  Copyright (c) 2013 axbx. All rights reserved.
//

#import "TRSearchPUsersCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <UIActivityIndicator-for-SDWebImage/UIImageView+UIActivityIndicatorForSDWebImage.h>
#import "UIImage+Resize.h"

@implementation TRSearchPUsersCell
{
    UILabel *cityLabel;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.textLabel.font = [UIFont fontWithName:@"HypatiaSansPro-Bold" size:16];
        
        self.detailTextLabel.font = [UIFont fontWithName:@"HypatiaSansPro-Regular" size:14];
        self.detailTextLabel.textColor = [UIColor lightGrayColor];
        
        cityLabel = [[UILabel alloc] init];
        cityLabel.backgroundColor = [UIColor clearColor];
        cityLabel.font = [UIFont fontWithName:@"HypatiaSansPro-Bold" size:14];
        cityLabel.textColor = [UIColor lightGrayColor];
        cityLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:cityLabel];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

-(void) layoutSubviews
{
    [super layoutSubviews];
    
    self.imageView.frame = CGRectOffset(self.imageView.frame, 10, 0);
    
    self.textLabel.frame = CGRectOffset(self.textLabel.frame, 10, 0);
    self.detailTextLabel.frame = CGRectOffset(self.detailTextLabel.frame, 10, 0);
    
    cityLabel.frame = CGRectMake((self.detailTextLabel.frame.origin.x+self.detailTextLabel.frame.size.width)+5,
                                 self.detailTextLabel.frame.origin.y,
                                 320 - (self.detailTextLabel.frame.origin.x+self.detailTextLabel.frame.size.width) - 10,
                                 self.detailTextLabel.bounds.size.height);
}

-(void) reloadWithModel:(TRUserInfoModel*)userInfo isShowCity:(BOOL)showCity
{
    if(showCity)
        cityLabel.text = userInfo.city;
    else
        cityLabel.text = @"";
    
    self.textLabel.text = [NSString stringWithFormat:@"%@ %@", userInfo.first_name, userInfo.last_name];
    
    NSString *logoURLString = [SERVER_HOSTNAME stringByAppendingString:userInfo.logo];
    
    [self.imageView setImage:[UIImage imageNamed:@"avatar_placeholder.png"]];
    
    [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:[NSURL URLWithString:logoURLString]
                                                          options:SDWebImageDownloaderUseNSURLCache progress:nil
                                                        completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished)
     {
         
         if(image != nil)
         {
             UIImage *logoImageTest = [image resizedImageWithContentMode:UIViewContentModeScaleAspectFill bounds:CGSizeMake(59, 59) interpolationQuality:kCGInterpolationHigh];
             logoImageTest = [logoImageTest croppedImage:CGRectMake(0, 0, 59, 59)];
             [self.imageView setImage:logoImageTest];
         }
     }];
    
    NSMutableArray *hightResolution = [[NSMutableArray alloc] init];
    for(TRUserResolutionModel *userResolution in userInfo.interests)
    {
        [hightResolution addObject:userResolution.name];
    }
    self.detailTextLabel.text = [hightResolution componentsJoinedByString:@", "];
}

@end
