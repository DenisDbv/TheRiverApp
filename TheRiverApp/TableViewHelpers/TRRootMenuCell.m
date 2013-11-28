//
//  TRRootMenuCell.m
//  TheRiverApp
//
//  Created by DenisDbv on 03.09.13.
//  Copyright (c) 2013 axbx. All rights reserved.
//

#import "TRRootMenuCell.h"

@implementation TRRootMenuCell

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
    
    //if( !IS_OS_7_OR_LATER )
    self.textLabel.frame = CGRectMake(20.0, self.textLabel.frame.origin.y, self.textLabel.frame.size.width, self.textLabel.frame.size.height);
    
    //self.imageView.frame = CGRectMake(10,
    //                                  (self.frame.size.height-30)/2,
    //                                  30, 30);
}

@end
