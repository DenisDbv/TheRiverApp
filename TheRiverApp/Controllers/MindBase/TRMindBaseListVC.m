//
//  TRMindBaseListVC.m
//  TheRiverApp
//
//  Created by DenisDbv on 08.09.13.
//  Copyright (c) 2013 axbx. All rights reserved.
//

#import "TRMindBaseListVC.h"
#import "TRMindItemCell.h"
#import <QuartzCore/QuartzCore.h>
#import <SSToolkit/SSToolkit.h>

#import "SlideInMenuViewController.h"
#import "TRDescriptionUnitVC.h"
#import "TRMindFilterView.h"

#import <SVPullToRefresh/SVPullToRefresh.h>
#import "WDActivityIndicator.h"

@interface TRMindBaseListVC ()
@property (nonatomic, retain) TRPartnersSearchView *menuView;
@property (nonatomic, retain) WDActivityIndicator *activityIndicator;
@property (nonatomic, retain) SlideInMenuViewController *scrollDownMindMenu;
@property (nonatomic) NSInteger _pageIndex;
@property (nonatomic) NSInteger _maxPages;
@property (nonatomic, strong) NSMutableArray *mindItemArray;
@end

@implementation TRMindBaseListVC
@synthesize menuView;
@synthesize _pageIndex, _maxPages, mindItemArray;
@synthesize activityIndicator;

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
    
    self.navigationController.navigationBar.clipsToBounds = YES;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"TRMindItemCell" bundle:nil] forCellReuseIdentifier:@"TRMindCell"];
    
    self.navigationController.navigationBar.translucent = NO;
    
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleHeight;
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    
    menuView = [[TRPartnersSearchView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 50) byRootTarget:self];
    menuView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:menuView];
    self.tableView.frame = CGRectMake(0, 50, self.view.bounds.size.width, self.view.bounds.size.height-50);
    
    mindItemArray = [[NSMutableArray alloc] init];
    
    _pageIndex = 1;
    _maxPages = 1;
    
    __weak TRMindBaseListVC *weakSelf = self;
    
    [self.tableView addInfiniteScrollingWithActionHandler:^{
        if(weakSelf._pageIndex < weakSelf._maxPages) {
            [weakSelf refreshMindByPage: ++weakSelf._pageIndex withActivity:NO];
        } else {
            [weakSelf.tableView.infiniteScrollingView stopAnimating];
            weakSelf.tableView.showsInfiniteScrolling = NO;
        }
    }];
    
    /*TRMindFilterView *menuView = [[TRMindFilterView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 50) byRootTarget:self];
    menuView.backgroundColor = [UIColor whiteColor];
    _scrollDownMindMenu = [[SlideInMenuViewController alloc] initWithMenuView: menuView];
    
    [self.tableView addSubview: _scrollDownMindMenu.view];
    [self.tableView setContentInset:UIEdgeInsetsMake(menuView.frame.size.height, 0, 0, 0)];
    [self.tableView setScrollIndicatorInsets:UIEdgeInsetsMake(menuView.frame.size.height, 0, 0, 0)];*/
    
    [self refreshMindByPage:1 withActivity:YES];
}

-(void) viewWillAppear:(BOOL)animated
{
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShown:) name:UIKeyboardDidShowNotification object:nil];
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHidden:) name:UIKeyboardWillHideNotification object:nil];
}

