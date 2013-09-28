//
//  TRPartnersSearchView.m
//  TheRiverApp
//
//  Created by DenisDbv on 28.09.13.
//  Copyright (c) 2013 axbx. All rights reserved.
//

#import "TRPartnersSearchView.h"
#import "TRSearchPartnersListVC.h"
#import "TRSearchBar.h"

@interface TRPartnersSearchView()
@property (nonatomic, retain) TRSearchBar *searchBar;
@end

@implementation TRPartnersSearchView
{
    TRSearchPartnersListVC *rootController;
}
@synthesize searchBar;

- (id)initWithFrame:(CGRect)frame byRootTarget:(id)target
{
    self = [super initWithFrame:frame];
    if (self) {
        
        rootController = target;
        
        [self createSearchBar];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:224.0/255.0 green:224.0/255.0 blue:224.0/255.0 alpha:1.0].CGColor);
    
    // Draw them with a 2.0 stroke width so they are a bit more visible.
    CGContextSetLineWidth(context, 2.0);
    
    CGContextMoveToPoint(context, 0, rect.size.height); //start at this point
    
    CGContextAddLineToPoint(context, rect.size.width, rect.size.height); //draw to this point
    
    // and now draw the Path!
    CGContextStrokePath(context);
}

-(void) createSearchBar
{
    searchBar = [[TRSearchBar alloc] initWithFrame:CGRectMake(5, 0, self.frame.size.width-10, 35)];
    searchBar.frame = CGRectOffset(searchBar.frame, 0, (self.frame.size.height-40)/2);
    [searchBar setPlaceholder:@"Поиск"];
    searchBar.delegate = self;
    [self addSubview:searchBar];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    
    NSLog(@"%@", searchText);
}

-(void) searchBarSearchButtonClicked:(UISearchBar *)aSearchBar{
    
    [aSearchBar resignFirstResponder];
    
}

-(void) resignSearchBar
{
    [searchBar resignFirstResponder];
}

@end
