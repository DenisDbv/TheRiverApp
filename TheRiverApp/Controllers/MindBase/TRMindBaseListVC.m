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

#import "TRDescriptionUnitVC.h"

@interface TRMindBaseListVC ()

@end

@implementation TRMindBaseListVC

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return (NSInteger)[TRUserManager sharedInstance].mindObjects.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 109;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *itemCellIdentifier = @"TRMindCell";
    TRMindItemCell *cell = [tableView dequeueReusableCellWithIdentifier:itemCellIdentifier];
    if (cell == nil) {
        cell = [[TRMindItemCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:itemCellIdentifier];
    }
    
    TRMindModel *mindUnit = [[TRUserManager sharedInstance].mindObjects objectAtIndex:indexPath.row];
    
    [cell reloadWithMindModel:mindUnit];
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    TRDescriptionUnitVC *descriptionUnit = [[TRDescriptionUnitVC alloc] initByMindModel:[[TRUserManager sharedInstance].mindObjects objectAtIndex:indexPath.row]];
    [self.navigationController pushViewController:descriptionUnit animated:YES];
    
    /*SSWebViewController *webController = [[SSWebViewController alloc] init];
    [webController loadURL:[NSURL URLWithString:@"http://zomgg.ru/ios/oksana_kopylova/"]];
    [AppDelegateInstance() changeCenterViewController:webController];*/
}


@end
