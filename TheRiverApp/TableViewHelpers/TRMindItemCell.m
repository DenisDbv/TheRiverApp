//
//  TRMindItemCell.m
//  TheRiverApp
//
//  Created by DenisDbv on 08.09.13.
//  Copyright (c) 2013 axbx. All rights reserved.
//

#import "TRMindItemCell.h"
#import <QuartzCore/QuartzCore.h>

@implementation TRMindItemCell

@synthesize logo, titleLabel, authorNameLabel, dateCreateLabel, levelView, ratingLabel;

-(void) reloadWithMindModel:(TRMindModel*)mindObject
{
    //levelView.layer.cornerRadius = CGRectGetHeight(levelView.bounds) / 2;
    levelView.clipsToBounds = YES;
    logo.image = [UIImage imageNamed:mindObject.mindLogo];
    titleLabel.text = mindObject.mindTitle;
    authorNameLabel.text = mindObject.mindAuthor;
    dateCreateLabel.text = mindObject.mindDayCreate;
    ratingLabel.text = [NSString stringWithFormat:@"%i", mindObject.mindRating];
    
    [titleLabel sizeToFit];
    CGSize size = [titleLabel.text sizeWithFont: titleLabel.font
                              constrainedToSize: CGSizeMake(222.0, 50)
                                  lineBreakMode: NSLineBreakByWordWrapping ];
    titleLabel.frame = CGRectMake(78.0,
                                  10.0,
                                  size.width, size.height);
    
    [authorNameLabel sizeToFit];
    authorNameLabel.frame = CGRectMake(authorNameLabel.frame.origin.x,
                                       titleLabel.frame.origin.y+titleLabel.frame.size.height+3,
                                       authorNameLabel.bounds.size.width,
                                       authorNameLabel.bounds.size.height);

    //[dateCreateLabel sizeToFit];
    /*dateCreateLabel.frame = CGRectMake(dateCreateLabel.frame.origin.x,
                                       authorNameLabel.frame.origin.y+authorNameLabel.frame.size.height,
                                       dateCreateLabel.bounds.size.width,
                                       dateCreateLabel.bounds.size.height);*/
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        titleLabel.font = [UIFont fontWithName:@"HypatiaSansPro-Regular" size:16];
    }
    return self;
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
