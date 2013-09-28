//
//  TRSearchPartnersManager.m
//  TheRiverApp
//
//  Created by DenisDbv on 28.09.13.
//  Copyright (c) 2013 axbx. All rights reserved.
//

#import "TRSearchPartnersManager.h"
#import "URLPostOperation.h"
#import "TGArhiveObject.h"

@implementation TRSearchPartnersManager

+ (instancetype)client
{
    return [ABMultiton sharedInstanceOfClass:[self class]];
}

-(id) init
{
    _queuePartnersSearch = [[NSOperationQueue alloc] init];
    [_queuePartnersSearch setMaxConcurrentOperationCount:1];
    
    return [super init];
}

-(void) downloadPartnersListByString:(NSString*)query
                withSuccessOperation:(void(^)(LRRestyResponse *response, TRPartnersListModel *partnersList))successBlock
                  andFailedOperation:(FailedOperation) failedOperation
{
    if( [TRAuthManager client].isAuth == NO )   {
        NSLog(@"Отмена получения списка участников. Пользователь не авторизован.");
        return;
    }
    
    [_queuePartnersSearch cancelAllOperations];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:[TRAuthManager client].iamData.token forKey:kTGTokenKey];
    [params setObject:query forKey:kTGQueryKey];
    
    URLPostOperation * operation = [[URLPostOperation alloc]  initWithUrlString: kTG_API_PartnersList
                                                                       andParam:params
                                                                      andHeader:nil
                                                               withSuccessBlock:^(LRRestyResponse *response) {
                                                                   
                                                                   NSDictionary *resultJSON = [[response asString] objectFromJSONString];
                                                                   
                                                                   TRPartnersListModel *pList = [[TRPartnersListModel alloc] initWithDictionary:resultJSON];
                                                                   
                                                                   if( successBlock != nil)
                                                                       successBlock(response, pList);
                                                                   
                                                               } andFailedBlock:^(LRRestyResponse *response){
                                                                   
                                                                   if(failedOperation != nil)
                                                                       failedOperation(response);
                                                                   
                                                                   NSLog(@"Error downloadUsersListByCity: %@", response.asString);
                                                               }];
    
    [_queuePartnersSearch addOperation:operation];
}

@end
