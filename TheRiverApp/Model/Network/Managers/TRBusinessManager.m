//
//  TRBusinessManager.m
//  TheRiverApp
//
//  Created by DenisDbv on 29.09.13.
//  Copyright (c) 2013 axbx. All rights reserved.
//

#import "TRBusinessManager.h"
#import "URLDownloaderOperation.h"
#import "URLPostOperation.h"
#import <NSString+RMURLEncoding/NSString+RMURLEncoding.h>
#import "TGArhiveObject.h"

@implementation TRBusinessManager

+ (instancetype)client
{
    return [ABMultiton sharedInstanceOfClass:[self class]];
}

-(id) init
{
    _queueBusiness = [[NSOperationQueue alloc] init];
    [_queueBusiness setMaxConcurrentOperationCount:1];
    
    return [super init];
}

-(void) downloadBusinessList:(void(^)(LRRestyResponse *response, TRBusinessRootModel *businessList))successBlock
          andFailedOperation:(FailedOperation) failedOperation
{
    if( [TRAuthManager client].isAuth == NO )   {
        NSLog(@"Отмена получения списка бизнесов. Пользователь не авторизован.");
        return;
    }
    
    NSString *urlBusinessList = [NSString stringWithFormat:@"%@?%@=%@", kTG_API_BusinessList,
                             kTGTokenKey,
                             [TRAuthManager client].iamData.token];
    
    URLDownloaderOperation * operation = [[URLDownloaderOperation alloc] initWithUrlString: urlBusinessList
                                                                          withSuccessBlock:^(LRRestyResponse *response) {
                                                                              
                                                                              NSDictionary *resultJSON = [[response asString] objectFromJSONString];
                                                                              
                                                                              TRBusinessRootModel *businessRootModel = [[TRBusinessRootModel alloc] initWithDictionary:resultJSON];
                                                                              
                                                                              if( successBlock != nil)
                                                                                  successBlock(response, businessRootModel);
                                                                              
                                                                          } andFailedBlock:^(LRRestyResponse *response){
                                                                              
                                                                              if(failedOperation != nil)
                                                                                  failedOperation(response);
                                                                              
                                                                              NSLog(@"Error auth: %@", response.asString);
                                                                          }];
    
    [_queueBusiness addOperation:operation];
}

@end
