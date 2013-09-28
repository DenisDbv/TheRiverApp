//
//  TRSearchPartnersManager.h
//  TheRiverApp
//
//  Created by DenisDbv on 28.09.13.
//  Copyright (c) 2013 axbx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <LRResty/LRResty.h>
#import <ABMultiton/ABMultitonProtocol.h>
#import <ABMultiton/ABMultiton.h>

typedef void (^SuccessOperation)(LRRestyResponse *response);
typedef void (^FailedOperation)(LRRestyResponse *response);

@interface TRSearchPartnersManager : NSObject <ABMultitonProtocol>
{
    NSOperationQueue * _queuePartnersSearch;
}

+ (instancetype)client;

-(void) downloadPartnersListByString:(NSString*)query
                withSuccessOperation:(void(^)(LRRestyResponse *response, TRPartnersListModel *partnersList))successBlock
                  andFailedOperation:(FailedOperation) failedOperation;

@end
