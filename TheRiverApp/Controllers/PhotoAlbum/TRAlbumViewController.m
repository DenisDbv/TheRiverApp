//
//  TRAlbumViewController.m
//  TheRiverApp
//
//  Created by DenisDbv on 06.09.13.
//  Copyright (c) 2013 axbx. All rights reserved.
//

#import "TRAlbumViewController.h"
#import <AQGridView/AQGridView.h>
#import "TRAlbumGridViewCell.h"
#import "MFSideMenu.h"

@interface TRAlbumViewController ()
@property (nonatomic, retain) AQGridView * gridView;
@end

@implementation TRAlbumViewController
{
    NSMutableArray * allImageNames;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.menuContainerViewController.panMode = MFSideMenuPanModeNone;
	
    [self initialized];
}

-(void) viewWillDisappear:(BOOL)animated
{
    self.menuContainerViewController.panMode = MFSideMenuPanModeDefault;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) initialized
{
    _gridView = [[AQGridView alloc] initWithFrame: self.view.bounds];
    _gridView.backgroundColor = [UIColor blackColor];
    _gridView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
	//_gridView.autoresizesSubviews = YES;
	_gridView.delegate = self;
	_gridView.dataSource = self;
    _gridView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    [self.view addSubview:_gridView];
    
    NSArray * paths = [NSBundle pathsForResourcesOfType: @"png" inDirectory: [[NSBundle mainBundle] bundlePath]];
    allImageNames = [[NSMutableArray alloc] init];
    
    for ( NSString * path in paths )
    {
        if ( [[path lastPathComponent] hasPrefix: @"AQ"] )
            [allImageNames addObject: [path lastPathComponent]];
        else
            continue;
    }
    
    for(NSString *str in allImageNames)
    {
        NSLog(@"%@", str);
    }
    
    [_gridView reloadData];
}

#pragma mark -
#pragma mark Grid View Data Source

- (NSUInteger) numberOfItemsInGridView: (AQGridView *) gridView
{
	return ( allImageNames.count );
}


- (AQGridViewCell *) gridView: (AQGridView *) gridView cellForItemAtIndex: (NSUInteger) index
{
    static NSString * PlainCellIdentifier = @"PlainCellIdentifier";
    
    TRAlbumGridViewCell * plainCell = (TRAlbumGridViewCell *)[gridView dequeueReusableCellWithIdentifier: PlainCellIdentifier];
    if ( plainCell == nil )
    {
        plainCell = [[TRAlbumGridViewCell alloc] initWithFrame: CGRectMake(0.0, 0.0, 100.0, 100.0)
                                                 reuseIdentifier: PlainCellIdentifier];
        plainCell.selectionGlowColor = [UIColor blueColor];
    }

    plainCell.image = [UIImage imageNamed: [allImageNames objectAtIndex: index]];
    
	return ( plainCell );
}

- (CGSize) portraitGridCellSizeForGridView: (AQGridView *) aGridView
{
    return ( CGSizeMake(105.0, 105.0) );
}

@end
