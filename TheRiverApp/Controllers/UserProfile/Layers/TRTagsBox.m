//
//  TRTagsBox.m
//  TheRiverApp
//
//  Created by DenisDbv on 08.09.13.
//  Copyright (c) 2013 axbx. All rights reserved.
//

#import "TRTagsBox.h"
#import "TRTagsScrollBox.h"

@implementation TRTagsBox

- (void)setup {
    
    self.backgroundColor = [UIColor colorWithRed:242.0/255.0 green:242.0/255.0 blue:242.0/255.0 alpha:1.0];
    
    //self.borderStyle = MGBorderEtchedTop;
    //self.topBorderColor = [UIColor colorWithRed:206.0/255.0 green:206.0/255.0 blue:206.0/255.0 alpha:1.0];
    
    self.zIndex = -1;
    
    self.topMargin = 10;
}

+(TRTagsBox *)initBox:(CGSize)bounds withUserData:(TRUserModel *)userObject
{
    TRTagsBox *box = [TRTagsBox boxWithSize: CGSizeMake(bounds.width, 124)];
    box.userData = userObject;
    
    TRTagsScrollBox *tagsResolution = [TRTagsScrollBox initBoxWithTitle:@"Высокое разрешение:" andTagsArray:[[NSArray alloc] initWithObjects:@"#iOS", @"#Android", @"#Ruby", @"#Rails", nil]];
    [box.boxes addObject:tagsResolution];
    
    TRTagsScrollBox *tagsCurrentBusiness = [TRTagsScrollBox initBoxWithTitle:@"Текущие ниши:" andTagsArray:[[NSArray alloc] initWithObjects:@"AXBX software", @"Школа счастья", @"NEO", nil]];
    [box.boxes addObject:tagsCurrentBusiness];
    
    return box;
}

@end
