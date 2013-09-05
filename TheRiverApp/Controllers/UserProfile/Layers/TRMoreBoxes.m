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
    TRMoreBoxes *box = [TRMoreBoxes boxWithSize: CGSizeMake(320, 80)];
    box.backgroundColor = [UIColor yellowColor];
    
    [box initScroll];
    
    for(int i=0; i< 10; i++)
    {
        [box addView];
    }
    
    return box;
}

-(void) initScroll
{
    _scrollBoxes = [[UIScrollView alloc] initWithFrame:self.bounds];
    [self addSubview: _scrollBoxes];
}

-(UIView*) createViewWithImage:(UIImage*)image withTitle:(NSString*)title
{
    UIView *rootHead = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 80, 80)];
    rootHead.backgroundColor = [UIColor redColor];
    return rootHead;
}

-(void) addViewsToScroll:(NSArray*)array
{
    //
}

-(void) addView
{
    static int inc = 10;
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(inc, 10, 40, 40)];
    view.backgroundColor = [UIColor redColor];
    
    [_scrollBoxes addSubview:view];
    _scrollBoxes.contentSize = CGSizeMake(view.frame.origin.x+view.frame.size.width, _scrollBoxes.bounds.size.height );
    
    inc += 50;
}


@end 
