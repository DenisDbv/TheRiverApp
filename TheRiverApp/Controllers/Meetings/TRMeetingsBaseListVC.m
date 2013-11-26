//
//  TRMeetingsBaseListVC.m
//  TheRiverApp
//
//  Created by DenisDbv on 13.09.13.
//  Copyright (c) 2013 axbx. All rights reserved.
//

#import "TRMeetingsBaseListVC.h"
#import "TRMeetingItemCell.h"
#import "TRMeetingDescriptionVC.h"

#import "WDActivityIndicator.h"

@interface TRMeetingsBaseListVC ()
@property (nonatomic, retain) WDActivityIndicator *activityIndicator;
@property (nonatomic, retain) TRMeetingListModel *_meetingList;
@end

@implementation TRMeetingsBaseListVC
{
    NSIndexPath *lastSelectedIndexPath;
}
@synthesize activityIndicator, _meetingList;

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
    
    [self.tableView registerNib:[UINib nibWithNibName:@"TRMeetingItemCell" bundle:nil] forCellReuseIdentifier:@"TRMeetingCell"];
    
    [self refreshMeetingList];
}

-(void) viewWillAppear:(BOOL)animated
{
    if(lastSelectedIndexPath != nil)
       [self.tableView reloadRowsAtIndexPaths:@[lastSelectedIndexPath] withRowAnimation:UITableViewRowAnimationNone];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void) refreshMeetingList
{
    if(activityIndicator == nil)    {
        activityIndicator = [[WDActivityIndicator alloc] initWithFrame:CGRectMake(self.view.bounds.size.width/2, (self.view.bounds.size.height-100)/2, 0, 0)];
        [activityIndicator setIndicatorStyle:WDActivityIndicatorStyleGradient];
        [self.view addSubview:activityIndicator];
        [activityIndicator startAnimating];
    }
    
    [[TRMeetingManager client] downloadMeetingList:^(LRRestyResponse *response, TRMeetingListModel *meetingList) {
        [self endRefreshMeetingList:meetingList];
    } andFailedOperation:^(LRRestyResponse *response) {
        [self endRefreshMeetingList:nil];
    }];
}

-(void) endRefreshMeetingList:(TRMeetingListModel*)list
{
    [activityIndicator stopAnimating];
    [activityIndicator removeFromSuperview];
    activityIndicator = nil;
    
    if(list != nil) {
        _meetingList = list;
        
        [self.tableView reloadData];
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return (NSInteger)_meetingList.events.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TRMeetingItemCell *meetCell = [[TRMeetingItemCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TRMeetingCell"];
    
    TREventModel *eventUnit = [_meetingList.events objectAtIndex:indexPath.row];
    
    return [meetCell getCellHeight:eventUnit];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *itemCellIdentifier = @"TRMeetingCell";
    TRMeetingItemCell *cell = [tableView dequeueReusableCellWithIdentifier:itemCellIdentifier];
    if (cell == nil) {
        cell = [[TRMeetingItemCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:itemCellIdentifier];
    }
    
    TREventModel *eventUnit = [_meetingList.events objectAtIndex:indexPath.row];
    
    [cell reloadWithMeetingModel:eventUnit];
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    lastSelectedIndexPath = indexPath;
    
    TREventModel *eventUnit = [_meetingList.events objectAtIndex:indexPath.row];
    
    TRMeetingDescriptionVC *descriptionUnit = [[TRMeetingDescriptionVC alloc] initByMindModel:eventUnit];
    [self.navigationController pushViewController:descriptionUnit animated:YES];
}

@end
