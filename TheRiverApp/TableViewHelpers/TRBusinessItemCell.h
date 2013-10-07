//
//  TRBusinessItemCell.h
//  TheRiverApp
//
//  Created by DenisDbv on 09.09.13.
//  Copyright (c) 2013 axbx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SSToolkit/SSToolkit.h>

@interface TRBusinessItemCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UIImageView *logo;
@property (nonatomic, weak) IBOutlet UILabel *title;
@property (nonatomic, weak) IBOutlet UILabel *subTitle;

@property (nonatomic, retain) IBOutlet SSGradientView *layerView;
@property (nonatomic, retain) IBOutlet SSGradientView *layerView2;
@property (nonatomic, retain) IBOutlet UILabel *layerShortTitleLabel;
@property (nonatomic, retain) IBOutlet UILabel *layerAfterLabel;

-(void) reloadWithBusinessModel:(TRBusinessModel*)businessObject;

@end
