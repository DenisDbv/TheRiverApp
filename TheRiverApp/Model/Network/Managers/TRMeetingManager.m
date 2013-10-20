//
//  TRMeetingManager.m
//  TheRiverApp
//
//  Created by DenisDbv on 04.10.13.
//  Copyright (c) 2013 axbx. All rights reserved.
//

#import "TRMeetingManager.h"
#import "URLDownloaderOperation.h"
#import "URLPostOperation.h"
#import <NSString+RMURLEncoding/NSString+RMURLEncoding.h>
#import "TGArhiveObject.h"
#import "TRMeetingListModel.h"

@implementation TRMeetingManager

+ (instancetype)client
{
    return [ABMultiton sharedInstanceOfClass:[self class]];
}

-(id) init
{
    _queueMeetings = [[NSOperationQueue alloc] init];
    [_queueMeetings setMaxConcurrentOperationCount:1];
    
    return [super init];
}

-(void) downloadMeetingList:(void(^)(LRRestyResponse *response, TRMeetingListModel *meetingList))successBlock
          andFailedOperation:(FailedOperation) failedOperation
{
    if( [TRAuthManager client].isAuth == NO )   {
        NSLog(@"Отмена получения списка мероприятий. Пользователь не авторизован.");
        return;
    }
    
    NSString *urlBusinessList = [NSString stringWithFormat:@"%@?%@=%@", kTG_API_MeetingList,
                                 kTGTokenKey,
                                 [TRAuthManager client].iamData.token];
    
    URLDownloaderOperation * operation = [[URLDownloaderOperation alloc] initWithUrlString: urlBusinessList
                                                                          withSuccessBlock:^(LRRestyResponse *response) {
                                                                              
                                                                              NSDictionary *resultJSON = [[response asString] objectFromJSONString];
                                                                              
                                                                              TRMeetingListModel *meetingRootModel = [[TRMeetingListModel alloc] initWithDictionary:resultJSON];
                                                                              if(meetingRootModel.events.count > 0)  {
                                                                                  if( successBlock != nil)
                                                                                      successBlock(response, meetingRootModel);
                                                                              } else    {
                                                                                  
                                                                                  NSLog(@"Список мероприятий пуст: %@", response.asString);
                                                                                  
                                                                                  if(failedOperation != nil)
                                                                                      failedOperation(response);
                                                                              }
                                                                              
                                                                          } andFailedBlock:^(LRRestyResponse *response){
                                                                              
                                                                              if(failedOperation != nil)
                                                                                  failedOperation(response);
                                                                              
                                                                              NSLog(@"Error auth (%i): %@", response.status, response.asString);
                                                                          }];
    
    [_queueMeetings addOperation:operation];
}

-(void) subscribeMeetingByID:(NSString*)meetID
        successOperation:(void(^)(LRRestyResponse *response))successBlock
         andFailedOperation:(FailedOperation) failedOperation
{
    if( [TRAuthManager client].isAuth == NO )   {
        NSLog(@"Отмена подписки на мероприятие. Пользователь не авторизован.");
        return;
    }
    
    NSString *urlBusinessList = [NSString stringWithFormat:@"%@?%@=%@&id=%@", kTG_API_MeetingSbscr,
                                 kTGTokenKey,
                                 [TRAuthManager client].iamData.token, meetID];
    
    URLDownloaderOperation * operation = [[URLDownloaderOperation alloc] initWithUrlString: urlBusinessList
                                                                          withSuccessBlock:^(LRRestyResponse *response) {
                                                                              
                                                                              NSDictionary *resultJSON = [[response asString] objectFromJSONString];
                                                                              //NSLog(@"%@", resultJSON);
                                                                              BOOL result = [[resultJSON objectForKey:@"status"] boolValue];
                                                                              if(result == NO) {
                                                                                  if(failedOperation != nil)
                                                                                      failedOperation(response);
                                                                              }
                                                                              
                                                                              if(successBlock != nil)
                                                                                  successBlock(response);
                                                                              
                                                                          } andFailedBlock:^(LRRestyResponse *response){
                                                                              
                                                                              if(failedOperation != nil)
                                                                                  failedOperation(response);
                                                                              
                                                                              NSLog(@"Error auth (%i): %@", response.status, response.asString);
                                                                          }];
    
    [_queueMeetings addOperation:operation];
}

@end
