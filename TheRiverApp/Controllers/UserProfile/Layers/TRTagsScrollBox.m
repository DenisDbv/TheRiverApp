//
//  TRTagsScrollBox.m
//  TheRiverApp
//
//  Created by DenisDbv on 04.09.13.
//  Copyright (c) 2013 axbx. All rights reserved.
//

#import "TRTagsScrollBox.h"
#import <MGBox2/MGScrollView.h>

@implementation TRTagsScrollBox

- (void)setup {
    
    self.topMargin = 9;
    
    // background
    self.backgroundColor = [UIColor clearColor];
}

+(TRTagsScrollBox *)initBoxWithTitle:(NSString*)title andTagsArray:(NSArray*)tagsArray byTarget:(TRTagsBox*)target
{
    TRTagsScrollBox *box = [TRTagsScrollBox boxWithSize: CGSizeMake(320, 49)];
    box.rootBox = target;
    //box.backgroundColor = [UIColor yellowColor];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textColor = [UIColor colorWithRed:51.0/255.0 green:51.0/255.0 blue:51.0/255.0 alpha:1.0];
    titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:13];
    titleLabel.text = title;
    [titleLabel sizeToFit];
    titleLabel.frame = CGRectOffset(titleLabel.frame, 9, 0);
    [box addSubview:titleLabel];
    
    MGBox *tagsBox = [MGBox boxWithSize:CGSizeMake(320, 28)];
    tagsBox.topMargin = 21;
    [box.boxes addObject:tagsBox];
    
    DWTagList *dwTagsList = [[DWTagList alloc] initWithFrame:CGRectMake(8, 0, tagsBox.bounds.size.width-8, tagsBox.frame.size.height)];
    dwTagsList.tagDelegate = box;
    //dwTagsList.backgroundColor = [UIColor redColor];
    [dwTagsList setTagBackgroundColor:[UIColor colorWithRed:130.0/255.0 green:130.0/255.0 blue:130.0/255.0 alpha:1.0]];
    dwTagsList.scrollEnabled = NO;
    NSArray *array = [[NSArray alloc] initWithArray: tagsArray]; 
    [dwTagsList setTags:array];
    [tagsBox addSubview:dwTagsList];
    
    return box;
}

- (void)selectedTag:(NSString*)tagName
{
    [self.rootBox selectTag:self.tag atName:tagName];
}

@end
