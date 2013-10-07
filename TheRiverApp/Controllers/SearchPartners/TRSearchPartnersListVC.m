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
#import "TRSearchPartnersCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <UIActivityIndicator-for-SDWebImage/UIImageView+UIActivityIndicatorForSDWebImage.h>
#import "MFSideMenu.h"

@interface TRSearchPartnersListVC ()
@property (nonatomic, retain) TRPartnersSearchView *menuView;
@property (nonatomic, retain) SlideInMenuViewController *scrollDownMindMenu;

@property (nonatomic, retain) TRPartnersListModel *_partnersList;
@end

@implementation TRSearchPartnersListVC
{
    NSArray *headerTitles;
    NSString *queryString;
}
@synthesize menuView;
@synthesize _partnersList;

-(id) initVCByQuery:(NSString*)query
{
    self = [super initWithNibName:@"TRSearchPartnersListVC" bundle:[NSBundle mainBundle]];
    if (self) {
        queryString = query;
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        queryString = @"";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationController.navigationBar.translucent = NO;
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self addSwipeGestureRecognizer];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"TRSearchPartnersCell" bundle:nil] forCellReuseIdentifier:@"TRSearchPartnersCell"];
    
    headerTitles = @[@"ФИО", @"Город", @"Отрасли", @"Высокое разрешение"];
    
    UIBarButtonItem *onCancelButton = [UIBarButtonItem barItemWithImage:[UIImage imageNamed:@"toolbar-back-button@2x.png"] target:self action:@selector(onBack)];
    [onCancelButton setBackgroundImage:[UIImage new] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [self.navigationItem setLeftBarButtonItem:onCancelButton animated:YES];
    
    
    /*_scrollDownMindMenu = [[SlideInMenuViewController alloc] initWithMenuView: menuView];
    
    [self.tableView addSubview: _scrollDownMindMenu.view];
    [self.tableView setContentInset:UIEdgeInsetsMake(menuView.frame.size.height, 0, 0, 0)];
    [self.tableView setScrollIndicatorInsets:UIEdgeInsetsMake(menuView.frame.size.height, 0, 0, 0)];*/
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShown:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHidden:) name:UIKeyboardWillHideNotification object:nil];
}

-(void) viewWillAppear:(BOOL)animated
{
    menuView = [[TRPartnersSearchView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 50) byRootTarget:self];
    menuView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:menuView];

    self.menuContainerViewController.panMode = MFSideMenuPanModeNone;
    
    self.tableView.frame = CGRectMake(0, 50, self.view.bounds.size.width, self.view.bounds.size.height-50);
    
    if(queryString.length > 0)  {
        [menuView setTextToSearchLabel:queryString];
        [self refreshPartnersByQuery:queryString];
    }
}

-(void) viewDidAppear:(BOOL)animated
{
    [menuView becomeSearchBar];
}

-(void) viewWillDisappear:(BOOL)animated
{
    self.menuContainerViewController.panMode = MFSideMenuPanModeDefault;
    
    [menuView resignSearchBar];
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

#pragma mark - Swipe gesture

- (void)addSwipeGestureRecognizer
{
    UISwipeGestureRecognizer *swipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeRecognized:)];
    [self.view addGestureRecognizer:swipeGestureRecognizer];
}

- (void)swipeRecognized:(UISwipeGestureRecognizer *)gestureRecognizer
{
    if (gestureRecognizer.state == UIGestureRecognizerStateEnded &&
        gestureRecognizer.direction & UISwipeGestureRecognizerDirectionRight) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void) keyboardShown:(NSNotification *)note{
    
    CGRect keyboardFrame;
    [[[note userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] getValue:&keyboardFrame];
    
    CGRect tableViewFrame = self.tableView.frame ;
    tableViewFrame.size.height -= keyboardFrame.size.height ;
    [self.tableView setFrame:tableViewFrame];
}

- (void) keyboardHidden:(NSNotification *)note{
    
    [self.tableView setFrame: CGRectMake(0, 50, self.view.bounds.size.width, self.view.bounds.size.height-50)]; //self.view.bounds];
}

#pragma mark - UIScrollViewDelegate Implementation

/*- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
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
}*/

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [menuView resignSearchBar];
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
            return _partnersList.industries.count;
            break;
        case 3:
            return _partnersList.interests.count;
            break;
    }
    return 0;
}

