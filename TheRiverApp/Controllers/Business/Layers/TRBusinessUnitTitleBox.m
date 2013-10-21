//
//  TRBusinessTitleBox.m
//  TheRiverApp
//
//  Created by DenisDbv on 10.09.13.
//  Copyright (c) 2013 axbx. All rights reserved.
//

#import "TRBusinessUnitTitleBox.h"
#import <MGBox2/MGLineStyled.h>

@implementation TRBusinessUnitTitleBox

- (void)setup {
    
    self.backgroundColor = [UIColor whiteColor];
    
    self.leftMargin = self.rightMargin = 9;
}

+(TRBusinessUnitTitleBox *)initBox:(CGSize)bounds withMindData:(TRBusinessModel *)businessObject
{
    TRBusinessUnitTitleBox *box = [TRBusinessUnitTitleBox boxWithSize: CGSizeMake(bounds.width, 10)];
    box.businessData = businessObject;
    
    box.contentLayoutMode = MGLayoutTableStyle;
    
    /*MGLineStyled *dateCreateLine = [MGLineStyled lineWithLeft:nil multilineRight:businessObject.businessDate width:300.0 minHeight:10.0];
    dateCreateLine.backgroundColor = [UIColor clearColor];
    dateCreateLine.topMargin = 10;
    dateCreateLine.rightPadding = 0;
    dateCreateLine.borderStyle = MGBorderNone;
    dateCreateLine.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:12];
    [box.boxes addObject:dateCreateLine];*/
    
    NSString *fullTitle = [NSString stringWithFormat:@"%@ %@ %@ %@, %@", businessObject.first_name, businessObject.last_name, businessObject.age, [box getStringYearByAge:[businessObject.age integerValue]], businessObject.city];
    MGLineStyled *authorLine = [MGLineStyled lineWithMultilineLeft:fullTitle right:nil width:300 minHeight:10];
    authorLine.backgroundColor = [UIColor clearColor];
    authorLine.topMargin = 10;
    authorLine.leftPadding = authorLine.rightPadding = 0;
    authorLine.borderStyle = MGBorderNone;
    authorLine.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:14];
    [box.boxes addObject:authorLine];
    
    MGLineStyled *titleLine = [MGLineStyled lineWithMultilineLeft:businessObject.company_name right:nil width:300.0 minHeight:10];
    titleLine.backgroundColor = [UIColor clearColor];
    titleLine.topMargin = 10;
    titleLine.leftPadding = titleLine.rightPadding = 0;
    titleLine.borderStyle = MGBorderNone;
    titleLine.font = [UIFont fontWithName:@"HypatiaSansPro-Bold" size:23];
    [box.boxes addObject:titleLine];
    
    MGLineStyled *aboutLine = [MGLineStyled lineWithMultilineLeft:businessObject.about right:nil width:300 minHeight:10];
    aboutLine.backgroundColor = [UIColor clearColor];
    aboutLine.topMargin = 0;
    aboutLine.leftPadding = authorLine.rightPadding = 0;
    aboutLine.borderStyle = MGBorderNone;
    aboutLine.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:14];
    [box.boxes addObject:aboutLine];
    
    NSString *fullProfitTitle = [NSString stringWithFormat:@"Оборот в месяц: %@ р", businessObject.profit];
    MGLineStyled *profitLine = [MGLineStyled lineWithMultilineLeft:fullProfitTitle right:nil width:300 minHeight:10];
    profitLine.backgroundColor = [UIColor clearColor];
    profitLine.topMargin = 5;
    profitLine.leftPadding = authorLine.rightPadding = 0;
    profitLine.borderStyle = MGBorderNone;
    profitLine.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:14];
    [box.boxes addObject:profitLine];
    
    return box;
}

-(NSString*) getStringYearByAge:(NSInteger)age
{
    NSInteger lastDigit = age % 10;
    
    NSLog(@"==>%i", lastDigit);
    
    if( lastDigit == 1 )
        return @"год";
    else if( lastDigit > 1 && lastDigit <= 4 )
        return @"года";
    else if( (lastDigit >= 5 && lastDigit <= 9) || lastDigit == 0 )
        return @"лет";
    
    return @"";
}

@end
