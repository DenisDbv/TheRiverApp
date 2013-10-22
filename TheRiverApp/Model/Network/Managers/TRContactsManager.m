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
    
    TRContactsListModel *lastContactList = [self lastContactArray];
    if(lastContactList.user.count > 0)  {
        if( successBlock != nil)
            successBlock(nil, lastContactList);
    }
    
    NSLog(@"last etag == %@", [self lastEtag]);
    
    NSString *urlContactList = [NSString stringWithFormat:@"%@?%@=%@", kTG_API_ContactList,
                                 kTGTokenKey,
                                 [TRAuthManager client].iamData.token];
    
    
    URLDownloaderOperation * operation = [[URLDownloaderOperation alloc] initWithUrlString: urlContactList
                                                                                      eTag:[self lastEtag]
                                                                          withSuccessBlock:^(LRRestyResponse *response) {
                                                                              
                                                                              NSString *eTagValue = [response.headers valueForKey:@"ETag"];
                                                                              //eTagValue = [eTagValue stringByReplacingOccurrencesOfString:@"\"" withString:@""];
                                                                              //NSLog(@"====>%@", eTagValue);
                                                                              
                                                                              NSDictionary *resultJSON = [[response asString] objectFromJSONString];
                                                                              
                                                                              TRContactsListModel *cotactListModel = [[TRContactsListModel alloc] initWithDictionary:resultJSON];
                                                                              
                                                                              if(cotactListModel.user.count > 0)    {
                                                                                  NSMutableDictionary *storeContactsData = [[NSMutableDictionary alloc] init];
                                                                                  [storeContactsData setObject:eTagValue forKey:@"etag"];
                                                                                  [storeContactsData setObject:resultJSON forKey:@"data"];
                                                                                  
                                                                                  dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
                                                                                  dispatch_async(queue, ^ {
                                                                                      [self saveUserData:storeContactsData];
                                                                                  });
                                                                                
                                                                                  if( successBlock != nil)
                                                                                      successBlock(response, cotactListModel);
                                                                                  
                                                                              } else {
                                                                                  NSLog(@"Contact list access denied (%@)", resultJSON);
                                                                                  if(failedOperation != nil)
                                                                                      failedOperation(response);
                                                                              }
                                                                              
                                                                          } andFailedBlock:^(LRRestyResponse *response){
                                                                              
                                                                              if(response.status == 304)
                                                                              {
                                                                                  NSLog(@"Contact list not modified");
                                                                              }
                                                                              else  {
                                                                                  NSLog(@"Error get contacts list (%i): %@", response.status, response.description);
                                                                              }
                                                                              
                                                                              if(failedOperation != nil)
                                                                                  failedOperation(response);
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
