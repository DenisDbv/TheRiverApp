//
//  TRMindManager.h
//  TheRiverApp
//
//  Created by DenisDbv on 26.11.13.
//  Copyright (c) 2013 axbx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <LRResty/LRResty.h>
#import <ABMultiton/ABMultitonProtocol.h>
#import <ABMultiton/ABMultiton.h>

@class TRMindModel;
@class TRMindItem;

@interface TRMindManager : NSObject <ABMultitonProtocol>
{
    NSOperationQueue * _queueMind;
}

+ (instancetype)client;

-(void) downloadMindListByPage:(NSInteger)pageIndex
              successOperation:(void(^)(LRRestyResponse *response, TRMindModel *mindModel))successBlock
            andFailedOperation:(FailedOperation) failedOperation;

-(void) downloadMindDescByID:(NSString*)mindID
            successOperation:(void(^)(LRRestyResponse *response, TRMindItem *mindItem))successBlock
          andFailedOperation:(FailedOperation) failedOperation;

-(void) downloadMindListByString:(NSString*)query
            withSuccessOperation:(void(^)(LRRestyResponse *response, TRMindModel *mindModel))successBlock
              andFailedOperation:(FailedOperation) failedOperation;

@end
