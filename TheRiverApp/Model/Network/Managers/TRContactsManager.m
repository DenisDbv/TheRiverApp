//
//  TRContactsManager.m
//  TheRiverApp
//
//  Created by DenisDbv on 02.10.13.
//  Copyright (c) 2013 axbx. All rights reserved.
//

#import "TRContactsManager.h"
#import "URLDownloaderOperation.h"
#import "URLPostOperation.h"
#import <NSString+RMURLEncoding/NSString+RMURLEncoding.h>
#import "TGArhiveObject.h"

@implementation TRContactsManager

+ (instancetype)client
{
    return [ABMultiton sharedInstanceOfClass:[self class]];
}

-(id) init
{
    _queueContacts = [[NSOperationQueue alloc] init];
    [_queueContacts setMaxConcurrentOperationCount:1];
    
    return [super init];
}

-(void) downloadContactList:(void(^)(LRRestyResponse *response, TRContactsListModel *contactList))successBlock
         andFailedOperation:(FailedOperation) failedOperation
{
    if( [TRAuthManager client].isAuth == NO )   {
        NSLog(@"Отмена получения списка контактов. Пользователь не авторизован.");
        return;
    }
    
    NSString *urlContactList = [NSString stringWithFormat:@"%@?%@=%@", kTG_API_ContactList,
                                 kTGTokenKey,
                                 [TRAuthManager client].iamData.token];
    
    URLDownloaderOperation * operation = [[URLDownloaderOperation alloc] initWithUrlString: urlContactList
                                                                          withSuccessBlock:^(LRRestyResponse *response) {
                                                                              
                                                                              NSDictionary *resultJSON = [[response asString] objectFromJSONString];
                                                                              
                                                                              TRContactsListModel *cotactListModel = [[TRContactsListModel alloc] initWithDictionary:resultJSON];
                                                                              NSLog(@"%@", cotactListModel);
                                                                              
                                                                              if( successBlock != nil)
                                                                                  successBlock(response, cotactListModel);
                                                                              
                                                                          } andFailedBlock:^(LRRestyResponse *response){
                                                                              
                                                                              if(failedOperation != nil)
                                                                                  failedOperation(response);
                                                                              
                                                                              NSLog(@"Error auth: %@", response.asString);
                                                                          }];
    
    [_queueContacts addOperation:operation];
}
@end
