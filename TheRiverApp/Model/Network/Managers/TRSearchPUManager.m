//
//  TRSearchPUManager.m
//  TheRiverApp
//
//  Created by DenisDbv on 24.09.13.
//  Copyright (c) 2013 axbx. All rights reserved.
//

#import "TRSearchPUManager.h"
#import "URLDownloaderOperation.h"

@implementation TRSearchPUManager

+ (instancetype)client
{
    return [ABMultiton sharedInstanceOfClass:[self class]];
}

-(id) init
{
    _queuePUSearch = [[NSOperationQueue alloc] init];
    [_queuePUSearch setMaxConcurrentOperationCount:3];
    
    return [super init];
}

-(void) downloadCitiesList:(SuccessOperation) succesOperaion
        andFailedOperation:(FailedOperation) failedOperation
{
    
    if( [TRAuthManager client].isAuth == NO )   {
        NSLog(@"Отмена получения списка городов. Пользователь не авторизован.");
        return;
    }
    
    NSString *urlCityList = [NSString stringWithFormat:@"%@?%@=%@", kTG_API_CitiesList,
                                                                    kTGTokenKey,
                                                                    [TRAuthManager client].iamData.token];
    
    URLDownloaderOperation * operation = [[URLDownloaderOperation alloc] initWithUrlString: urlCityList
                                                              withSuccessBlock:^(LRRestyResponse *response) {
                                                            
                                                                  NSDictionary *resultJSON = [[response asString] objectFromJSONString];
                                                                  NSLog(@"%@", resultJSON);
                                                                  
                                                                  if( succesOperaion != nil)
                                                                      succesOperaion(response);
                                                                  
                                                              } andFailedBlock:^(LRRestyResponse *response){
                                                                  
                                                                  if(failedOperation != nil)
                                                                      failedOperation(response);
                                                                  
                                                                  NSLog(@"Error auth: %@", response.asString);
                                                              }];
    
    [_queuePUSearch addOperation:operation];
}

-(void) downloadIndustryList:(SuccessOperation) succesOperaion
        andFailedOperation:(FailedOperation) failedOperation
{
    
    if( [TRAuthManager client].isAuth == NO )   {
        NSLog(@"Отмена получения списка отраслей. Пользователь не авторизован.");
        return;
    }
    
    NSString *urlCityList = [NSString stringWithFormat:@"%@?%@=%@", kTG_API_IndustryList,
                             kTGTokenKey,
                             [TRAuthManager client].iamData.token];
    
    URLDownloaderOperation * operation = [[URLDownloaderOperation alloc] initWithUrlString: urlCityList
                                                                          withSuccessBlock:^(LRRestyResponse *response) {
                                                                              
                                                                              NSDictionary *resultJSON = [[response asString] objectFromJSONString];
                                                                              NSLog(@"%@", resultJSON);
                                                                              
                                                                              if( succesOperaion != nil)
                                                                                  succesOperaion(response);
                                                                              
                                                                          } andFailedBlock:^(LRRestyResponse *response){
                                                                              
                                                                              if(failedOperation != nil)
                                                                                  failedOperation(response);
                                                                              
                                                                              NSLog(@"Error auth: %@", response.asString);
                                                                          }];
    
    [_queuePUSearch addOperation:operation];
}

@end
