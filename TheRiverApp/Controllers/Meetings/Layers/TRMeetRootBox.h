//
//  TRMeetRootBox.h
//  TheRiverApp
//
//  Created by DenisDbv on 14.09.13.
//  Copyright (c) 2013 axbx. All rights reserved.
//

#import "MGBox.h"

@interface TRMeetRootBox : MGBox

@property (nonatomic, strong) TRMeetingModel *meetingData;

+(MGBox *) initBox:(CGSize)bounds;
+(MGBox *) initBox:(CGSize)bounds withMeetData:(TRMeetingModel *)meetObject;
+(MGBox *) initBox:(CGSize)bounds withUserData:(TRMeetingModel*)userObject byTarget:(id)target;

@end
