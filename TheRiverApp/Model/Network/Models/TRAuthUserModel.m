//
//  TRAuthUserModel.m
//  TheRiverApp
//
//  Created by DenisDbv on 21.09.13.
//  Copyright (c) 2013 axbx. All rights reserved.
//

#import "TRAuthUserModel.h"

@implementation TRAuthUserModel
@synthesize email, token, player;

#pragma mark -
#pragma mark NSCoding

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if ((self = [super init]))
    {
        self.email = [aDecoder decodeObjectForKey:@"email"];
        self.token = [aDecoder decodeObjectForKey:@"token"];
        self.player = [aDecoder decodeObjectForKey:@"player"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.email forKey:@"email"];
    [aCoder encodeObject:self.token forKey:@"token"];
    [aCoder encodeObject:self.player forKey:@"player"];
}

@end