/*- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [headerTitles objectAtIndex:section];
}*/

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 30)];
    headerView.backgroundColor = [UIColor colorWithRed:173.0/255.0 green:173.0/255.0 blue:173.0/255.0 alpha:1.0];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, tableView.bounds.size.width-20, 30)];
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont fontWithName:@"HelveticaNeueCyr-Roman" size:14.5];
    label.text = [headerTitles objectAtIndex:section];
    
    [headerView addSubview:label];
    
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 59.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            //if(_partnersList.fio.count == 0) return 0;
            return 0;
            break;
        case 1:
            if(_partnersList.cities.count == 0) return 0;
            else return 30;
            break;
        case 2:
            if(_partnersList.industries.count == 0) return 0;
            else return 30;
            break;
        case 3:
            if(_partnersList.interests.count == 0) return 0;
            else return 30;
            break;
    }
    
    return 20.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *itemCellIdentifier = @"TRSearchPartnersCell";
    TRSearchPartnersCell *cell = [tableView dequeueReusableCellWithIdentifier:itemCellIdentifier];
    if (cell == nil) {
        cell = [[TRSearchPartnersCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:itemCellIdentifier];
    }
    
    TRUserInfoModel *userInfo;
    NSString *subTextTitle;
    PartnersFilterType filterType;
    
    switch (indexPath.section) {
        case 0:
            userInfo = [_partnersList.fio objectAtIndex:indexPath.row];
            subTextTitle = @"";
            filterType = textFio;
            break;
        case 1:
            userInfo = [_partnersList.cities objectAtIndex:indexPath.row];
            subTextTitle = userInfo.city;
            filterType = textCity;
            break;
        case 2:
            userInfo = [_partnersList.industries objectAtIndex:indexPath.row];
            subTextTitle = [self getMutchScopeWork:userInfo.business.industries byQueryString:_partnersList.query];
            filterType = textScopeWork;
            break;
        case 3:
            userInfo = [_partnersList.interests objectAtIndex:indexPath.row];
            subTextTitle = [self getMutchHightResolution:userInfo.interests byQueryString:_partnersList.query];
            filterType = textInterests;
            break;
    }
    
    NSString *logoURLString = [SERVER_HOSTNAME stringByAppendingString:userInfo.logo];
    
    [cell reloadWithData:logoURLString
                 fioText:[NSString stringWithFormat:@"%@ %@", userInfo.first_name, userInfo.last_name]
             subText:subTextTitle
         typeSubText:filterType
           withQuery:_partnersList.query];
    
    return cell;
}

-(NSString*) getMutchScopeWork:(NSArray*)scopesArray byQueryString:(NSString*)query
{
    __block NSString *scopeMutch = @"-";
    [scopesArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        TRBusinessScopeModel *scopeModel = obj;
        if ([scopeModel.name rangeOfString:query options:NSCaseInsensitiveSearch].location != NSNotFound)
        {
            scopeMutch = scopeModel.name;
            *stop = YES;
        }
    }];
    
    return scopeMutch;
}

-(NSString*) getMutchHightResolution:(NSArray*)resolutionArray byQueryString:(NSString*)query
{
    __block NSString *resolutionMutch = @"-";
    [resolutionArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        TRUserResolutionModel *resolutionModel = obj;
        if ([resolutionModel.name rangeOfString:query options:NSCaseInsensitiveSearch].location != NSNotFound)
        {
            resolutionMutch = resolutionModel.name;
            *stop = YES;
        }
    }];
    
    return resolutionMutch;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    self.menuContainerViewController.panMode = MFSideMenuPanModeDefault;
    
    TRUserInfoModel *userInfo;
    switch (indexPath.section) {
        case 0:
            userInfo = [_partnersList.fio objectAtIndex:indexPath.row];
            break;
        case 1:
            userInfo = [_partnersList.cities objectAtIndex:indexPath.row];
            break;
        case 2:
            userInfo = [_partnersList.industries objectAtIndex:indexPath.row];
            break;
        case 3:
            userInfo = [_partnersList.interests objectAtIndex:indexPath.row];
            break; 
    }
    
    TRUserProfileController *userProfileVC = [[TRUserProfileController alloc] initByUserModel:userInfo isIam:NO];
    [AppDelegateInstance() changeProfileViewController:userProfileVC];
}

@end
