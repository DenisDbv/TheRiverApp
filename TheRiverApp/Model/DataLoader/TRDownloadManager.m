//
//  TRDownloadManager.m
//  TheRiverApp
//
//  Created by Admin on 22.09.13.
//  Copyright (c) 2013 axbx. All rights reserved.
//

#import "TRDownloadManager.h"
#import <AFNetworking/AFJSONRequestOperation.h>
#import <AFNetworking/AFHTTPClient.h>
#import "NSManagedObject+Helper.h"
#import "TRContact.h"
#import "TRTel.h"
#import "TRSocNetwork.h"
#import "ObjectiveSugar.h"

@implementation TRDownloadManager

+(instancetype)instance
{
    static TRDownloadManager* c;
    if (c == nil) c = [TRDownloadManager new];
    return c;
}

-(void)dealloc
{
    NSLog(@"dm dealloc");
}

-(void)search:(NSString*)query
{
    NSDictionary *parameter = @{@"token":[TRAuthManager client].iamData.token,
                                @"query":query};
    
    NSURL *url = [NSURL URLWithString:@"http://kostum5.ru"];
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:url];
    
    [httpClient setParameterEncoding:AFJSONParameterEncoding];
    [httpClient registerHTTPOperationClass:[AFJSONRequestOperation class]];
    
    [httpClient postPath:@"api/fio_search/"
              parameters:parameter
                 success:^(AFHTTPRequestOperation *operation, id responseObject) {
                     NSString *responseStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"search response: %@", responseStr);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        // error
        NSLog(@"search error: %@", error);
    }];
}

-(void)toggleContactStarStatus:(NSInteger)contactId
{
    NSDictionary *parameter = @{@"token":[TRAuthManager client].iamData.token,
                                @"id":@(contactId)};
    
    NSURL *url = [NSURL URLWithString:@"http://kostum5.ru"];
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:url];
    
    [httpClient setParameterEncoding:AFJSONParameterEncoding];
    [httpClient registerHTTPOperationClass:[AFJSONRequestOperation class]];
    
    [httpClient getPath:@"api/add_contact_isstar/"
              parameters:parameter
                 success:^(AFHTTPRequestOperation *operation, id responseObject) {
                     NSString *responseStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
                     NSLog(@"star response: %@", responseStr);
                 } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                     // error
                     NSLog(@"star error: %@", error);
                 }];
}

-(void)download
{
    NSLog(@"start download");
//    NSString* path = [[NSBundle mainBundle]pathForResource:@"contacts.json" ofType:nil];
//    NSData* data = [NSData dataWithContentsOfFile:path];
//    id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
//    [self parseJson:json];
//    return;
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://kostum5.ru/api/get_player_contact_list/?token=%@",
                                       [TRAuthManager client].iamData.token]];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    AFJSONRequestOperation *operation;
    
    void (^onSuccess)(NSURLRequest*, NSHTTPURLResponse*, id) = ^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON){
        NSLog(@"success");
        [self parseJson:JSON];
    };
    
    void (^onFailure)(NSURLRequest*, NSHTTPURLResponse*, NSError*, id) = ^(NSURLRequest *request, NSHTTPURLResponse *response,
                                                                 NSError* error, id JSON){
        NSLog(@"failure %@", error);
    };

    operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request
                                                                success:onSuccess
                                                                failure:onFailure];
    [operation start];
    NSLog(@"end download");
}

-(void)parseJson:(id)json
{
    @try {
        
        NSArray* oldContacts = [TRContact all];
        NSArray* oldTel = [TRTel all];
        NSArray* oldSocNetwork = [TRSocNetwork all];
        
        NSArray* contact_list = json[@"user"];
        for (int i=0; i<contact_list.count; ++i) {
            NSDictionary* contact = contact_list[i];
            
            NSString* city = contact[@"city"];
            NSString* first_name = contact[@"first_name"];
            NSString* last_name = contact[@"last_name"];
            NSString* logo = contact[@"logo"];
            int id = [contact[@"id"] intValue];
            BOOL isStar = [contact[@"isStar"] boolValue];
            
            TRContact* contactModel = [TRContact create];
            contactModel.city = city;
            contactModel.firstName = first_name;
            contactModel.lastName = last_name;
            contactModel.logo = logo;
            contactModel.id = id;
            contactModel.isStar = isStar;
            
            
            NSDictionary* contact_data = contact[@"contact_data"];
            
            NSString* facebook = contact_data[@"facebook"];
            NSString* skype = contact_data[@"skype"];
            
            TRSocNetwork* socNetwork = [TRSocNetwork create];
            socNetwork.skype = skype;
            socNetwork.facebook = facebook;
            socNetwork.contact = contactModel;
            
            [contactModel addSocNetworkObject:socNetwork];
            
            NSArray* tel_list = contact_data[@"phone"];
            for (int j=0; j<tel_list.count; ++j) {
                NSString* number = tel_list[j];
                
                TRTel* telModel = [TRTel create];
                telModel.number = number;
                telModel.contact = contactModel;
                
                [contactModel addTelObject:telModel];
            }
        }
        
        NSManagedObjectContext* context = [AppDelegateInstance() managedObjectContext];
        NSError *error = nil;
        BOOL save = [context save:&error];
        if (!save || error) {
            NSLog(@"Unresolved error in saving context for entity:\n%@!\nError: %@", self, error);
        }else{
            // delete old
            [oldContacts each:^(id object){ [object delete]; }];
            [oldTel each:^(id object){ [object delete]; }];
            [oldSocNetwork each:^(id object){ [object delete]; }];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"ContactsUpdatedNotification" object:nil];
            NSLog(@"contacts updated %d", contact_list.count);
        }
    }
    @catch (NSException *exception) {
        NSLog(@"json parse error %@", exception);
    }
    @finally {
        
    }
}

@end
