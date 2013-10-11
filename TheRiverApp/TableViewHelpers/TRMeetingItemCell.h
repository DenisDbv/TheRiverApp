//
//  TRMeetingItemCell.h
//  TheRiverApp
//
//  Created by DenisDbv on 13.09.13.
//  Copyright (c) 2013 axbx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ACPButton/ACPButton.h>

@interface TRMeetingItemCell : UITableViewCell

@property (nonatomic, retain) IBOutlet UILabel *labelDay;
@property (nonatomic, retain) IBOutlet UILabel *labelMonth;
@property (nonatomic, retain) IBOutlet UILabel *labelCity;
@property (nonatomic, retain) IBOutlet UILabel *labelTitle;
@property (nonatomic, retain) IBOutlet UILabel *labelGroup;
@property (nonatomic, retain) IBOutlet ACPButton *agreeButton;
@property (nonatomic, retain) IBOutlet UILabel *labelIfDisable;

-(void) reloadWithMeetingModel:(TREventModel*)meetingObject;

-(CGFloat) getCellHeight:(TREventModel*)meetingObject;

@end
