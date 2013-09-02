//
//  TRFavoritesEditList.m
//  TheRiverApp
//
//  Created by DenisDbv on 02.09.13.
//  Copyright (c) 2013 axbx. All rights reserved.
//

#import "TRFavoritesEditList.h"
#import "TRSearchBarVC.h"
#import "TRSectionHeaderView.h"

#import <MFSideMenu/MFSideMenu.h>

@interface TRFavoritesEditList ()
@property (nonatomic, retain) TRSearchBarVC *searchBarController;
@property (nonatomic, retain) UITableView *contactsTableView;
@end

@implementation TRFavoritesEditList

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
    
    [self toFullWidth];
    self.menuContainerViewController.panMode = MFSideMenuPanModeNone;
	
    _searchBarController = [[TRSearchBarVC alloc] init];
    _searchBarController.delegate = (id)self;
    [self.view addSubview:_searchBarController.searchBar];
    [_searchBarController.searchBar sizeToFit];
    
    _contactsTableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0f, 44.0f,
                                                                       320, CGRectGetHeight(self.view.bounds)-44.0)
                                                      style:UITableViewStylePlain];
	_contactsTableView.delegate = (id)self;
	_contactsTableView.dataSource = (id)self;
	_contactsTableView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    [_contactsTableView setSeparatorColor:[UIColor colorWithRed:49.0/255.0
                                                          green:54.0/255.0
                                                           blue:57.0/255.0
                                                          alpha:1.0]];
    [_contactsTableView setBackgroundColor:[UIColor colorWithRed:77.0/255.0
                                                           green:79.0/255.0
                                                            blue:80.0/255.0
                                                           alpha:1.0]];
    //_contactsTableView.nxEV_emptyView = all;
	[self.view addSubview: _contactsTableView];
    
    [self.view setBackgroundColor:[UIColor clearColor]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 100;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    TRSectionHeaderView * headerView =  [[TRSectionHeaderView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(tableView.bounds), 32.0f)];
    [headerView setTitle:@"ИЗБРАННОЕ"];
    [headerView setAutoresizingMask:UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth];
    return headerView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 32.0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
        [cell setBackgroundColor:[UIColor clearColor]];
        [cell.textLabel setTextColor:[UIColor whiteColor]];
        [cell.textLabel setFont:[UIFont fontWithName:@"Helvetica" size:16]];
    }
    
    cell.imageView.image = [UIImage imageNamed:@"IamAppleDev2.jpg"];
    cell.textLabel.text = @"Дубов Денис";
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

#pragma mark SearchNearContactsDelegate

-(void) onClickBySearchBar:(UISearchBar*)searchBar
{
    
}

-(void) onCancelSearchBar:(UISearchBar*)searchBar
{
    self.menuContainerViewController.panMode = MFSideMenuPanModeDefault;
    [self.navigationController popViewControllerAnimated:NO];
}


@end
