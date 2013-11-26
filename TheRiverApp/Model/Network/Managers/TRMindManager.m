//
//  TRMindManager.m
//  TheRiverApp
//
//  Created by DenisDbv on 26.11.13.
//  Copyright (c) 2013 axbx. All rights reserved.
//

#import "TRMindManager.h"
#import "URLDownloaderOperation.h"
#import "URLPostOperation.h"

@implementation TRMindManager

+ (instancetype)client
{
    return [ABMultiton sharedInstanceOfClass:[self class]];
}

-(id) init
{
    _queueMind = [[NSOperationQueue alloc] init];
    [_queueMind setMaxConcurrentOperationCount:1];
    
    return [super init];
}

-(NSString*) getCurrentDate
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
    [dateFormatter setTimeZone:timeZone];
    [dateFormatter setDateFormat:@"dd.MM.YYYY HH:mm"];
    
    return [dateFormatter stringFromDate:[NSDate date]];
}

-(void) downloadMindListByPage:(NSInteger)pageIndex
              successOperation:(void(^)(LRRestyResponse *response, TRMindModel *mindModel))successBlock
            andFailedOperation:(FailedOperation) failedOperation
{
    if( [TRAuthManager client].isAuth == NO )   {
        NSLog(@"Отмена получения списка знаний. Пользователь не авторизован.");
        return;
    }
    
    //NSLog(@"%@", [TRAuthManager client].iamData.token);
    
    NSString *urlBusinessList = [NSString stringWithFormat:kTG_API_MindList, [TRAuthManager client].iamData.token, pageIndex];
    
    URLDownloaderOperation * operation = [[URLDownloaderOperation alloc] initWithUrlString: urlBusinessList
                                                                          withSuccessBlock:^(LRRestyResponse *response) {
                                                                              
                                                                              NSDictionary *resultJSON = [[response asString] objectFromJSONString];
                                                                              //NSLog(@"%@", resultJSON);
                                                                              
                                                                              TRMindModel *mindModel = [[TRMindModel alloc] initWithDictionary:resultJSON];
                                                                              if(mindModel.bd.count > 0)  {
                                                                        
                                                                                  if(successBlock != nil)
                                                                                      successBlock(response, mindModel);
                                                                              } else    {
                                                                                  NSLog(@"Список знаний пуст");
                                                                                  if(failedOperation != nil)
                                                                                      failedOperation(response);
                                                                              }
                                                                              
                                                                          } andFailedBlock:^(LRRestyResponse *response) {
                                                                              
                                                                              if(failedOperation != nil)
                                                                                  failedOperation(response);
                                                                              
                                                                              NSLog(@"Error get mind list (%i): %@", response.status, response.asString);
                                                                          }];
    
    [_queueMind addOperation:operation];
}

-(void) downloadMindDescByID:(NSString*)mindID
            successOperation:(void(^)(LRRestyResponse *response, TRMindItem *mindItem))successBlock
          andFailedOperation:(FailedOperation) failedOperation
{
    if( [TRAuthManager client].isAuth == NO )   {
        NSLog(@"Отмена получения описания знания. Пользователь не авторизован.");
        return;
    }
    
    NSString *urlBusinessList = [NSString stringWithFormat:kTG_API_MindDesc, [TRAuthManager client].iamData.token, mindID];
    
    URLDownloaderOperation * operation = [[URLDownloaderOperation alloc] initWithUrlString: urlBusinessList
                                                                          withSuccessBlock:^(LRRestyResponse *response) {
                                                                              
                                                                              NSDictionary *resultJSON = [[response asString] objectFromJSONString];
                                                                              //NSLog(@"%@", resultJSON);
                                                                              
                                                                              TRMindItem *mindItem = [[TRMindItem alloc] initWithDictionary:resultJSON];
                                                                              
                                                                              if(successBlock != nil)
                                                                                  successBlock(response, mindItem);
                                                                              
                                                                          } andFailedBlock:^(LRRestyResponse *response) {
                                                                              
                                                                              if(failedOperation != nil)
                                                                                  failedOperation(response);
                                                                              
                                                                              NSLog(@"Error get mind desc (%i): %@", response.status, response.asString);
                                                                          }];
    
    [_queueMind addOperation:operation];
}

-(void) downloadMindListByString:(NSString*)query
                withSuccessOperation:(void(^)(LRRestyResponse *response, TRMindModel *mindModel))successBlock
                  andFailedOperation:(FailedOperation) failedOperation
{
    if( [TRAuthManager client].isAuth == NO )   {
        NSLog(@"Отмена получения списка знаний по поиску. Пользователь не авторизован.");
        return;
    }
    
    [_queueMind.operations enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSOperation *operationIndex = obj;
        [operationIndex cancel];
    }];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:[TRAuthManager client].iamData.token forKey:kTGTokenKey];
    [params setObject:query forKey:kTGQueryKey];
    
    __block URLPostOperation * operation = [[URLPostOperation alloc]  initWithUrlString: kTG_API_MindSearch
                                                                               andParam:params
                                                                              andHeader:nil
                                                                       withSuccessBlock:^(LRRestyResponse *response) {
                                                                           
                                                                           if(operation.isCancelled != YES) {
                                                                               
                                                                               NSDictionary *resultJSON = [[response asString] objectFromJSONString];
                                                                               TRMindModel *mindModel = [[TRMindModel alloc] initWithDictionary:resultJSON];
                                                                               if(mindModel.bd.count > 0)  {
                                                                                   
                                                                                   if(successBlock != nil)
                                                                                       successBlock(response, mindModel);
                                                                                   
                                                                               } else    {
                                                                                   NSLog(@"Список знаний пуст");
                                                                                   if(failedOperation != nil)
                                                                                       failedOperation(response);
                                                                               }
                                                                           }
                                                                           
                                                                       } andFailedBlock:^(LRRestyResponse *response){
                                                                           
                                                                           if(failedOperation != nil)
                                                                               failedOperation(response);
                                                                           
                                                                           NSLog(@"Error downloadUsersListByCity: %@", response.asString);
                                                                       }];
    
    [_queueMind addOperation:operation];
}

@end
