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
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

@end
