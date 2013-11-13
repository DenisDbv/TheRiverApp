//
//  TRBusinessManager.m
//  TheRiverApp
//
//  Created by DenisDbv on 29.09.13.
//  Copyright (c) 2013 axbx. All rights reserved.
//

#import "TRBusinessManager.h"
#import "TRBusinessDescModel.h"
#import "URLDownloaderOperation.h"
#import "URLPostOperation.h"
#import <NSString+RMURLEncoding/NSString+RMURLEncoding.h>
#import "TGArhiveObject.h"
#import <ISDiskCache/ISDiskCache.h>

@implementation TRBusinessManager
{
    NSUserDefaults *userDefaults;
}

+ (instancetype)client
{
    return [ABMultiton sharedInstanceOfClass:[self class]];
}

-(id) init
{
    _queueBusiness = [[NSOperationQueue alloc] init];
    [_queueBusiness setMaxConcurrentOperationCount:1];
    
    userDefaults = [NSUserDefaults standardUserDefaults];
    
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
    
    if([[ISDiskCache sharedCache] hasObjectForKey:urlBusinessList]) {
        NSDictionary *resultJSON = [[ISDiskCache sharedCache] objectForKey:urlBusinessList];
        TRBusinessRootModel *businessRootModel = [[TRBusinessRootModel alloc] initWithDictionary:resultJSON];
        
        if( successBlock != nil)
            successBlock(nil, businessRootModel);
    }
    
    NSLog(@"->|%@|", [userDefaults stringForKey:@"eTag_downloadBusinessList"]);
    
    URLDownloaderOperation * operation = [[URLDownloaderOperation alloc] initWithUrlString: urlBusinessList
                                                                                      eTag: [userDefaults objectForKey:@"eTag_downloadBusinessList"]
                                                                          withSuccessBlock:^(LRRestyResponse *response) {
                                                                              
                                                                              NSLog(@"ETag business list: %@", [response.headers valueForKey:@"ETag"] );
                                                                              
                                                                              NSDictionary *resultJSON = [[response asString] objectFromJSONString];
                                                                              
                                                                              TRBusinessRootModel *businessRootModel = [[TRBusinessRootModel alloc] initWithDictionary:resultJSON];
                                                                              if(businessRootModel.business.count > 0)  {
                                                                                  
                                                                                  [userDefaults setObject:[response.headers valueForKey:@"ETag"] forKey:@"eTag_downloadBusinessList"];
                                                                                  [userDefaults synchronize];
                                                                                  
                                                                                  [[ISDiskCache sharedCache] setObject:resultJSON forKey:urlBusinessList];
                                                                                  
                                                                                  if( successBlock != nil)
                                                                                      successBlock(response, businessRootModel);
                                                                              } else    {
                                                                                  
                                                                                  NSLog(@"Список бизнесов пуст: %@", response.asString);
                                                                                  
                                                                                  if(failedOperation != nil)
                                                                                      failedOperation(response);
                                                                              }
                                                                              
                                                                          } andFailedBlock:^(LRRestyResponse *response){
                                                                              
                                                                              if(response.status == 304)
                                                                              {
                                                                                  NSLog(@"Business list not modified");
                                                                              } else  {
                                                                                  NSLog(@"Error get business list (%i): %@", response.status, response.asString);
                                                                              }
                                                                              
                                                                              if(failedOperation != nil)
                                                                                  failedOperation(response);
                                                                          }];
    
    [_queueBusiness addOperation:operation];
}

-(void) downloadBusinessDescByID:(NSString*)idBusiness
     withSuccessfulOperation:(void(^)(LRRestyResponse *response, TRBusinessDescModel *businessDesc))successBlock
          andFailedOperation:(FailedOperation) failedOperation
{
    if( [TRAuthManager client].isAuth == NO )   {
        NSLog(@"Отмена получения описания бизнеса. Пользователь не авторизован.");
        return;
    }
    
    NSString *urlBusinessList = [NSString stringWithFormat:@"%@?%@=%@&id=%@", kTG_API_BusinessDesc,
                                 kTGTokenKey,
                                 [TRAuthManager client].iamData.token, idBusiness];
    
    URLDownloaderOperation * operation = [[URLDownloaderOperation alloc] initWithUrlString: urlBusinessList
                                                                          withSuccessBlock:^(LRRestyResponse *response) {
                                                                              
                                                                              NSDictionary *resultJSON = [[response asString] objectFromJSONString];
                                                                              //NSLog(@"%@", resultJSON);
                                                                              
                                                                              TRBusinessDescModel *businessRootModel = [[TRBusinessDescModel alloc] initWithDictionary:resultJSON];
                                                                              
                                                                              if( successBlock != nil)
                                                                                  successBlock(response, businessRootModel);
                                                                              
                                                                          } andFailedBlock:^(LRRestyResponse *response){
                                                                              
                                                                              if(failedOperation != nil)
                                                                                  failedOperation(response);
                                                                              
                                                                              NSLog(@"Error auth (%i): %@", response.status, response.asString);
                                                                          }];
    
    [_queueBusiness addOperation:operation];
}

@end
