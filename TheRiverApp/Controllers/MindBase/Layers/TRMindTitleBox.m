//
//  TRMindTitleBox.m
//  TheRiverApp
//
//  Created by DenisDbv on 09.09.13.
//  Copyright (c) 2013 axbx. All rights reserved.
//

#import "TRMindTitleBox.h"
#import <MGBox2/MGLineStyled.h>

@implementation TRMindTitleBox

- (void)setup {
    
    self.backgroundColor = [UIColor whiteColor];
    
    self.leftMargin = self.rightMargin = 9;
}

+(TRMindTitleBox *)initBox:(CGSize)bounds withMindData:(TRMindModel *)mindObject
{
    TRMindTitleBox *box = [TRMindTitleBox boxWithSize: CGSizeMake(bounds.width, 10)];
    box.mindData = mindObject;
    
    box.contentLayoutMode = MGLayoutTableStyle;
    
    MGLineStyled *dateCreateLine = [MGLineStyled lineWithLeft:nil multilineRight:mindObject.mindDayCreate width:300.0 minHeight:10.0];
    dateCreateLine.backgroundColor = [UIColor clearColor];
    dateCreateLine.topMargin = 10;
    dateCreateLine.rightPadding = 0;
    dateCreateLine.borderStyle = MGBorderNone;
    dateCreateLine.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:12];
    [box.boxes addObject:dateCreateLine];
    
    MGLineStyled *titleLine = [MGLineStyled lineWithMultilineLeft:box.mindData.mindTitle right:nil width:300.0 minHeight:10];
    titleLine.backgroundColor = [UIColor clearColor];
    titleLine.topMargin = 10;
    titleLine.leftPadding = titleLine.rightPadding = 0;
    titleLine.borderStyle = MGBorderNone;
    titleLine.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:25];
    [box.boxes addObject:titleLine];
    
    MGLineStyled *authorLine = [MGLineStyled lineWithMultilineLeft:box.mindData.mindAuthor right:nil width:300 minHeight:10];
    authorLine.backgroundColor = [UIColor clearColor];
    authorLine.topMargin = 10;
    authorLine.leftPadding = authorLine.rightPadding = 0;
    authorLine.borderStyle = MGBorderNone;
    authorLine.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:14];
    [box.boxes addObject:authorLine];
    
    return box;
}

@end
