//
//  TRBusinessBox.m
//  TheRiverApp
//
//  Created by DenisDbv on 08.09.13.
//  Copyright (c) 2013 axbx. All rights reserved.
//

#import "TRBusinessBox.h"
#import <MGBox2/MGLineStyled.h>

@implementation TRBusinessBox
{
    UIImageView *imageView;
}

- (void)setup {
    
    self.backgroundColor = [UIColor colorWithRed:229.0/255.0 green:229.0/255.0 blue:229.0/255.0 alpha:1.0];
    
    self.topMargin = 0.0;
    self.leftMargin = 0.0;
    self.rightMargin = 0.0;
}

+(TRBusinessBox *)initBox:(CGSize)bounds withUserData:(TRUserInfoModel *)userObject
{
    TRBusinessBox *box = [TRBusinessBox boxWithSize: CGSizeMake(320, 10)];
    box.userData = userObject;
    //box.backgroundColor = [UIColor redColor];
    
    //[box showBusinessImage];
    //[box showBusinessTitle];
    [box showBusinessInfo2];
    
    return box;
}

-(void) showBusinessImage
{
    UIImage *image = [UIImage imageNamed: self.userData.business.logo];
    
    imageView = [[UIImageView alloc] initWithImage:image];
    
    imageView.size = self.bounds.size;
    imageView.alpha = 0;
    imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self addSubview:imageView];
    
    [UIView animateWithDuration:0.1 animations:^{
        imageView.alpha = 1;
    }];
}

-(void) showBusinessTitle
{
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.backgroundColor = [UIColor clearColor];
    nameLabel.textColor = [UIColor whiteColor];
    nameLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:20];
    nameLabel.numberOfLines = 2;
    nameLabel.lineBreakMode = NSLineBreakByWordWrapping;
    nameLabel.text = @"title business";
    
    nameLabel.layer.shadowColor = [UIColor blackColor].CGColor;
    nameLabel.layer.shadowOffset = CGSizeMake(0, 1);
    nameLabel.layer.shadowRadius = 1;
    nameLabel.layer.shadowOpacity = 0.2f;
    
    CGSize size = [nameLabel.text sizeWithFont:nameLabel.font constrainedToSize:CGSizeMake(280.0, FLT_MAX) lineBreakMode:nameLabel.lineBreakMode ];
    nameLabel.frame = CGRectMake(10.0, 10.0, size.width, size.height);
    [self addSubview: nameLabel];
    
    UILabel *beforeLabel = [[UILabel alloc] init];
    beforeLabel.backgroundColor = [UIColor clearColor];
    beforeLabel.textColor = [UIColor whiteColor];
    beforeLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:15];
    beforeLabel.numberOfLines = 2;
    beforeLabel.lineBreakMode = NSLineBreakByWordWrapping;
    beforeLabel.text = @"before money";
    
    CGSize size2 = [beforeLabel.text sizeWithFont:beforeLabel.font constrainedToSize:CGSizeMake(280.0, FLT_MAX) lineBreakMode:beforeLabel.lineBreakMode ];
    beforeLabel.frame = CGRectMake(nameLabel.frame.origin.x, nameLabel.frame.origin.y+nameLabel.frame.size.height, size2.width, size2.height);
    [self addSubview: beforeLabel];

    UILabel *afterLabel = [[UILabel alloc] init];
    afterLabel.backgroundColor = [UIColor clearColor];
    afterLabel.textColor = [UIColor whiteColor];
    afterLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:15];
    afterLabel.numberOfLines = 2;
    afterLabel.lineBreakMode = NSLineBreakByWordWrapping;
    afterLabel.text = @"after money";
    
    CGSize size3 = [afterLabel.text sizeWithFont:afterLabel.font constrainedToSize:CGSizeMake(280.0, FLT_MAX) lineBreakMode:afterLabel.lineBreakMode ];
    afterLabel.frame = CGRectMake(beforeLabel.frame.origin.x, beforeLabel.frame.origin.y+beforeLabel.frame.size.height, size3.width, size3.height);
    [self addSubview: afterLabel];
}

