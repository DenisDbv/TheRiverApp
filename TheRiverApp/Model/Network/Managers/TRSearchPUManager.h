//
//  TRSearchPUManager.h
//  TheRiverApp
//
//  Created by DenisDbv on 24.09.13.
//  Copyright (c) 2013 axbx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <LRResty/LRResty.h>
#import <ABMultiton/ABMultitonProtocol.h>
#import <ABMultiton/ABMultiton.h>

typedef void (^SuccessOperation)(LRRestyResponse *response);
typedef void (^FailedOperation)(LRRestyResponse *response);

@interface TRSearchPUManager : NSObject <ABMultitonProtocol>
{
    NSOperationQueue * _queuePUSearch;
}

+ (instancetype)client;

-(void) downloadCitiesList:(SuccessOperation) succesOperaion
        andFailedOperation:(FailedOperation) failedOperation;

-(void) downloadIndustryList:(SuccessOperation) succesOperaion
          andFailedOperation:(FailedOperation) failedOperation;

@end
