//
//  TRBusinessItemCell.m
//  TheRiverApp
//
//  Created by DenisDbv on 09.09.13.
//  Copyright (c) 2013 axbx. All rights reserved.
//

#import "TRBusinessItemCell.h"
#import <QuartzCore/QuartzCore.h>

@implementation TRBusinessItemCell

@synthesize logo, title, subTitle, layerView, layerShortTitleLabel, layerBeforeLabel, layerAfterLabel;

-(void) reloadWithBusinessModel:(TRBusinessModel*)businessObject
{
    logo.image = [UIImage imageNamed:businessObject.businessLogo];
    title.text = businessObject.businessTitle;
    subTitle.text = [NSString stringWithFormat:@"%@ %@ %@, %@", businessObject.firstName, businessObject.lastName, businessObject.age, businessObject.city];
    
    [title sizeToFit];
    CGSize size = [title.text sizeWithFont: title.font
                              constrainedToSize: CGSizeMake(290.0, 50)
                                  lineBreakMode: NSLineBreakByWordWrapping ];
    title.frame = CGRectMake(5.0, 5.0,
                            size.width, size.height);
    
    [subTitle sizeToFit];
    subTitle.frame = CGRectMake(subTitle.frame.origin.x,
                                       title.frame.origin.y+title.frame.size.height+10,
                                       subTitle.bounds.size.width,
                                       subTitle.bounds.size.height);
    
    logo.frame = CGRectMake(-1, subTitle.frame.origin.y+subTitle.frame.size.height+5, 302, 180);
    layerView.frame = logo.frame;
    
    [self showBusinessTitle:businessObject];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    [self initialized];
}

-(void) initialized
{
    layerShortTitleLabel.textColor = [UIColor whiteColor];
    layerShortTitleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:20];
    layerShortTitleLabel.numberOfLines = 0;
    layerShortTitleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    layerShortTitleLabel.layer.shadowColor = [UIColor blackColor].CGColor;
    layerShortTitleLabel.layer.shadowOffset = CGSizeMake(0, 1);
    layerShortTitleLabel.layer.shadowRadius = 1;
    layerShortTitleLabel.layer.shadowOpacity = 0.2f;
    
    layerBeforeLabel.backgroundColor = [UIColor clearColor];
    layerBeforeLabel.textColor = [UIColor whiteColor];
    layerBeforeLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:15];
    layerBeforeLabel.numberOfLines = 1;
    
    layerAfterLabel.backgroundColor = [UIColor clearColor];
    layerAfterLabel.textColor = [UIColor whiteColor];
    layerAfterLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:15];
    layerAfterLabel.numberOfLines = 1;
}

-(void) showBusinessTitle:(TRBusinessModel*)businessObject
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
}

@end
