//
//  TRSearchPartnersListVC.m
//  TheRiverApp
//
//  Created by DenisDbv on 27.09.13.
//  Copyright (c) 2013 axbx. All rights reserved.
//

#import "TRSearchPartnersListVC.h"
#import "TRPartnersSearchView.h"
#import "UIBarButtonItem+BarButtonItemExtended.h"
#import <SlideInMenuViewController.h>

@interface TRSearchPartnersListVC ()
@property (nonatomic, retain) TRPartnersSearchView *menuView;
@property (nonatomic, retain) SlideInMenuViewController *scrollDownMindMenu;

@property (nonatomic, retain) TRPartnersListModel *_partnersList;
@end

@implementation TRSearchPartnersListVC
{
    NSArray *headerTitles;
}
@synthesize menuView;
@synthesize _partnersList;

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
    
    headerTitles = @[@"ФИО", @"Город", @"Отрасли", @"Высокое разрешение"];
    
    UIBarButtonItem *onCancelButton = [UIBarButtonItem barItemWithImage:[UIImage imageNamed:@"toolbar-back-button@2x.png"] target:self action:@selector(onBack)];
    [onCancelButton setBackgroundImage:[UIImage new] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [self.navigationItem setLeftBarButtonItem:onCancelButton animated:YES];
    
    
    menuView = [[TRPartnersSearchView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 50) byRootTarget:self];
    menuView.backgroundColor = [UIColor whiteColor];
    _scrollDownMindMenu = [[SlideInMenuViewController alloc] initWithMenuView: menuView];
    
    [self.tableView addSubview: _scrollDownMindMenu.view];
    [self.tableView setContentInset:UIEdgeInsetsMake(menuView.frame.size.height, 0, 0, 0)];
    [self.tableView setScrollIndicatorInsets:UIEdgeInsetsMake(menuView.frame.size.height, 0, 0, 0)];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShown:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHidden:) name:UIKeyboardWillHideNotification object:nil];
}

-(void) viewDidAppear:(BOOL)animated
{
    [menuView becomeSearchBar];
}

-(void) viewDidDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:UIKeyboardDidShowNotification];
    [[NSNotificationCenter defaultCenter] removeObserver:UIKeyboardWillHideNotification];
}

-(void) refreshPartnersByQuery:(NSString*)query
{
    [[TRSearchPartnersManager client] downloadPartnersListByString:query withSuccessOperation:^(LRRestyResponse *response, TRPartnersListModel *partnersList) {
        _partnersList = partnersList;
        [self.tableView reloadData];
    } andFailedOperation:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void) onBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) keyboardShown:(NSNotification *)note{
    
    CGRect keyboardFrame;
    [[[note userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] getValue:&keyboardFrame];
    
    CGRect tableViewFrame = self.tableView.frame ;
    tableViewFrame.size.height -= keyboardFrame.size.height ;
    [self.tableView setFrame:tableViewFrame];
}

- (void) keyboardHidden:(NSNotification *)note{
    
    [self.tableView setFrame: self.view.bounds];
}

#pragma mark - UIScrollViewDelegate Implementation

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [_scrollDownMindMenu scrollViewDidScroll:scrollView];
}

-(void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {
    [_scrollDownMindMenu scrollViewWillBeginDecelerating:scrollView];
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [menuView resignSearchBar];
    [_scrollDownMindMenu scrollViewWillBeginDragging:scrollView];
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [_scrollDownMindMenu scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    /*NSInteger sectionCount = 4;
    
    if(_partnersList.fio.count == 0)
        sectionCount--;
    if(_partnersList.cities.count == 0)
        sectionCount--;
    if(_partnersList.scope_work.count == 0)
        sectionCount--;
    if(_partnersList.interests.count == 0)
        sectionCount--;
    
	return sectionCount;*/
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    switch (section) {
        case 0:
            return _partnersList.fio.count;
            break;
        case 1:
            return _partnersList.cities.count;
            break;
        case 2:
            return _partnersList.scope_work.count;
            break;
        case 3:
            return _partnersList.interests.count;
            break;
    }
    return 0;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [headerTitles objectAtIndex:section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 59.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            if(_partnersList.fio.count == 0) return 0;
            break;
        case 1:
            if(_partnersList.cities.count == 0) return 0;
            break;
        case 2:
            if(_partnersList.scope_work.count == 0) return 0;
            break;
        case 3:
            if(_partnersList.interests.count == 0) return 0;
            break;
    }
    
    return 20.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *itemCellIdentifier = @"TRMindCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:itemCellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:itemCellIdentifier];
    }
    
    TRUserInfoModel *userInfo;
    
    switch (indexPath.section) {
        case 0:
            userInfo = [_partnersList.fio objectAtIndex:indexPath.row];
            break;
        case 1:
            userInfo = [_partnersList.cities objectAtIndex:indexPath.row];
            break;
        case 2:
            userInfo = [_partnersList.scope_work objectAtIndex:indexPath.row];
            break;
        case 3:
            userInfo = [_partnersList.interests objectAtIndex:indexPath.row];
            break;
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", userInfo.first_name, userInfo.last_name];
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
