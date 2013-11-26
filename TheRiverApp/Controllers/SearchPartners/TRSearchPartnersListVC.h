//
//  TRSearchPartnersListVC.h
//  TheRiverApp
//
//  Created by DenisDbv on 27.09.13.
//  Copyright (c) 2013 axbx. All rights reserved.
//

#import "TRCenterRootController.h"
#import "TRPartnersSearchView.h"

@interface TRSearchPartnersListVC : UIViewController <TRPartnersSearchViewDelegate>

@property (nonatomic, retain) IBOutlet UITableView *tableView;

-(id) initVCByQuery:(NSString*)query;

-(void) refreshPartnersByQuery:(NSString*)query;

@end
