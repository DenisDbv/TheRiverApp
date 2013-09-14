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

@interface TRBusinessBaseListVC ()

@end

@implementation TRBusinessBaseListVC

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return (NSInteger)[TRUserManager sharedInstance].businessObjects.count;
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
    
    TRBusinessModel *businessUnit = [[TRUserManager sharedInstance].businessObjects objectAtIndex: indexPath.section];
    
    [cell reloadWithBusinessModel:businessUnit];
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    TRBusinessDescriptionVC *descriptionUnit = [[TRBusinessDescriptionVC alloc] initByMindModel:[[TRUserManager sharedInstance].businessObjects objectAtIndex:indexPath.section]];
    [self.navigationController pushViewController:descriptionUnit animated:YES];
}

@end
