//
//  TRContactsManager.h
//  TheRiverApp
//
//  Created by DenisDbv on 02.10.13.
//  Copyright (c) 2013 axbx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <LRResty/LRResty.h>
#import <ABMultiton/ABMultitonProtocol.h>
#import <ABMultiton/ABMultiton.h>

typedef void (^SuccessOperation)(LRRestyResponse *response);
typedef void (^FailedOperation)(LRRestyResponse *response);

@interface TRContactsManager : NSObject <ABMultitonProtocol>
{
    NSOperationQueue * _queueContacts;
}

+ (instancetype)client;

-(TRContactsListModel*) lastContactArray;

-(void) downloadContactList:(void(^)(LRRestyResponse *response, TRContactsListModel *contactList))successBlock
         andFailedOperation:(FailedOperation) failedOperation;

@end
