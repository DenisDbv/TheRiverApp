//
//  TRMeetingListModel.m
//  TheRiverApp
//
//  Created by DenisDbv on 04.10.13.
//  Copyright (c) 2013 axbx. All rights reserved.
//

#import "TRMeetingListModel.h"
#import "TREventModel.h"

@implementation TRMeetingListModel
@synthesize events;

+ (Class)events_class {
    return [TREventModel class];
}

@end
