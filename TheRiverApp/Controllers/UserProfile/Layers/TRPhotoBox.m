//
//  TRPhotoBox.m
//  TheRiverApp
//
//  Created by DenisDbv on 03.09.13.
//  Copyright (c) 2013 axbx. All rights reserved.
//

#import "TRPhotoBox.h"

@implementation TRPhotoBox

- (void)setup {
    
    self.topMargin = 134;
    //self.leftMargin = 10;
    // background
    self.backgroundColor = [UIColor clearColor];
    
    // shadow
    self.layer.shadowColor = [UIColor colorWithWhite:0.12 alpha:1].CGColor;
    self.layer.shadowOffset = CGSizeMake(0, 0.5);
    self.layer.shadowRadius = 1;
    self.layer.shadowOpacity = 1;
    self.layer.cornerRadius = 2;
    //self.layer.rasterizationScale = 1.0;
    //self.layer.shouldRasterize = YES;
}

+(TRPhotoBox *)initBox
{
    TRPhotoBox *box = [TRPhotoBox boxWithSize: CGSizeMake(320, 106+10)];
    box.contentLayoutMode = MGLayoutGridStyle;
    //box.backgroundColor = [UIColor yellowColor];
    //[box loadPhoto];
    
    MGBox *photoBox = [MGBox boxWithSize:CGSizeMake(106, 106)];
    photoBox.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.95 alpha:1];
    photoBox.leftMargin = photoBox.topMargin = 10;
    photoBox.bottomMargin = 10;
    [box loadPhoto:photoBox];
    [box.boxes addObject:photoBox];
    
    MGBox *profileDataBox = [MGBox boxWithSize:CGSizeMake(320 - ((photoBox.bounds.size.width+20) + 10), 106)];
    //profileDataBox.backgroundColor = [UIColor yellowColor];
    profileDataBox.leftMargin = profileDataBox.topMargin = 10;
    profileDataBox.bottomMargin = 10;
    [box addTexts:profileDataBox];
    [box.boxes addObject:profileDataBox];
    
    return box; 
}

-(void) loadPhoto:(MGBox*)photoBox
{
    UIImage *image = [UIImage imageNamed:@"IamAppleDev.jpg"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    [photoBox addSubview:imageView];
    
    imageView.frame = CGRectMake(3, 3, 100, 100);
    imageView.alpha = 0;
    imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth
    | UIViewAutoresizingFlexibleHeight;
    
    // fade the image in
    [UIView animateWithDuration:0.1 animations:^{
        imageView.alpha = 1;
    }];
}

-(void) addTexts:(MGBox*)dataBox
{
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.backgroundColor = [UIColor clearColor];
    nameLabel.textColor = [UIColor whiteColor];
    nameLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:20];
    nameLabel.numberOfLines = 2;
    nameLabel.lineBreakMode = NSLineBreakByWordWrapping;
    nameLabel.text = @"Денис Дубов";

    CGSize size = [nameLabel.text sizeWithFont:nameLabel.font constrainedToSize:CGSizeMake(dataBox.bounds.size.width, FLT_MAX) lineBreakMode:NSLineBreakByWordWrapping ];
    nameLabel.frame = CGRectMake(0, 0, size.width, size.height);
    [dataBox addSubview:nameLabel];
    
    UILabel *groupLabel = [[UILabel alloc] init];
    groupLabel.backgroundColor = [UIColor clearColor];
    groupLabel.textColor = [UIColor whiteColor];
    groupLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:18];
    groupLabel.numberOfLines = 1;
    groupLabel.lineBreakMode = NSLineBreakByWordWrapping;
    groupLabel.text = @"Мастер-группа";
    [groupLabel sizeToFit];
    groupLabel.frame = CGRectOffset(groupLabel.frame, 0, nameLabel.frame.origin.y+nameLabel.frame.size.height + 10);
    [dataBox addSubview:groupLabel];
    
    UILabel *yearsCityLabel = [[UILabel alloc] init];
    yearsCityLabel.backgroundColor = [UIColor clearColor];
    yearsCityLabel.textColor = [UIColor whiteColor];
    yearsCityLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:14];
    yearsCityLabel.numberOfLines = 1;
    yearsCityLabel.lineBreakMode = NSLineBreakByWordWrapping;
    yearsCityLabel.text = @"28 лет, Гонконг";
    [yearsCityLabel sizeToFit];
    yearsCityLabel.frame = CGRectOffset(yearsCityLabel.frame, 0, groupLabel.frame.origin.y+groupLabel.frame.size.height + 10);
    [dataBox addSubview:yearsCityLabel];
}

@end