-(void) viewWillDisappear:(BOOL)animated
{
    //[[NSNotificationCenter defaultCenter] removeObserver:UIKeyboardDidShowNotification];
    //[[NSNotificationCenter defaultCenter] removeObserver:UIKeyboardWillHideNotification];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*- (void) keyboardShown:(NSNotification *)note{
    
    CGRect keyboardFrame;
    [[[note userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] getValue:&keyboardFrame];
    
    CGRect tableViewFrame = self.tableView.frame ;
    tableViewFrame.size.height -= keyboardFrame.size.height ;
    [self.tableView setFrame:tableViewFrame];
}

- (void) keyboardHidden:(NSNotification *)note{
    
    [self.tableView setFrame: CGRectMake(0, 50, self.view.bounds.size.width, self.view.bounds.size.height-50)]; //self.view.bounds];
}*/

-(void) refreshPartnersByQuery:(NSString*)query
{
    _pageIndex = 1;
    _maxPages = 1;
    [mindItemArray removeAllObjects];
    [self.tableView reloadData];
    self.tableView.showsInfiniteScrolling = YES;

    if(activityIndicator == nil)    {
        activityIndicator = [[WDActivityIndicator alloc] initWithFrame:CGRectMake(self.view.bounds.size.width/2, (self.view.bounds.size.height-100)/2, 0, 0)];
        [activityIndicator setIndicatorStyle:WDActivityIndicatorStyleGradient];
        [self.view addSubview:activityIndicator];
        [activityIndicator startAnimating];
    }
    
    [[TRMindManager client] downloadMindListByString:query withSuccessOperation:^(LRRestyResponse *response, TRMindModel *mindModel) {
        [self endRefreshMindList:mindModel byPageIndex:1];
    } andFailedOperation:^(LRRestyResponse *response) {
        [self endRefreshMindList:nil byPageIndex:1];
    }];
}

-(void) refreshPartnersByClearQuery
{
    _pageIndex = 1;
    _maxPages = 1;
    
    [mindItemArray removeAllObjects];
    [self.tableView reloadData];
    
    [self refreshMindByPage:1 withActivity:YES];
}

-(void) refreshMindByPage:(NSInteger)pageIndex withActivity:(BOOL)activity
{
    self.tableView.showsInfiniteScrolling = YES;
    
    if(activityIndicator == nil && activity == YES)    {
        activityIndicator = [[WDActivityIndicator alloc] initWithFrame:CGRectMake(self.view.bounds.size.width/2, (self.view.bounds.size.height-100)/2, 0, 0)];
        [activityIndicator setIndicatorStyle:WDActivityIndicatorStyleGradient];
        [self.view addSubview:activityIndicator];
        [activityIndicator startAnimating];
    }
    
    [[TRMindManager client] downloadMindListByPage:pageIndex successOperation:^(LRRestyResponse *response, TRMindModel *mindModel) {
        [self endRefreshMindList:mindModel byPageIndex:pageIndex];
    } andFailedOperation:^(LRRestyResponse *response) {
        [self endRefreshMindList:nil byPageIndex:pageIndex];
    }];
}

-(void) endRefreshMindList:(TRMindModel*)mindModel byPageIndex:(NSInteger)pageIndex
{
    [activityIndicator stopAnimating];
    [activityIndicator removeFromSuperview];
    activityIndicator = nil;
    
    if(pageIndex > 1)   {
        [self.tableView.infiniteScrollingView stopAnimating];
    }
    
    if(mindModel.bd.count > 0)    {
        _maxPages = [mindModel.num_pages integerValue];
        NSLog(@"start page = %i, max page = %i", _pageIndex, _maxPages);
        if(pageIndex == 1)  {
            mindItemArray = [[NSMutableArray alloc] init];
        }
        
        [mindItemArray addObjectsFromArray:mindModel.bd];
        
        [self.tableView reloadData];
    }
}

#pragma mark - UITableViewDataSource

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [menuView resignSearchBar];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return (NSInteger)mindItemArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TRMindItemCell *cell = [[TRMindItemCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TRMindCell_test"];
    TRMindItem *mindUnit = [mindItemArray objectAtIndex:indexPath.row];
    
    return [cell getCellHeight:mindUnit];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *itemCellIdentifier = @"TRMindCell";
    TRMindItemCell *cell = [tableView dequeueReusableCellWithIdentifier:itemCellIdentifier];
    if (cell == nil) {
        cell = [[TRMindItemCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:itemCellIdentifier];
    }
    
    TRMindItem *mindUnit = [mindItemArray objectAtIndex:indexPath.row];
    
    [cell reloadWithMindModel:mindUnit];
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    TRMindItem *mindUnit = [mindItemArray objectAtIndex:indexPath.row];
    
    TRDescriptionUnitVC *descriptionUnit = [[TRDescriptionUnitVC alloc] initByMindModel:mindUnit.id];
    [self.navigationController pushViewController:descriptionUnit animated:YES];
}


@end
