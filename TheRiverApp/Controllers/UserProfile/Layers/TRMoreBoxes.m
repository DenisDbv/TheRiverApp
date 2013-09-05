//
//  TRMoreBoxes.m
//  TheRiverApp
//
//  Created by DenisDbv on 04.09.13.
//  Copyright (c) 2013 axbx. All rights reserved.
//

#import "TRMoreBoxes.h"

@implementation TRMoreBoxes
{
    UIScrollView *_scrollBoxes;
}

- (void)setup {
    
    self.topMargin = 10;
    
    // background
    self.backgroundColor = [UIColor clearColor];
}

+(TRMoreBoxes *)initBoxes
{
    TRMoreBoxes *box = [TRMoreBoxes boxWithSize: CGSizeMake(320, 100)];
    //box.backgroundColor = [UIColor yellowColor];
    
    [box initScroll];
    
    NSArray *buttonsArray = [NSArray arrayWithObjects:[box createViewWithImage:nil withTitle:@"Фотографии"],
                             [box createViewWithImage:nil withTitle:@"Кейсы"],
                             [box createViewWithImage:nil withTitle:@"Контакты"],
                             [box createViewWithImage:nil withTitle:@"Подписчики"], nil];
    [box addViewsToScroll:buttonsArray];
    
    return box;
}

-(void) initScroll
{
    _scrollBoxes = [[UIScrollView alloc] initWithFrame:self.bounds];
    _scrollBoxes.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _scrollBoxes.showsHorizontalScrollIndicator = NO;
    _scrollBoxes.contentInset = UIEdgeInsetsMake(1, 10, 1, 10);
    [self addSubview: _scrollBoxes];
}

-(UIView*) createViewWithImage:(UIImage*)image withTitle:(NSString*)title
{
    UIView *rootHead = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 90)];
    //rootHead.backgroundColor = [UIColor redColor];
    
    UIView *preview = [[UIView alloc] initWithFrame:CGRectMake(0, 0,
                                                               rootHead.frame.size.width,
                                                               rootHead.frame.size.height-20)];
    preview.backgroundColor = [UIColor yellowColor];
    preview.layer.shadowColor = [UIColor colorWithWhite:0.12 alpha:1].CGColor;
    preview.layer.shadowOffset = CGSizeMake(0, 0);
    preview.layer.shadowRadius = 1;
    preview.layer.shadowOpacity = 1;
    preview.layer.cornerRadius = 2;
    [rootHead addSubview:preview];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    titleLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:13];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.text = title;
    [titleLabel sizeToFit];
    titleLabel.frame = CGRectOffset(titleLabel.frame,
                                    (rootHead.frame.size.width-titleLabel.frame.size.width)/2,
                                    (rootHead.frame.size.height-titleLabel.frame.size.height));
    [rootHead addSubview:titleLabel];
    
    return rootHead;
}

-(void) addViewsToScroll:(NSArray*)array
{
    int index = 0;
    
    for(UIView *view in array)
    {
        view.frame = CGRectOffset(view.frame, index*(view.bounds.size.width+10), 0);
        
        _scrollBoxes.contentSize = CGSizeMake(view.origin.x+view.frame.size.width, view.bounds.size.height);
        [_scrollBoxes addSubview:view];
        
        index++;
    }
}


@end 
