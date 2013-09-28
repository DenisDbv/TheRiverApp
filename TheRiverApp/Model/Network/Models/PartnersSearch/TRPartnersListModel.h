//
//  TRPartnersListModel.h
//  TheRiverApp
//
//  Created by DenisDbv on 28.09.13.
//  Copyright (c) 2013 axbx. All rights reserved.
//

#import "Jastor.h"

@interface TRPartnersListModel : Jastor

@property (nonatomic, copy) NSString *query;

@property (nonatomic, retain) NSArray *fio;
@property (nonatomic, retain) NSArray *cities;
@property (nonatomic, retain) NSArray *scope_work;
@property (nonatomic, retain) NSArray *interests;

@end
