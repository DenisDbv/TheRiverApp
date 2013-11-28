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
        [self.textLabel setTextColor:[UIColor blackColor]];
        [self.textLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:19]];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void) layoutSubviews
{
    [super layoutSubviews];
    
    NSInteger xOffset = 0;
    
    if(IS_OS_7_OR_LATER)
        xOffset = -20;
    
    self.imageView.frame = CGRectMake(self.imageView.frame.origin.x+xOffset,
                                      self.imageView.frame.origin.y,
                                      59,
                                      59);
    
    self.textLabel.frame = CGRectMake(self.textLabel.frame.origin.x+xOffset,
                                      self.textLabel.frame.origin.y,
                                      self.textLabel.frame.size.width-xOffset,
                                      self.textLabel.frame.size.height);
}

-(void) reloadWithModel:(TRUserInfoModel*)userInfo
{
    self.textLabel.text = [NSString stringWithFormat:@"%@ %@", userInfo.first_name, userInfo.last_name];
    
    if(userInfo.logo_cell.length > 0)   {
        NSString *logoURLString = [SERVER_HOSTNAME stringByAppendingString:userInfo.logo_cell];
        
        UIImage *img = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:logoURLString];
        if(img == nil) {
            [self.imageView setImageWithURL:[NSURL URLWithString:logoURLString] placeholderImage:[UIImage imageNamed:@"rightbar_contact_placeholder.png"]
                                  completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
                [[SDImageCache sharedImageCache] storeImage:image forKey:logoURLString toDisk:YES];
            } usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        } else  {
            [self.imageView setImage: img];
        }
    } else  {
        [self.imageView setImage:[UIImage imageNamed:@"rightbar_contact_placeholder.png"]];
    }
    
    NSMutableArray *hightResolution = [[NSMutableArray alloc] init];
    for(TRUserResolutionModel *userResolution in userInfo.interests)
    {
        [hightResolution addObject:userResolution.name];
    }
    self.detailTextLabel.text = [hightResolution componentsJoinedByString:@", "];
}

@end
