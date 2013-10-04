//
//  TRMeetingManager.h
//  TheRiverApp
//
//  Created by DenisDbv on 04.10.13.
//  Copyright (c) 2013 axbx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <LRResty/LRResty.h>
#import <ABMultiton/ABMultitonProtocol.h>
#import <ABMultiton/ABMultiton.h>

@interface TRMeetingManager : NSObject <ABMultitonProtocol>
{
    NSOperationQueue * _queueMeetings;
}

+ (instancetype)client;

-(void) downloadMeetingList:(void(^)(LRRestyResponse *response, TRMeetingListModel *meetingList))successBlock
         andFailedOperation:(FailedOperation) failedOperation;

-(void) subscribeMeetingByID:(NSString*)meetID
            successOperation:(void(^)(LRRestyResponse *response))successBlock
          andFailedOperation:(FailedOperation) failedOperation;

@end
