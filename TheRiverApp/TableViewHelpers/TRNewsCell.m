//
//  TRNewsCell.m
//  TheRiverApp
//
//  Created by DenisDbv on 14.11.13.
//  Copyright (c) 2013 axbx. All rights reserved.
//

#import "TRNewsCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <UIActivityIndicator-for-SDWebImage/UIImageView+UIActivityIndicatorForSDWebImage.h>
#import "UIImage+Resize.h"

@implementation TRNewsCell
@synthesize newsLogo, newsTitle, newsTime, newsDesc;

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

    // Configure the view for the selected state
}

-(void) reloadWithNewsItem:(TRNewsItem*)newsItem
{
    newsTitle.highlightedTextColor = [UIColor whiteColor];
    newsTime.highlightedTextColor = [UIColor whiteColor];
    newsDesc.highlightedTextColor = [UIColor whiteColor];
    
    newsTitle.text = newsItem.title;
    CGSize size = [newsTitle.text sizeWithFont:newsTitle.font constrainedToSize:CGSizeMake(231.0, FLT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
    newsTitle.frame = CGRectMake(newsTitle.frame.origin.x, newsTitle.frame.origin.y, newsTitle.frame.size.width, (floor(size.height) > newsTitle.frame.size.height)?35.0:floor(size.height));
    //newsTitle.backgroundColor = [UIColor redColor];
    //NSLog(@"=>%@", NSStringFromCGSize(size));
    
    newsTime.text = newsItem.date_create;
    newsTime.frame = CGRectMake(newsTime.frame.origin.x, newsTitle.frame.origin.y+newsTitle.frame.size.height+3.0, newsTime.frame.size.width, newsTime.frame.size.height);
    
    newsDesc.text = newsItem.text;
    size = [newsDesc.text sizeWithFont:newsTitle.font constrainedToSize:CGSizeMake(231.0, FLT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
    newsDesc.frame = CGRectMake(newsDesc.frame.origin.x, newsTime.frame.origin.y+newsTime.frame.size.height+3.0, newsDesc.frame.size.width, (floor(size.height) > newsTitle.frame.size.height)?54.0:floor(size.height));
    //newsDesc.backgroundColor = [UIColor yellowColor];
    
    if(newsItem.logo.length > 0)   {
        NSString *logoURLString = [@"http://kostum5.ru/" stringByAppendingString:newsItem.logo];
    
        UIImage *img = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:logoURLString];
        if(img == nil) {
            [self.newsLogo setImageWithURL:[NSURL URLWithString:logoURLString] placeholderImage:[UIImage imageNamed:@"rightbar_contact_placeholder.png"]
                                  completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
                                      [[SDImageCache sharedImageCache] storeImage:image forKey:logoURLString toDisk:YES];
                                  } usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        } else  {
            [self.newsLogo setImage: img];
        }
    } else  {
        [self.newsLogo setImage:[UIImage imageNamed:@"rightbar_contact_placeholder.png"]];
    }
}

-(CGFloat) getCellHeight:(TRNewsItem*)newsItem
{
    CGFloat maxHeight = 0;
    
    CGSize size = [newsItem.title sizeWithFont:[UIFont fontWithName:@"HelveticaNeue-Medium" size:14.0] constrainedToSize:CGSizeMake(231.0, FLT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
    maxHeight = (floor(size.height) > 35.0)?35.0:floor(size.height);
    
    size = [newsItem.text sizeWithFont:[UIFont fontWithName:@"HelveticaNeue" size:13.0] constrainedToSize:CGSizeMake(231.0, FLT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
    maxHeight += (floor(size.height) > 54.0)?54.0:floor(size.height);

    maxHeight += 6 + 30 + 17;
    
    return maxHeight;
}

@end
