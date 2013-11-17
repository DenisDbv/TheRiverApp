//
//  TRNewsCell.h
//  TheRiverApp
//
//  Created by DenisDbv on 14.11.13.
//  Copyright (c) 2013 axbx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TRNewsCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UIImageView *newsLogo;
@property (nonatomic, strong) IBOutlet UILabel *newsTitle;
@property (nonatomic, strong) IBOutlet UILabel *newsTime;
@property (nonatomic, strong) IBOutlet UILabel *newsDesc;

-(void) reloadWithNewsItem:(TRNewsItem*)newsItem;
-(CGFloat) getCellHeight:(TRNewsItem*)newsItem;

@end
