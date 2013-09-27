//
//  TRSearchPUsersCell.m
//  TheRiverApp
//
//  Created by DenisDbv on 27.09.13.
//  Copyright (c) 2013 axbx. All rights reserved.
//

#import "TRSearchPUsersCell.h"

@implementation TRSearchPUsersCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.textLabel.font = [UIFont fontWithName:@"HypatiaSansPro-Bold" size:16];
        
        self.detailTextLabel.font = [UIFont fontWithName:@"HypatiaSansPro-Regular" size:14];
        self.detailTextLabel.textColor = [UIColor lightGrayColor];
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
}

@end
