//
//  TRMeetRootBox.h
//  TheRiverApp
//
//  Created by DenisDbv on 14.09.13.
//  Copyright (c) 2013 axbx. All rights reserved.
//

#import "MGBox.h"

@interface TRMeetRootBox : MGBox

@property (nonatomic, strong) TREventModel *meetingData;

+(MGBox *) initBox:(CGSize)bounds;
+(MGBox *) initBox:(CGSize)bounds withMeetData:(TREventModel *)meetObject;
+(MGBox *) initBox:(CGSize)bounds withUserData:(TREventModel*)userObject byTarget:(id)target;

@end
