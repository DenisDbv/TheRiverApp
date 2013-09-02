//
//  TRSectionHeaderView.h
//  TheRiverApp
//
//  Created by DenisDbv on 02.09.13.
//  Copyright (c) 2013 axbx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TRSectionHeaderView : UIView

@property (nonatomic, copy) NSString * title;

-(id) initWithFrame:(CGRect)frame
          withTitle:(NSString*)title
    withButtonTitle:(NSString*)btnTitle
            byBlock:(void (^)(void))onClick;

@end
