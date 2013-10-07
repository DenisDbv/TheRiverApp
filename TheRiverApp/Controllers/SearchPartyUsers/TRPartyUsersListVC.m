//
//  TRPartyUsersListVC.m
//  TheRiverApp
//
//  Created by DenisDbv on 24.09.13.
//  Copyright (c) 2013 axbx. All rights reserved.
//

#import "TRPartyUsersListVC.h"
#import "WDActivityIndicator.h"
#import "TRSearchPUsersCell.h"
#import "TRPartyUsersFilter.h"

#import <SDWebImage/UIImageView+WebCache.h>
#import <UIActivityIndicator-for-SDWebImage/UIImageView+UIActivityIndicatorForSDWebImage.h>
#import "SlideInMenuViewController.h"

@interface TRPartyUsersListVC ()
@property (nonatomic, retain) WDActivityIndicator *activityIndicator;
@property (nonatomic, retain) SlideInMenuViewController *scrollDownMindMenu;
@property (nonatomic, retain) TRPUserListModel *_userList;
@end

@implementation TRPartyUsersListVC
{
    NSString *citySearchString;
    NSString *industrySearchString;
}
@synthesize activityIndicator;
@synthesize _userList;

-(id) initPUSearchByCity:(NSString*)cityName
             andIndustry:(NSString*)industryName
{
    self = [super initWithNibName:@"TRPartyUsersListVC" bundle:[NSBundle mainBundle]];
    if (self) {
        citySearchString = cityName;
        industrySearchString = industryName;
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        citySearchString = @"";
        industrySearchString = @"";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationController.navigationBar.translucent = NO;
    
    TRPartyUsersFilter *menuView = [[TRPartyUsersFilter alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 50) byRootTarget:self];
    menuView.backgroundColor = [UIColor whiteColor]; //self.tableView.separatorColor;
    _scrollDownMindMenu = [[SlideInMenuViewController alloc] initWithMenuView: menuView];
    
    [self.tableView addSubview: _scrollDownMindMenu.view];
    [self.tableView setContentInset:UIEdgeInsetsMake(menuView.frame.size.height, 0, 0, 0)];
    [self.tableView setScrollIndicatorInsets:UIEdgeInsetsMake(menuView.frame.size.height, 0, 0, 0)];
    
    [self refreshUserListByCity:citySearchString andIndustry:industrySearchString];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [_scrollDownMindMenu scrollViewDidScroll:scrollView];
}

-(void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {
    [_scrollDownMindMenu scrollViewWillBeginDecelerating:scrollView];
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [_scrollDownMindMenu scrollViewWillBeginDragging:scrollView];
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [_scrollDownMindMenu scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
}

-(void) refreshUserListByCity:(NSString*)cityName
                  andIndustry:(NSString*)industryName
{
    _userList.user = [NSArray array];
    [self.tableView reloadData];
    
    if(activityIndicator == nil)    {
        activityIndicator = [[WDActivityIndicator alloc] initWithFrame:CGRectMake(self.view.bounds.size.width/2, (self.view.bounds.size.height-100)/2, 0, 0)];
        [activityIndicator setIndicatorStyle:WDActivityIndicatorStyleGradient];
        [self.view addSubview:activityIndicator];
        [activityIndicator startAnimating];
    }
    
    [[TRSearchPUManager client] downloadUsersListByCity:cityName andIndustry:industryName withSuccessOperation:^(LRRestyResponse *response, TRPUserListModel *usersList) {
        [self endRefreshUserList:usersList];
    } andFailedOperation:^(LRRestyResponse *response) {
        //
    }];
}

-(void) endRefreshUserList:(TRPUserListModel*)list
{
    [activityIndicator stopAnimating];
    [activityIndicator removeFromSuperview];
    activityIndicator = nil;
    
    _userList = list;
    
    [self.tableView reloadData];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _userList.user.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 59.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *itemCellIdentifier = @"TRMindCell";
    TRSearchPUsersCell *cell = [tableView dequeueReusableCellWithIdentifier:itemCellIdentifier];
    if (cell == nil) {
        cell = [[TRSearchPUsersCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:itemCellIdentifier];
    }
    
    TRUserInfoModel *userInfo = [_userList.user objectAtIndex:indexPath.row];
    
    [cell reloadWithModel:userInfo];
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    TRUserInfoModel *userInfo = [_userList.user objectAtIndex:indexPath.row];
    
    TRUserProfileController *userProfileVC = [[TRUserProfileController alloc] initByUserModel:userInfo isIam:NO];
    [AppDelegateInstance() changeProfileViewController:userProfileVC];
}

@end
