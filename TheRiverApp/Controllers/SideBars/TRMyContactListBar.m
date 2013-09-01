//
//  TRMyContactListBar.m
//  TheRiverApp
//
//  Created by DenisDbv on 02.09.13.
//  Copyright (c) 2013 axbx. All rights reserved.
//

#import "TRMyContactListBar.h"
#import "TRSearchBarVC.h"

#import <MFSideMenu/MFSideMenu.h>
#import <UITableView-NXEmptyView/UITableView+NXEmptyView.h>

@interface TRMyContactListBar ()
@property (nonatomic, retain) TRSearchBarVC *searchBarController;
@property (nonatomic, retain) UITableView *contactsTableView;
@end

@implementation TRMyContactListBar

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
    
    _searchBarController = [[TRSearchBarVC alloc] init];
    _searchBarController.delegate = (id)self;
    [self.view addSubview:_searchBarController.searchBar];
    [_searchBarController.searchBar sizeToFit];
    
    _contactsTableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0f, 44.0f,
                                                                       260, CGRectGetHeight(self.view.bounds)-44.0)
                                                      style:UITableViewStylePlain];
	_contactsTableView.delegate = (id)self;
	_contactsTableView.dataSource = (id)self;
	_contactsTableView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
	_contactsTableView.backgroundColor = [UIColor whiteColor];
	_contactsTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //_contactsTableView.nxEV_emptyView = all;
	[self.view addSubview: _contactsTableView];
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
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:@"Cell"];
    }
    
    cell.textLabel.text = @"Дубов Денис";
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
}

#pragma mark SearchNearContactsDelegate

-(void) onClickBySearchBar:(UISearchBar*)searchBar
{
    [UIView beginAnimations:nil context:NULL];
    [self toFullWidth];
    [_searchBarController.searchBar layoutSubviews];
    [UIView commitAnimations];
    
    [_searchBarController.searchBar setShowsCancelButton:YES animated:YES];
    
    self.menuContainerViewController.panMode = MFSideMenuPanModeNone;
}

-(void) onCancelSearchBar:(UISearchBar*)searchBar
{
    [_searchBarController.searchBar resignFirstResponder];
    
    [UIView beginAnimations:nil context:NULL];
    [self toShortWidth];
    [_searchBarController.searchBar layoutSubviews];
    [UIView commitAnimations];
    
    [_searchBarController.searchBar setShowsCancelButton:NO animated:YES];
    
    self.menuContainerViewController.panMode = MFSideMenuPanModeDefault;
}

@end
