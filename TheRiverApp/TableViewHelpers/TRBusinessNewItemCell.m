//
//  TRBusinessNewItemCell.m
//  TheRiverApp
//
//  Created by DenisDbv on 14.10.13.
//  Copyright (c) 2013 axbx. All rights reserved.
//

#import "TRBusinessNewItemCell.h"

@implementation TRBusinessNewItemCell

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
                                      self.imageView.frame.size.width,
                                      self.imageView.frame.size.height);
}

@end
