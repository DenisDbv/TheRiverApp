//
//  TRPartyUsersListVC.h
//  TheRiverApp
//
//  Created by DenisDbv on 24.09.13.
//  Copyright (c) 2013 axbx. All rights reserved.
//

#import "TRCenterRootController.h"

@interface TRPartyUsersListVC : TRCenterRootController

@property (nonatomic, retain) IBOutlet UITableView *tableView;

-(void) refreshUserListByCity:(NSString*)cityName andIndustry:(NSString*)industryName;

@end
