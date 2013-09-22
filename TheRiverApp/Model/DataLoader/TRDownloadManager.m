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

+(instancetype)intsance
{
    static TRDownloadManager* c;
    if (c == nil) c = [TRDownloadManager new];
    return c;
}

-(void)search:(NSString*)query
{
    NSDictionary *parameter = @{@"token":@"4c42c089190e0d842d01d1de02a2368aaab42f23",
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

-(void)download
{
    NSString* path = [[NSBundle mainBundle]pathForResource:@"contacts.json" ofType:nil];
    NSData* data = [NSData dataWithContentsOfFile:path];
    id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    [self parseJson:json];
    return;
    
    
    NSURL *url = [NSURL URLWithString:@"http://kostum5.ru/api/get_player_contact_list/?token=4c42c089190e0d842d01d1de02a2368aaab42f23"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    AFJSONRequestOperation *operation;
    
    void (^onSuccess)(NSURLRequest*, NSHTTPURLResponse*, id) = ^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON){
        [self parseJson:JSON];
    };
    
    operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request
                                                                success:onSuccess
                                                                failure:nil];
    [operation start];
}

-(void)parseJson:(id)json
{
    @try {
        
        NSArray* oldContacts = [TRContact all];
        NSArray* oldTel = [TRTel all];
        NSArray* oldSocNetwork = [TRSocNetwork all];
        
        NSArray* contact_list = json[@"contact_list"];
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
            
            NSArray* tel_list = contact[@"tel"];
            for (int j=0; j<tel_list.count; ++j) {
                NSDictionary* tel = tel_list[j];
                
                NSString* number = tel[@"number"];
                
                TRTel* telModel = [TRTel create];
                telModel.number = number;
                telModel.contact = contactModel;
                
                [contactModel addTelObject:telModel];
            }
            
            NSArray* soc_network_list = contact[@"soc_network"];
            for (int j=0; j<soc_network_list.count; ++j) {
                NSDictionary* soc_network = soc_network_list[j];
                
                NSString* name = soc_network[@"name"];
                NSString* url = soc_network[@"url"];
                
                TRSocNetwork* socNetwork = [TRSocNetwork create];
                socNetwork.name = name;
                socNetwork.url = url;
                socNetwork.contact = contactModel;
                
                [contactModel addSocNetworkObject:socNetwork];
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
