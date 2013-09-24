//
//  TRContact.m
//  TheRiverApp
//
//  Created by Admin on 22.09.13.
//  Copyright (c) 2013 axbx. All rights reserved.
//

#import "TRContact.h"
#import "TRSocNetwork.h"
#import "TRTel.h"


@implementation TRContact

@dynamic city;
@dynamic firstName;
@dynamic lastName;
@dynamic id;
@dynamic logo;
@dynamic isStar;
@dynamic tel;
@dynamic socNetwork;

+(NSArray*)favorite
{
    return [TRContact where:@"isStar == true"];
}

+(NSArray*)notFavorite
{
    return [TRContact where:@"isStar == false"];
}

+(NSArray*)filterNotFavorite:(NSString*)text
{
    NSString* s = [NSString stringWithFormat:@"isStar == false and firstName contains[cd] '%@' or lastName contains[cd] '%@'", text, text];
    return [TRContact where:s];
}

@end
