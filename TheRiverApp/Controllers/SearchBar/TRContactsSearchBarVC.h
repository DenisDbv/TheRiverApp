//
//  TRContactsSearchBarVC.h
//  TheRiverApp
//
//  Created by Admin on 22.09.13.
//  Copyright (c) 2013 axbx. All rights reserved.
//


#import <UIKit/UIKit.h>

@protocol TRContactsSearchBarDelegate <NSObject>
-(void) searchBarClick:(UISearchBar*)searchBar;
-(void) searchBarCancel:(UISearchBar*)searchBar;
@end

@interface TRContactsSearchBarVC : UIViewController <UITableViewDataSource, UITableViewDelegate, UISearchDisplayDelegate>

@property (nonatomic, assign) id <TRContactsSearchBarDelegate> delegate;
@property (nonatomic, retain) UISearchBar *searchBar;

-(void) removeSearchTable;

@end