-(void) showBusinessInfo
{
    MGLineStyled *titleLine = [MGLineStyled lineWithMultilineLeft:self.userData.business.company_name right:nil width:300.0 minHeight:10];
    titleLine.backgroundColor = [UIColor clearColor];
    titleLine.topMargin = 0;
    titleLine.leftPadding = titleLine.rightPadding = 0;
    titleLine.borderStyle = MGBorderNone;
    titleLine.font = [UIFont fontWithName:@"HypatiaSansPro-Bold" size:23];
    [self.boxes addObject:titleLine];
    
    NSString *fullTitle = [NSString stringWithFormat:@"%@ %@ %@, %@", self.userData.first_name, self.userData.last_name, self.userData.age, self.userData.city];
    MGLineStyled *authorLine = [MGLineStyled lineWithMultilineLeft:self.userData.business.about right:nil width:300 minHeight:10];
    authorLine.backgroundColor = [UIColor clearColor];
    authorLine.topMargin = 0;
    authorLine.leftPadding = authorLine.rightPadding = 0;
    authorLine.borderStyle = MGBorderNone;
    authorLine.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:14];
    [self.boxes addObject:authorLine];
    
    NSString *fullProfitTitle = [NSString stringWithFormat:@"Оборот в месяц: %@ р", self.userData.business.profit];
    MGLineStyled *profitLine = [MGLineStyled lineWithMultilineLeft:fullProfitTitle right:nil width:300 minHeight:10];
    profitLine.backgroundColor = [UIColor clearColor];
    profitLine.topMargin = 5;
    profitLine.leftPadding = authorLine.rightPadding = 0;
    profitLine.borderStyle = MGBorderNone;
    profitLine.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:14];
    [self.boxes addObject:profitLine];
    
    NSString *fullEmployesTitle = [NSString stringWithFormat:@"Количество сотрудников: %@", self.userData.business.employees];
    MGLineStyled *employesLine = [MGLineStyled lineWithMultilineLeft:fullEmployesTitle right:nil width:300 minHeight:10];
    employesLine.backgroundColor = [UIColor clearColor];
    employesLine.topMargin = 5;
    employesLine.leftPadding = authorLine.rightPadding = 0;
    employesLine.borderStyle = MGBorderNone;
    employesLine.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:14];
    [self.boxes addObject:employesLine];
}

-(void) showBusinessInfo2
{
    MGBox *cardBox = [MGBox boxWithSize:CGSizeMake(310, 50)];
    cardBox.backgroundColor = [UIColor whiteColor];
    cardBox.topMargin = 10.0;
    cardBox.leftMargin = 5.0;
    cardBox.rightMargin = 5.0;
    [self.boxes addObject:cardBox];
    
    MGLineStyled *titleLine = [MGLineStyled lineWithMultilineLeft:self.userData.business.company_name right:nil width:310.0 minHeight:10];
    titleLine.backgroundColor = [UIColor clearColor];
    titleLine.topMargin = 10;
    titleLine.leftPadding = titleLine.rightPadding = 10;
    titleLine.borderStyle = MGBorderNone;
    titleLine.font = [UIFont fontWithName:@"HypatiaSansPro-Bold" size:18];
    [cardBox.boxes addObject:titleLine];
    
    MGLineStyled *businessAbout = [MGLineStyled lineWithMultilineLeft:self.userData.business.about right:nil width:300 minHeight:10];
    businessAbout.backgroundColor = [UIColor clearColor];
    businessAbout.topMargin = 0;
    businessAbout.leftPadding = businessAbout.rightPadding = 10;
    businessAbout.borderStyle = MGBorderNone;
    businessAbout.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:14];
    [cardBox.boxes addObject:businessAbout];
    
    MGLineStyled *blocksLine = [MGLineStyled lineWithLeft:[self blockWithTitle:@"Оборот в месяц" andText:[NSString stringWithFormat:@"%@ р", self.userData.business.profit]]
                                                    right:[self blockWithTitle:@"Количество сотрудников" andText:self.userData.business.employees]
                                                     size:CGSizeMake(300, 60)];
    blocksLine.backgroundColor = [UIColor clearColor];
    blocksLine.topMargin = 10;
    blocksLine.leftPadding = 10;
    blocksLine.rightPadding = 0;
    blocksLine.borderStyle = MGBorderNone;
    [cardBox.boxes addObject:blocksLine];
}

-(UIView*) blockWithTitle:(NSString*)title andText:(NSString*)text
{
    UIView *blockView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 140.0, 50.0)];
    blockView.backgroundColor = [UIColor colorWithRed:241.0/255.0 green:241.0/255.0 blue:241.0/255.0 alpha:1.0];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.font = [UIFont fontWithName:@"HypatiaSansPro-Regular" size:12.0];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor grayColor];
    titleLabel.text = title;
    titleLabel.frame = CGRectMake(0, 5, blockView.bounds.size.width, 14);
    [blockView addSubview:titleLabel];
    
    UILabel *textLabel = [[UILabel alloc] init];
    textLabel.font = [UIFont fontWithName:@"HypatiaSansPro-Bold" size:20.0];
    textLabel.backgroundColor = [UIColor clearColor];
    textLabel.textAlignment = NSTextAlignmentCenter;
    textLabel.textColor = [UIColor grayColor];
    textLabel.text = text;
    textLabel.frame = CGRectMake(0, titleLabel.frame.origin.y+titleLabel.frame.size.height, blockView.bounds.size.width, 30);
    [blockView addSubview:textLabel];
    
    return blockView;
}

@end
