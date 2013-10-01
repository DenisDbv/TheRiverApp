//
//  TRPartnersSearchView.h
//  TheRiverApp
//
//  Created by DenisDbv on 28.09.13.
//  Copyright (c) 2013 axbx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TRPartnersSearchView : UIView

- (id)initWithFrame:(CGRect)frame byRootTarget:(id)target;

-(void) setTextToSearchLabel:(NSString*)text;
-(void) becomeSearchBar;
-(void) resignSearchBar;

@end
