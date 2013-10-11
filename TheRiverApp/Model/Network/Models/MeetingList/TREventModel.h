//
//  TREventModel.h
//  TheRiverApp
//
//  Created by DenisDbv on 04.10.13.
//  Copyright (c) 2013 axbx. All rights reserved.
//

#import "Jastor.h"

@interface TREventModel : Jastor

@property (nonatomic, retain) NSString *logo;
@property (nonatomic, retain) NSString *logo_desc;
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *group;
@property (nonatomic, retain) NSString *place;
@property (nonatomic, retain) NSString *text;
@property (nonatomic, retain) NSString *start_date;

@property (nonatomic) BOOL isEnded;
@property (nonatomic) BOOL isAccept;

@end
