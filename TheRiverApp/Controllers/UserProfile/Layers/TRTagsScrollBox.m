//
//  TRTagsScrollBox.m
//  TheRiverApp
//
//  Created by DenisDbv on 04.09.13.
//  Copyright (c) 2013 axbx. All rights reserved.
//

#import "TRTagsScrollBox.h"
#import <MGBox2/MGScrollView.h>
#import <DWTagList/DWTagList.h>

@implementation TRTagsScrollBox

- (void)setup {
    
    self.topMargin = 10;
    
    // background
    self.backgroundColor = [UIColor clearColor];
}

+(TRTagsScrollBox *)initBoxWithTitle:(NSString*)title andTagsArray:(NSArray*)tagsArray
{
    TRTagsScrollBox *box = [TRTagsScrollBox boxWithSize: CGSizeMake(320, 30)];
    //box.backgroundColor = [UIColor yellowColor];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:13];
    titleLabel.text = title;
    [titleLabel sizeToFit];
    titleLabel.frame = CGRectOffset(titleLabel.frame, 15, 0);
    [box addSubview:titleLabel];
    
    MGBox *hightResolutionBox = [MGBox boxWithSize:CGSizeMake(300, 25)];
    hightResolutionBox.topMargin = 20;
    hightResolutionBox.leftMargin = 10;
    hightResolutionBox.rightMargin = 10;
    //hightResolutionBox.backgroundColor = [UIColor redColor];
    [box.boxes addObject:hightResolutionBox];
    
    DWTagList *dwTagsList = [[DWTagList alloc] initWithFrame:hightResolutionBox.bounds];
    dwTagsList.scrollEnabled = NO;
    NSArray *array = [[NSArray alloc] initWithArray: tagsArray]; 
    [dwTagsList setTags:array];
    [hightResolutionBox addSubview:dwTagsList];
    
    return box;
}

@end
