//
//  TRMeetingModel.h
//  TheRiverApp
//
//  Created by DenisDbv on 13.09.13.
//  Copyright (c) 2013 axbx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TRMeetingModel : NSObject

@property (nonatomic, retain) NSString *meetingDay;
@property (nonatomic, retain) NSString *meetingMonth;
@property (nonatomic, retain) NSString *meetingTime;
@property (nonatomic, retain) NSString *meetingCity;

@property (nonatomic, retain) NSString *meetingTitle;
@property (nonatomic, retain) NSString *meetingDescription;
@property (nonatomic, retain) NSString *meetingGroup;

@property (nonatomic, retain) NSArray *meetingContact;
@property (nonatomic) BOOL isCheck;

@property (nonatomic, retain) NSString *meetingPhoto;
@property (nonatomic, retain) NSString *meetingURL;

@end
