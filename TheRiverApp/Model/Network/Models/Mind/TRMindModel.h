//
//  TRMindModel.h
//  TheRiverApp
//
//  Created by DenisDbv on 26.11.13.
//  Copyright (c) 2013 axbx. All rights reserved.
//

#import "Jastor.h"

@interface TRMindModel : Jastor

@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *items_in_page;
@property (nonatomic, copy) NSString *num_pages;
@property (nonatomic, strong) NSArray *bd;

@end

@interface TRMindItem : Jastor

@property (nonatomic, copy) NSString *date_create;
@property (nonatomic, copy) NSString *text;
@property (nonatomic, copy) NSString *logo;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *id;

@end
