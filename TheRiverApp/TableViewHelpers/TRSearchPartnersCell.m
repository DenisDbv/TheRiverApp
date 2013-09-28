//
//  TRSearchPartnersCell.m
//  TheRiverApp
//
//  Created by DenisDbv on 28.09.13.
//  Copyright (c) 2013 axbx. All rights reserved.
//

#import "TRSearchPartnersCell.h"

@implementation TRSearchPartnersCell
@synthesize avatarImageView, fioLabel, subTextLabel, typeSubTextLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initialized];
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
    
}

-(void) setCellFio:(NSString*)fioText
           subText:(NSString*)subText
       typeSubText:(PartnersFilterType)filterType
{
    fioLabel.text = fioText;
    subTextLabel.text = subText;
    
    switch (filterType) {
        case textFio:
            typeSubTextLabel.text = @"";
            break;
        case textCity:
            typeSubTextLabel.text = @"город";
            break;
        case textScopeWork:
            typeSubTextLabel.text = @"отрасль";
            break;
        case textInterests:
            typeSubTextLabel.text = @"знания";
            break;
            
        default:
            break;
    }
}

@end
