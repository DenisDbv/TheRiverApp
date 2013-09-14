//
//  TRMindModel.h
//  TheRiverApp
//
//  Created by DenisDbv on 08.09.13.
//  Copyright (c) 2013 axbx. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    MindLevel1 = 0,
    MindLevel2,
    MindLevel3
} MindLevel;

@interface TRMindModel : NSObject

@property (nonatomic, retain) NSString *mindLogo;
@property (nonatomic, retain) NSString *mindTitle;
@property (nonatomic, retain) NSString *mindAuthor;
@property (nonatomic, retain) NSString *mindDayCreate;
@property (nonatomic) MindLevel mindLevel;
@property (nonatomic) NSInteger mindRating;
@property (nonatomic) NSString *mindURL;

@end
