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

@interface TRMeetingsBaseListVC ()

@end

@implementation TRMeetingsBaseListVC

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20; //(NSInteger)[TRUserManager sharedInstance].meetingObjects.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 114;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *itemCellIdentifier = @"TRMeetingCell";
    TRMeetingItemCell *cell = [tableView dequeueReusableCellWithIdentifier:itemCellIdentifier];
    if (cell == nil) {
        cell = [[TRMeetingItemCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:itemCellIdentifier];
    }
    
    TRMeetingModel *meetUnit = [[TRUserManager sharedInstance].meetingObjects objectAtIndex:0];
    
    [cell reloadWithMeetingModel:meetUnit];
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    TRMeetingDescriptionVC *descriptionUnit = [[TRMeetingDescriptionVC alloc] initByMindModel:[[TRUserManager sharedInstance].meetingObjects objectAtIndex:0]];
    [self.navigationController pushViewController:descriptionUnit animated:YES];
}

@end
