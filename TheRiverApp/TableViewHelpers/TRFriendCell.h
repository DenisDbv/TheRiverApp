//
//  TRFriendCell.h
//  TheRiverApp
//
//  Created by DenisDbv on 10.09.13.
//  Copyright (c) 2013 axbx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TRFriendCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UIImageView *friendLogo;
@property (nonatomic, strong) IBOutlet UILabel *friendName;
@property (nonatomic, strong) IBOutlet UILabel *friendCurrentBusiness;

@end
