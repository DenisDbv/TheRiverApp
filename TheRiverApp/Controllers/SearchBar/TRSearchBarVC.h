//
//  TRSearchBarVC.h
//  TheRiverApp
//
//  Created by DenisDbv on 02.09.13.
//  Copyright (c) 2013 axbx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TRSearchBar.h"
#import "TRContactsSearchBar.h"

@protocol TRSearchBarDelegate <NSObject>
-(void) onClickBySearchBar:(UISearchBar*)searchBar;
-(void) onCancelSearchBar:(UISearchBar*)searchBar;
-(void) clickOnItemInSearchVC:(TRUserInfoModel*)userInfo;
@end

@interface TRSearchBarVC : UIViewController <UITableViewDataSource, UITableViewDelegate, UISearchDisplayDelegate>

@property (nonatomic, assign) id <TRSearchBarDelegate> delegate;
@property (nonatomic, retain) TRContactsSearchBar *searchBar;

-(void) removeSearchTable;

@end
