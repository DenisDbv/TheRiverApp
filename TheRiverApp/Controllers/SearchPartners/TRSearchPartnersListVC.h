//
//  TRSearchPartnersListVC.h
//  TheRiverApp
//
//  Created by DenisDbv on 27.09.13.
//  Copyright (c) 2013 axbx. All rights reserved.
//

#import "TRCenterRootController.h"

@interface TRSearchPartnersListVC : UIViewController

@property (nonatomic, retain) IBOutlet UITableView *tableView;

-(void) refreshPartnersByQuery:(NSString*)query;

@end
