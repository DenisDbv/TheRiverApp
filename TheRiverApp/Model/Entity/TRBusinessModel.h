//
//  TRBusinessModel.h
//  TheRiverApp
//
//  Created by DenisDbv on 09.09.13.
//  Copyright (c) 2013 axbx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TRBusinessModel : NSObject

@property (nonatomic, retain) NSString *firstName;
@property (nonatomic, retain) NSString *lastName;
@property (nonatomic, retain) NSString *age;
@property (nonatomic, retain) NSString *city;


@property (nonatomic, retain) NSString *businessLogo;
@property (nonatomic, retain) NSString *businessTitle;
@property (nonatomic, retain) NSString *shortBusinessTitle;
@property (nonatomic, retain) NSString *businessBeforeTitle;
@property (nonatomic, retain) NSString *businessAfterTitle;

@property (nonatomic, retain) NSString *businessDate;

@property (nonatomic, retain) NSString *businessURL;

@end
