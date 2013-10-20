//
//  TRSearchPUManager.m
//  TheRiverApp
//
//  Created by DenisDbv on 24.09.13.
//  Copyright (c) 2013 axbx. All rights reserved.
//

#import "TRSearchPUManager.h"
#import "URLDownloaderOperation.h"
#import "URLPostOperation.h"
#import <NSString+RMURLEncoding/NSString+RMURLEncoding.h>
#import "TGArhiveObject.h"

@implementation TRSearchPUManager

static const NSString *_fileCitiesHandler = @"cities.data";
static const NSString *_fileIndustryHandler = @"industry.data";

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
    URLDownloaderOperation * operation = [[URLDownloaderOperation alloc] initWithUrlString: kTG_API_CitiesList
                                                              withSuccessBlock:^(LRRestyResponse *response) {
                                                            
                                                                  NSArray *resultJSON = [[response asString] objectFromJSONString];

                                                                  TRCitiesListModel *citiesList = [[TRCitiesListModel alloc] initWithDictionary:resultJSON];
                                                                  [self saveUserData:citiesList atFile:(NSString*)_fileCitiesHandler];
                                                                  
                                                                  /*NSMutableArray *citiesArray = [[NSMutableArray alloc] init];
                                                                  [resultJSON enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                                                                          [citiesArray addObject: [obj objectForKey:@"name"] ];
                                                                  }];
                                                                  [self saveUserData:citiesArray atFile:(NSString*)_fileCitiesHandler];*/
                                                                  
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
    URLDownloaderOperation * operation = [[URLDownloaderOperation alloc] initWithUrlString: kTG_API_IndustryList
                                                                          withSuccessBlock:^(LRRestyResponse *response) {
                                                                              
                                                                              NSArray *resultJSON = [[response asString] objectFromJSONString];
                                                                            
                                                                              TRIndustriesListModel *industriesList = [[TRIndustriesListModel alloc] initWithDictionary:resultJSON];
                                                                              [self saveUserData:industriesList atFile:(NSString*)_fileIndustryHandler];
                                                                              
                                                                              /*NSMutableArray *industryArray = [[NSMutableArray alloc] init];
                                                                              [resultJSON enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                                                                                  [industryArray addObject: [obj objectForKey:@"name"] ];
                                                                              }];
                                                                              [self saveUserData:industryArray atFile:(NSString*)_fileIndustryHandler];*/
                                                                              
                                                                              if( succesOperaion != nil)
                                                                                  succesOperaion(response);
                                                                              
                                                                          } andFailedBlock:^(LRRestyResponse *response){
                                                                              
                                                                              if(failedOperation != nil)
                                                                                  failedOperation(response);
                                                                              
                                                                              NSLog(@"Error auth: %@", response.asString);
                                                                          }];
    
    [_queuePUSearch addOperation:operation];
}

-(void) downloadUsersListByCity:(NSString*)city
                    andIndustry:(NSString*)industry
           withSuccessOperation:(void(^)(LRRestyResponse *response, TRPUserListModel *usersList))successBlock
             andFailedOperation:(FailedOperation) failedOperation
{
    if( [TRAuthManager client].isAuth == NO )   {
        NSLog(@"Отмена получения списка участников. Пользователь не авторизован.");
        return;
    }
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:[TRAuthManager client].iamData.token forKey:kTGTokenKey];
    [params setObject:city forKey:kTGCityKey];
    [params setObject:industry forKey:kTGScopeWorkKey];
    
    URLPostOperation * operation = [[URLPostOperation alloc]  initWithUrlString: kTG_API_PartyUsersList
                                                                       andParam:params
                                                                      andHeader:nil
                                                                          withSuccessBlock:^(LRRestyResponse *response) {
                                                                              
                                                                              NSDictionary *resultJSON = [[response asString] objectFromJSONString];
                                                                              
                                                                              TRPUserListModel *puUserList = [[TRPUserListModel alloc] initWithDictionary:resultJSON];
                                                                              
                                                                              if( successBlock != nil)
                                                                                  successBlock(response, puUserList);
                                                                              
                                                                          } andFailedBlock:^(LRRestyResponse *response){
                                                                              
                                                                              if(failedOperation != nil)
                                                                                  failedOperation(response);
                                                                              
                                                                              NSLog(@"Error downloadUsersListByCity: %@", response.asString);
                                                                          }];
    
    [_queuePUSearch addOperation:operation];
}

-(void) saveUserData:(id)dataModel atFile:(NSString*)fileName
{
    [[TGArhiveObject class] saveArhiveFromObject:dataModel toFile: fileName];
}

-(TRCitiesListModel*) cityList
{
    return [[TGArhiveObject class] unarhiveObjectFromFile: (NSString*)_fileCitiesHandler];
}

-(TRIndustriesListModel*) industryList
{
    return [[TGArhiveObject class] unarhiveObjectFromFile: (NSString*)_fileIndustryHandler];
}

-(void) clear
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSString *userFilePath = [[[TGArhiveObject class] documentsDirectory] stringByAppendingPathComponent: (NSString*)_fileCitiesHandler];
    [fileManager removeItemAtPath:userFilePath error:nil];
    
    userFilePath = [[[TGArhiveObject class] documentsDirectory] stringByAppendingPathComponent: (NSString*)_fileIndustryHandler];
    [fileManager removeItemAtPath:userFilePath error:nil];
}

@end
