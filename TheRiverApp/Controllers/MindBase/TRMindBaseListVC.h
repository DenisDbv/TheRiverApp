//
//  TRMindBaseListVC.h
//  TheRiverApp
//
//  Created by DenisDbv on 08.09.13.
//  Copyright (c) 2013 axbx. All rights reserved.
//

#import "TRCenterRootController.h"
#import "TRPartnersSearchView.h"

@interface TRMindBaseListVC : TRCenterRootController <TRPartnersSearchViewDelegate>

@property (nonatomic, retain) IBOutlet UITableView *tableView;

@end
