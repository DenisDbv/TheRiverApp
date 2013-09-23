//
//  TRAuthUserModel.m
//  TheRiverApp
//
//  Created by DenisDbv on 21.09.13.
//  Copyright (c) 2013 axbx. All rights reserved.
//

#import "TRAuthUserModel.h"

@implementation TRAuthUserModel
@synthesize email, token, user;

#pragma mark -
#pragma mark NSCoding

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if ((self = [super init]))
    {
        self.email = [aDecoder decodeObjectForKey:@"email"];
        self.token = [aDecoder decodeObjectForKey:@"token"];
        self.user = [aDecoder decodeObjectForKey:@"user"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.email forKey:@"email"];
    [aCoder encodeObject:self.token forKey:@"token"];
    [aCoder encodeObject:self.user forKey:@"user"];
}

@end
