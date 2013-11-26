//
//  TRMindItemCell.m
//  TheRiverApp
//
//  Created by DenisDbv on 08.09.13.
//  Copyright (c) 2013 axbx. All rights reserved.
//

#import "TRMindItemCell.h"
#import <QuartzCore/QuartzCore.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import <UIActivityIndicator-for-SDWebImage/UIImageView+UIActivityIndicatorForSDWebImage.h>
#import "UIImage+Resize.h"

@implementation TRMindItemCell

@synthesize logo, titleLabel, descLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initialize];
    }
    return self;
}

-(void) awakeFromNib
{
    [self initialize];
}

-(void) initialize
{
    titleLabel.font = [UIFont fontWithName:@"HypatiaSansPro-Bold" size:16];
}

-(void) reloadWithMindModel:(TRMindItem*)mindObject
{
    titleLabel.highlightedTextColor = [UIColor whiteColor];
    descLabel.highlightedTextColor = [UIColor whiteColor];
    
    titleLabel.text = mindObject.title;
    CGSize size = [titleLabel.text sizeWithFont:titleLabel.font constrainedToSize:CGSizeMake(231.0, FLT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
    titleLabel.frame = CGRectMake(titleLabel.frame.origin.x, titleLabel.frame.origin.y, titleLabel.frame.size.width, (floor(size.height) > titleLabel.frame.size.height)?44.0:size.height);
    
    descLabel.text = mindObject.text;
    size = [descLabel.text sizeWithFont:descLabel.font constrainedToSize:CGSizeMake(231.0, FLT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
    descLabel.frame = CGRectMake(descLabel.frame.origin.x, titleLabel.frame.origin.y+titleLabel.frame.size.height+3.0, descLabel.frame.size.width, (floor(size.height) > descLabel.frame.size.height)?54.0:floor(size.height));
    
    if(mindObject.logo.length > 0)   {
        NSString *logoURLString = [@"http://kostum5.ru/" stringByAppendingString:mindObject.logo];
        
        UIImage *img = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:logoURLString];
        if(img == nil) {
            [self.logo setImageWithURL:[NSURL URLWithString:logoURLString] placeholderImage:[UIImage imageNamed:@"rightbar_contact_placeholder.png"]
                                 completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
                                     [[SDImageCache sharedImageCache] storeImage:image forKey:logoURLString toDisk:YES];
                                 } usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        } else  {
            [self.logo setImage: img];
        }
    } else  {
        [self.logo setImage:[UIImage imageNamed:@"rightbar_contact_placeholder.png"]];
    }
}

-(CGFloat) getCellHeight:(TRMindItem*)mindItem
{
    CGFloat maxHeight = 0;
    
    CGSize size = [mindItem.title sizeWithFont:[UIFont fontWithName:@"HypatiaSansPro-Bold" size:16.0] constrainedToSize:CGSizeMake(231.0, FLT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
    maxHeight = (floor(size.height) > 44.0)?44.0:floor(size.height);
    
    size = [mindItem.text sizeWithFont:[UIFont fontWithName:@"HelveticaNeue" size:13.0] constrainedToSize:CGSizeMake(231.0, FLT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
    maxHeight += (floor(size.height) > 54.0)?54.0:floor(size.height);
    
    if(maxHeight < 50) maxHeight = 50;
    
    maxHeight += 3 + 34;
    
    return maxHeight;
}

/*-(void) layoutSubviews
{
    [super layoutSubviews];
    
    float table_width = 0;
    float table_height = 0;
    
    UITableView *table = [self getTableView:self.contentView];
    if(table != nil)
    {
        table_width = table.bounds.size.width;
        table_height = table.bounds.size.height;
    }
    
    CGRect frame = self.contentView.frame;
    frame.origin.x = 5;
    frame.size.width = table_width - 10;
    self.contentView.frame = frame;
    
    self.backgroundView = [[UIView alloc] initWithFrame:frame];
    self.backgroundView.backgroundColor = [UIColor whiteColor];
    self.selectedBackgroundView = [[UIView alloc] initWithFrame:frame];
    self.selectedBackgroundView.backgroundColor = [UIColor blueColor];
}

-(UITableView*)getTableView:(UIView*)theView
{
    if (!theView.superview)
        return nil;
    
    if ([theView.superview isKindOfClass:[UITableView class]])
        return (UITableView*)theView.superview;
    
    return [self getTableView:theView.superview];
}*/

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

@end
