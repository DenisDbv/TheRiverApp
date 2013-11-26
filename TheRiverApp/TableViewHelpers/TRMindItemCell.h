//
//  TRMindItemCell.h
//  TheRiverApp
//
//  Created by DenisDbv on 08.09.13.
//  Copyright (c) 2013 axbx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TRMindItemCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UIImageView *logo;
@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) IBOutlet UILabel *descLabel;

-(void) reloadWithMindModel:(TRMindItem*)mindObject;

-(CGFloat) getCellHeight:(TRMindItem*)mindItem;

@end
