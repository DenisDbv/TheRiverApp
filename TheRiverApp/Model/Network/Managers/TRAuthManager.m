//
//  TRAuthManager.m
//  TheRiverApp
//
//  Created by DenisDbv on 21.09.13.
//  Copyright (c) 2013 axbx. All rights reserved.
//

#import "TRAuthManager.h"
#import "URLPostOperation.h"
#import "URLDownloaderOperation.h"
#import "TGArhiveObject.h"

@implementation TRAuthManager

@synthesize iamData;

static const NSString * _fileHandler = @"user.data";

+ (instancetype)client
{
    return [ABMultiton sharedInstanceOfClass:[self class]];
}

-(id) init
{
    _queueAuth = [[NSOperationQueue alloc] init];
    [_queueAuth setMaxConcurrentOperationCount:1];
    
    return [super init];
}

-(void) authByLogin:(NSString*)login
        andPassword:(NSString*)password
withSuccessOperation:(SuccessOperation) succesOperaion
 andFailedOperation:(FailedOperation) failedOperation
{
    NSString *tokenStr = [AppDelegateInstance() getDeviceToken].description;
    NSString *pushToken = @"";
    if(tokenStr.length > 0) {
        pushToken = [[[tokenStr
                                 stringByReplacingOccurrencesOfString:@"<" withString:@""]
                                stringByReplacingOccurrencesOfString:@">" withString:@""]
                               stringByReplacingOccurrencesOfString:@" " withString:@""];
    } else  {
        NSLog(@"Devoce token is clear by AUTH");
    }
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:login forKey:kTGUserLoginKey];
    [params setObject:password forKey:kTGUserPasswordKey];
    [params setObject:pushToken forKey:@"device_token"];
    
    URLPostOperation * operation = [[URLPostOperation alloc] initWithUrlString: kTG_API_AuthUrl
                                                                     andParam: params
                                                                     andHeader: nil
                                                              withSuccessBlock:^(LRRestyResponse *response) {
                                                                  
                                                                  NSDictionary *resultAuthJSON = [[response asString] objectFromJSONString];
                                                                  
                                                                  NSMutableDictionary *storeAuth = [[NSMutableDictionary alloc] init];
                                                                  [storeAuth setObject:resultAuthJSON forKey:@"authJson"];
                                                                  [storeAuth setObject:login forKey:@"login"];
                                            
                                                                  [self saveUserData: storeAuth];
                                                                  
                                                                  //NSLog(@"%@", storeAuth);
                                                                  
                                                                  //TRAuthUserModel *authModel = self.iamData;
                                                                  //NSLog(@"%@", resultAuthJSON);
                                                                  
                                                                  if( succesOperaion != nil)
                                                                      succesOperaion(response);
        
    } andFailedBlock:^(LRRestyResponse *response){
        
        if(failedOperation != nil)
            failedOperation(response);
        
        NSLog(@"Error auth: %@", response.asString);
    }];
    
    [_queueAuth addOperation:operation];
}

-(void) refreshAuthUserProfile:(SuccessOperation) succesOperaion
            andFailedOperation:(FailedOperation) failedOperation
{
    if( [TRAuthManager client].isAuth == NO )   {
        NSLog(@"Отмена обновления профиля участника. Пользователь не авторизован.");
        return;
    }
    
    NSString *urlAuthProfileRefresh = [NSString stringWithFormat:kTG_API_AuthProfilerefresh, [TRAuthManager client].iamData.token, [TRAuthManager client].iamData.user.objectId];
    
    URLDownloaderOperation * operation = [[URLDownloaderOperation alloc] initWithUrlString: urlAuthProfileRefresh
                                                                          withSuccessBlock:^(LRRestyResponse *response) {
                                                                              
                                                                              NSDictionary *resultJSON = [[response asString] objectFromJSONString];
                                                                              
                                                                              NSMutableDictionary *authDictionary = [[NSMutableDictionary alloc] initWithDictionary:resultJSON copyItems:YES];
                                                                              [authDictionary setObject:[self iamData].token forKey:@"token"];
                                                                              
                                                                              NSMutableDictionary *storeAuth = [[NSMutableDictionary alloc] init];
                                                                              [storeAuth setObject:authDictionary forKey:@"authJson"];
                                                                              [storeAuth setObject:[self iamData].email forKey:@"login"];
                                                                              
                                                                              [self saveUserData:storeAuth];
                                                                              
                                                                              if(succesOperaion != nil)
                                                                                  succesOperaion(response);
                                                                              
                                                                          } andFailedBlock:^(LRRestyResponse *response){
                                                                              
                                                                              if(failedOperation != nil)
                                                                                  failedOperation(response);
                                                                          }];
    
    [_queueAuth addOperation:operation];
}

-(void) saveUserData:(id)userModel
{
    [[TGArhiveObject class] saveArhiveFromObject:userModel toFile: (NSString*)_fileHandler];
}

-(TRAuthUserModel*) iamData
{
    NSMutableDictionary *authDictionary = [[TGArhiveObject class] unarhiveObjectFromFile: (NSString*)_fileHandler];
    TRAuthUserModel *authModel = [[TRAuthUserModel alloc] initWithDictionary: [authDictionary objectForKey:@"authJson"]];
    authModel.email = [authDictionary objectForKey:@"login"];
    return authModel;
}

-(BOOL) isAuth
{
    if(self.iamData.token.length == 0)
        return NO;
    
    return YES;
}

-(void) logout
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSString *userFilePath = [[[TGArhiveObject class] documentsDirectory] stringByAppendingPathComponent: (NSString*)_fileHandler];
    
    [fileManager removeItemAtPath:userFilePath error:nil];
}

@end
