//
//  TRSearchPartnersCell.h
//  TheRiverApp
//
//  Created by DenisDbv on 28.09.13.
//  Copyright (c) 2013 axbx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <TTTAttributedLabel/TTTAttributedLabel.h>

typedef enum {
    textFio = 0,
    textCity,
    textScopeWork,
    textInterests
} PartnersFilterType;

@interface TRSearchPartnersCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UIImageView *avatarImageView;
@property (nonatomic, strong) IBOutlet TTTAttributedLabel *fioLabel;
@property (nonatomic, strong) IBOutlet TTTAttributedLabel *subTextLabel;
@property (nonatomic, strong) IBOutlet UILabel *typeSubTextLabel;

-(void) setCellFio:(NSString*)fioText
           subText:(NSString*)subText
       typeSubText:(PartnersFilterType)filterType
         withQuery:(NSString*)query;

@end
