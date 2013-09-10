//
//  TRFriendCell.m
//  TheRiverApp
//
//  Created by DenisDbv on 10.09.13.
//  Copyright (c) 2013 axbx. All rights reserved.
//

#import "TRFriendCell.h"

@implementation TRFriendCell

@synthesize friendName, friendCurrentBusiness, friendLogo;

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

-(void) initialized
{
    friendName.font = [UIFont fontWithName:@"HypatiaSansPro-Bold" size:19];
    friendCurrentBusiness.font = [UIFont fontWithName:@"" size:15];
}



@end
