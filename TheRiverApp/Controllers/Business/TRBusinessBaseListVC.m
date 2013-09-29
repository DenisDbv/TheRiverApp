//
//  TRBusinessBaseListVC.m
//  TheRiverApp
//
//  Created by DenisDbv on 09.09.13.
//  Copyright (c) 2013 axbx. All rights reserved.
//

#import "TRBusinessBaseListVC.h"
#import "TRBusinessItemCell.h"
#import "TRBusinessDescriptionVC.h"

#import "WDActivityIndicator.h"

@interface TRBusinessBaseListVC ()
@property (nonatomic, retain) WDActivityIndicator *activityIndicator;
@property (nonatomic, retain) TRBusinessRootModel *_businessList;
@end

@implementation TRBusinessBaseListVC
@synthesize activityIndicator;
@synthesize _businessList;

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
    
    [self.tableView registerNib:[UINib nibWithNibName:@"TRBusinessItemCell" bundle:nil] forCellReuseIdentifier:@"TRBusinessCell"];
}

-(void) viewWillAppear:(BOOL)animated
{
    self.tableView.backgroundColor = [UIColor colorWithRed:206.0/255.0 green:206.0/255.0 blue:206.0/255.0 alpha:1.0];
    
    [self refreshBusinessList];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) refreshBusinessList
{
    if(activityIndicator == nil)    {
        activityIndicator = [[WDActivityIndicator alloc] initWithFrame:CGRectMake(self.view.bounds.size.width/2, (self.view.bounds.size.height-100)/2, 0, 0)];
        [activityIndicator setIndicatorStyle:WDActivityIndicatorStyleGradient];
        [self.view addSubview:activityIndicator];
        [activityIndicator startAnimating];
    }
    
    [[TRBusinessManager client] downloadBusinessList:^(LRRestyResponse *response, TRBusinessRootModel *businessList) {
        [self endRefreshUserList:businessList];
    } andFailedOperation:^(LRRestyResponse *response) {
        //
    }];
}

-(void) endRefreshUserList:(TRBusinessRootModel*)list
{
    [activityIndicator stopAnimating];
    [activityIndicator removeFromSuperview];
    activityIndicator = nil;
    
    _businessList = list;
    
    [self.tableView reloadData];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return _businessList.business.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 285;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.backgroundView = [[UIView alloc] initWithFrame:cell.bounds];
    cell.backgroundView.backgroundColor = [UIColor whiteColor];
    
    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:cell.bounds];
    cell.selectedBackgroundView.backgroundColor = [UIColor blueColor];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *itemCellIdentifier = @"TRBusinessCell";
    TRBusinessItemCell *cell = [tableView dequeueReusableCellWithIdentifier:itemCellIdentifier];
    if (cell == nil) {
        cell = [[TRBusinessItemCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:itemCellIdentifier];
    }
    
    TRBusinessModel *businessUnit = [_businessList.business objectAtIndex: indexPath.section];
    [cell reloadWithBusinessModel:businessUnit];
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    //TRBusinessDescriptionVC *descriptionUnit = [[TRBusinessDescriptionVC alloc] initByMindModel:[[TRUserManager sharedInstance].businessObjects objectAtIndex:indexPath.section]];
    //[self.navigationController pushViewController:descriptionUnit animated:YES];
}

@end
