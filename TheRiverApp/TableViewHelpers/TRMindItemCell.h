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
@property (nonatomic, weak) IBOutlet UILabel *authorNameLabel;
@property (nonatomic, weak) IBOutlet UILabel *dateCreateLabel;
@property (nonatomic, weak) IBOutlet UIView *levelView;
@property (nonatomic, weak) IBOutlet UILabel *ratingLabel;

-(void) reloadWithMindModel:(TRMindModel*)mindObject;

@end
