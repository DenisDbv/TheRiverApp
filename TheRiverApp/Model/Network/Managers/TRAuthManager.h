//
//  TRAuthManager.h
//  TheRiverApp
//
//  Created by DenisDbv on 21.09.13.
//  Copyright (c) 2013 axbx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <LRResty/LRResty.h>
#import <ABMultiton/ABMultitonProtocol.h>
#import <ABMultiton/ABMultiton.h>

#import "TRAuthUserModel.h"

typedef void (^SuccessOperation)(LRRestyResponse *response);
typedef void (^FailedOperation)(LRRestyResponse *response);

@interface TRAuthManager : NSObject <ABMultitonProtocol>
{
    NSOperationQueue * _queueAuth;
}

@property (nonatomic, retain) TRAuthUserModel *iamData;

+ (instancetype)client;

// Метод для авторизация пользователя
-(void) authByLogin:(NSString*)login
        andPassword:(NSString*)password
withSuccessOperation:(SuccessOperation) succesOperaion
 andFailedOperation:(FailedOperation) failedOperation;

-(void) saveUserData:(id)userModel;
-(BOOL) isAuth;
-(void) logout;

@end
