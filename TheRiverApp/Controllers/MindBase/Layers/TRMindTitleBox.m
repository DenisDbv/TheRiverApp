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

+(TRMindTitleBox *)initBox:(CGSize)bounds withMindData:(TRMindItem *)mindObject
{
    TRMindTitleBox *box = [TRMindTitleBox boxWithSize: CGSizeMake(bounds.width, 10)];
    box.mindData = mindObject;
    
    box.contentLayoutMode = MGLayoutTableStyle;
    
    MGLineStyled *dateCreateLine = [MGLineStyled lineWithMultilineLeft:mindObject.title right:nil width:300.0 minHeight:10.0];
    dateCreateLine.backgroundColor = [UIColor clearColor];
    dateCreateLine.topMargin = 20;
    dateCreateLine.leftPadding = dateCreateLine.rightPadding = 0;
    dateCreateLine.borderStyle = MGBorderNone;
    dateCreateLine.font = [UIFont fontWithName:@"HypatiaSansPro-Bold" size:23];
    [box.boxes addObject:dateCreateLine];
    
    return box;
}

@end
