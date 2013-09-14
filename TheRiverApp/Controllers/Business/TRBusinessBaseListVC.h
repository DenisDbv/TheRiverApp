//
//  TRBusinessBaseListVC.h
//  TheRiverApp
//
//  Created by DenisDbv on 09.09.13.
//  Copyright (c) 2013 axbx. All rights reserved.
//

#import "TRCenterRootController.h"

@interface TRBusinessBaseListVC : TRCenterRootController <UIScrollViewDelegate>

@property (nonatomic, retain) IBOutlet UITableView *tableView;

@end
