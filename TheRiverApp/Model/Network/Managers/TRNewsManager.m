//
//  TRNewsManager.m
//  TheRiverApp
//
//  Created by DenisDbv on 14.11.13.
//  Copyright (c) 2013 axbx. All rights reserved.
//

#import "TRNewsManager.h"
#import "URLDownloaderOperation.h"
#import "URLPostOperation.h"

@implementation TRNewsManager
{
    NSUserDefaults *userDefaults;
}

+ (instancetype)client
{
    return [ABMultiton sharedInstanceOfClass:[self class]];
}

-(id) init
{
    _queueNews = [[NSOperationQueue alloc] init];
    [_queueNews setMaxConcurrentOperationCount:1];
    
    userDefaults = [NSUserDefaults standardUserDefaults];
    
    return [super init];
}

-(NSString*) getCurrentDate
{
    /*NSDate *currDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"dd.MM.YY HH:mm"];
    
    return [dateFormatter stringFromDate:currDate];*/
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
    [dateFormatter setTimeZone:timeZone];
    [dateFormatter setDateFormat:@"dd.MM.YYYY HH:mm"];
    
    return [dateFormatter stringFromDate:[NSDate date]];
}

-(void) downloadNewsListByPage:(NSInteger)pageIndex
        successOperation:(void(^)(LRRestyResponse *response, TRNewsModel *newsModel))successBlock
         andFailedOperation:(FailedOperation) failedOperation
{
    if( [TRAuthManager client].isAuth == NO )   {
        NSLog(@"Отмена получения списка новостей. Пользователь не авторизован.");
        return;
    }
    
    NSString *lastDateEntry = [userDefaults objectForKey:@"downloadNewsList_lastDate"];
    if(lastDateEntry.length == 0)
        lastDateEntry = [self getCurrentDate];
    
    NSString *urlBusinessList = [NSString stringWithFormat:kTG_API_NewsList, [TRAuthManager client].iamData.token, pageIndex, [lastDateEntry stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] ];
    
    URLDownloaderOperation * operation = [[URLDownloaderOperation alloc] initWithUrlString: urlBusinessList
                                                                          withSuccessBlock:^(LRRestyResponse *response) {
                                                                              
                                                                              NSDictionary *resultJSON = [[response asString] objectFromJSONString];
                                                                              //NSLog(@"%@", resultJSON);
                                                                              
                                                                              TRNewsModel *newsModel = [[TRNewsModel alloc] initWithDictionary:resultJSON];
                                                                              if(newsModel.news.count > 0)  {
                                                                                  
                                                                                  [userDefaults setObject:[self getCurrentDate] forKey:@"downloadNewsList_lastDate"];
                                                                                  
                                                                                  [AppDelegateInstance() showBadgeNews:[newsModel.count_last_news integerValue]];
                                                                                  
                                                                                  if(successBlock != nil)
                                                                                      successBlock(response, newsModel);
                                                                              } else    {
                                                                                  NSLog(@"Список новостей пуст");
                                                                                  if(failedOperation != nil)
                                                                                      failedOperation(response);
                                                                              }
                                                                              
                                                                          } andFailedBlock:^(LRRestyResponse *response) {
                                                                              
                                                                              if(failedOperation != nil)
                                                                                  failedOperation(response);
                                                                              
                                                                              NSLog(@"Error get news list (%i): %@", response.status, response.asString);
                                                                          }];
    
    [_queueNews addOperation:operation];
}

-(void) downloadNewsDescByID:(NSString*)newsID
              successOperation:(void(^)(LRRestyResponse *response, TRNewsItem *newsItem))successBlock
            andFailedOperation:(FailedOperation) failedOperation
{
    if( [TRAuthManager client].isAuth == NO )   {
        NSLog(@"Отмена получения описания новости. Пользователь не авторизован.");
        return;
    }
    
    NSString *urlBusinessList = [NSString stringWithFormat:kTG_API_NewsDesc, [TRAuthManager client].iamData.token, newsID];

    URLDownloaderOperation * operation = [[URLDownloaderOperation alloc] initWithUrlString: urlBusinessList
                                                                          withSuccessBlock:^(LRRestyResponse *response) {
                                                                              
                                                                              NSDictionary *resultJSON = [[response asString] objectFromJSONString];
                                                                              //NSLog(@"%@", resultJSON);
                                                                              
                                                                              TRNewsItem *newsItem = [[TRNewsItem alloc] initWithDictionary:resultJSON];
                                                                              
                                                                              if(successBlock != nil)
                                                                                  successBlock(response, newsItem);
                                                                              
                                                                          } andFailedBlock:^(LRRestyResponse *response) {
                                                                              
                                                                              if(failedOperation != nil)
                                                                                  failedOperation(response);
                                                                              
                                                                              NSLog(@"Error get news list (%i): %@", response.status, response.asString);
                                                                          }];
    
    [_queueNews addOperation:operation];
}

@end
