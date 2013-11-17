//
//  TRNewsListVC.m
//  TheRiverApp
//
//  Created by DenisDbv on 14.11.13.
//  Copyright (c) 2013 axbx. All rights reserved.
//

#import "TRNewsListVC.h"
#import <SVPullToRefresh/SVPullToRefresh.h>
#import "TRNewsCell.h"
#import "TRNewsDescVC.h"

@interface TRNewsListVC ()
@property (nonatomic) NSInteger _pageIndex;
@property (nonatomic) NSInteger _maxPages;
@property (nonatomic, strong) NSMutableArray *newsItemArray;
@end

@implementation TRNewsListVC
@synthesize _pageIndex, _maxPages;
@synthesize newsItemArray;

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
    
    [self.tableView registerNib:[UINib nibWithNibName:@"TRNewsCell" bundle:nil] forCellReuseIdentifier:@"TRNewsCell"];
    
    self.navigationController.navigationBar.translucent = NO;
    
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleHeight;
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    
    newsItemArray = [[NSMutableArray alloc] init];
    
    _pageIndex = 1;
    _maxPages = 1;
    
    __weak TRNewsListVC *weakSelf = self;
    
    // setup pull-to-refresh
    [self.tableView addPullToRefreshWithActionHandler:^{
        //weakSelf.newsItemArray = [[NSMutableArray alloc] init];
        weakSelf._pageIndex = 1;
        //[weakSelf.tableView reloadData];
        weakSelf.tableView.showsInfiniteScrolling = YES;
        [weakSelf refreshNewsByPage:1];
    }];
    
    // setup infinite scrolling
    [self.tableView addInfiniteScrollingWithActionHandler:^{
        if(weakSelf._pageIndex < weakSelf._maxPages) {
            [weakSelf refreshNewsByPage: ++weakSelf._pageIndex];
        } else {
            [weakSelf.tableView.infiniteScrollingView stopAnimating];
            weakSelf.tableView.showsInfiniteScrolling = NO;
        }
    }];
    
    [self.tableView triggerPullToRefresh];
}

- (void)viewDidAppear:(BOOL)animated
{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void) refreshNewsByPage:(NSInteger)pageIndex
{
    [[TRNewsManager client] downloadNewsListByPage:pageIndex successOperation:^(LRRestyResponse *response, TRNewsModel *newsModel) {
        [self endRefreshNewsList:newsModel byPageIndex:pageIndex];
    } andFailedOperation:^(LRRestyResponse *response) {
        [self endRefreshNewsList:nil byPageIndex:pageIndex];
    }];
}

-(void) endRefreshNewsList:(TRNewsModel*)newsModel byPageIndex:(NSInteger)pageIndex
{
    if(pageIndex == 1)  {
        [self.tableView.pullToRefreshView stopAnimating];
    } else  {
        [self.tableView.infiniteScrollingView stopAnimating];
    }
    
    if(newsModel.news.count > 0)    {
        _maxPages = [newsModel.num_pages integerValue];
        
        if(pageIndex == 1)  {
            newsItemArray = [[NSMutableArray alloc] init];
        }
        
        [newsItemArray addObjectsFromArray:newsModel.news];
        
        [self.tableView reloadData];
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return newsItemArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TRNewsCell *cell = [[TRNewsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TRNewsCell"];
    TRNewsItem *item = [newsItemArray objectAtIndex:indexPath.row];
    
    return [cell getCellHeight:item];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *itemCellIdentifier = @"TRNewsCell";
    TRNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:itemCellIdentifier];
    if (cell == nil) {
        cell = [[TRNewsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:itemCellIdentifier];
    }
    
    TRNewsItem *item = [newsItemArray objectAtIndex:indexPath.row];
    [cell reloadWithNewsItem:item];
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    TRNewsItem *item = [newsItemArray objectAtIndex:indexPath.row];
    
    TRNewsDescVC *newsDescVC = [[TRNewsDescVC alloc] initByNewsItem:item];
    [self.navigationController pushViewController:newsDescVC animated:YES];
}

@end
