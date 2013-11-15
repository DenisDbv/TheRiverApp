//
//  TRNewsManager.h
//  TheRiverApp
//
//  Created by DenisDbv on 14.11.13.
//  Copyright (c) 2013 axbx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <LRResty/LRResty.h>
#import <ABMultiton/ABMultitonProtocol.h>
#import <ABMultiton/ABMultiton.h>

@class TRNewsModel;
@class TRNewsItem;

@interface TRNewsManager : NSObject <ABMultitonProtocol>
{
    NSOperationQueue * _queueNews;
}

+ (instancetype)client;

-(void) downloadNewsListByPage:(NSInteger)pageIndex
              successOperation:(void(^)(LRRestyResponse *response, TRNewsModel *newsModel))successBlock
            andFailedOperation:(FailedOperation) failedOperation;

-(void) downloadNewsDescByID:(NSString*)newsID
            successOperation:(void(^)(LRRestyResponse *response, TRNewsItem *newsItem))successBlock
          andFailedOperation:(FailedOperation) failedOperation;

@end
