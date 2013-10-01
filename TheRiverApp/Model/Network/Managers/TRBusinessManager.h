//
//  TRBusinessManager.h
//  TheRiverApp
//
//  Created by DenisDbv on 29.09.13.
//  Copyright (c) 2013 axbx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <LRResty/LRResty.h>
#import <ABMultiton/ABMultitonProtocol.h>
#import <ABMultiton/ABMultiton.h>

typedef void (^SuccessOperation)(LRRestyResponse *response);
typedef void (^FailedOperation)(LRRestyResponse *response);

@interface TRBusinessManager : NSObject <ABMultitonProtocol>
{
    NSOperationQueue * _queueBusiness;
}

+ (instancetype)client;

-(void) downloadBusinessList:(void(^)(LRRestyResponse *response, TRBusinessRootModel *businessList))successBlock
          andFailedOperation:(FailedOperation) failedOperation;

@end
