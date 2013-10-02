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

static const NSString * _fileHandler = @"contacts.data";

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
                                                                                      eTag:[self lastEtag]
                                                                          withSuccessBlock:^(LRRestyResponse *response) {
                                                                              
                                                                              NSDictionary *resultJSON = [[response asString] objectFromJSONString];
                                                                              
                                                                              TRContactsListModel *cotactListModel = [[TRContactsListModel alloc] initWithDictionary:resultJSON];
                                                                              
                                                                              NSMutableDictionary *storeContactsData = [[NSMutableDictionary alloc] init];
                                                                              [storeContactsData setObject:[response.headers valueForKey:@"ETag"] forKey:@"etag"];
                                                                              [storeContactsData setObject:resultJSON forKey:@"data"];
                                                                              [self saveUserData:storeContactsData];
                                                                              
                                                                              if( successBlock != nil)
                                                                                  successBlock(response, cotactListModel);
                                                                              
                                                                          } andFailedBlock:^(LRRestyResponse *response){
                                                                              
                                                                              if(response.status == 304)
                                                                              {
                                                                                  NSLog(@"Contact list not modified");
                                                                                  
                                                                                  if( successBlock != nil)
                                                                                      successBlock(response, [self lastContactArray]);
                                                                              }
                                                                              else  {
                                                                                  if(failedOperation != nil)
                                                                                      failedOperation(response);
                                                                                  
                                                                                  NSLog(@"Error get contacts list: %@", response.description);
                                                                              }
                                                                          }];
    
    [_queueContacts addOperation:operation];
}

-(void) saveUserData:(id)dataModel
{
    [[TGArhiveObject class] saveArhiveFromObject:dataModel toFile: (NSString*)_fileHandler];
}

-(NSString*) lastEtag
{
    NSMutableDictionary *contactsDictionary = [[TGArhiveObject class] unarhiveObjectFromFile: (NSString*)_fileHandler];
    return [contactsDictionary objectForKey:@"etag"];
}

-(TRContactsListModel*) lastContactArray
{
    NSMutableDictionary *contactsDictionary = [[TGArhiveObject class] unarhiveObjectFromFile: (NSString*)_fileHandler];
    TRContactsListModel *cotactListModel = [[TRContactsListModel alloc] initWithDictionary: [contactsDictionary objectForKey:@"data"]];
    return cotactListModel;
}
@end
