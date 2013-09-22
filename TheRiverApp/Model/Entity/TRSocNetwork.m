//
//  TRSocNetwork.m
//  TheRiverApp
//
//  Created by Admin on 22.09.13.
//  Copyright (c) 2013 axbx. All rights reserved.
//

#import "TRSocNetwork.h"
#import "TRContact.h"


@implementation TRSocNetwork

@dynamic url;
@dynamic name;
@dynamic contact;

-(NSString *)twitter { return [self socUrl:@"twitter"]; }
-(NSString *)facebook { return [self socUrl:@"facebook"]; }
-(NSString *)vkotakte { return [self socUrl:@"vkotakte"]; }

-(NSString *)socUrl:(NSString*)socName
{
    if ([[self.name lowercaseString] isEqualToString:socName]){
        return self.url;
    }
    return nil;
}

@end
