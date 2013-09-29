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
    [box.boxes addObject:dateCreateLine];
    
    MGLineStyled *titleLine = [MGLineStyled lineWithMultilineLeft:box.businessData.businessTitle right:nil width:300.0 minHeight:10];
    titleLine.backgroundColor = [UIColor clearColor];
    titleLine.topMargin = 10;
    titleLine.leftPadding = titleLine.rightPadding = 0;
    titleLine.borderStyle = MGBorderNone;
    titleLine.font = [UIFont fontWithName:@"HypatiaSansPro-Bold" size:23];
    [box.boxes addObject:titleLine];
    
    NSString *fullTitle = [NSString stringWithFormat:@"%@ %@ %@, %@", businessObject.firstName, businessObject.lastName, businessObject.age, businessObject.city];
    MGLineStyled *authorLine = [MGLineStyled lineWithMultilineLeft:fullTitle right:nil width:300 minHeight:10];
    authorLine.backgroundColor = [UIColor clearColor];
    authorLine.topMargin = 10;
    authorLine.leftPadding = authorLine.rightPadding = 0;
    authorLine.borderStyle = MGBorderNone;
    authorLine.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:14];
    [box.boxes addObject:authorLine];*/
    
    return box;
}

@end
