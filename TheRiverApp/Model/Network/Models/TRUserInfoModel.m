//
//  TRUserInfoModel.m
//  TheRiverApp
//
//  Created by DenisDbv on 22.09.13.
//  Copyright (c) 2013 axbx. All rights reserved.
//

#import "TRUserInfoModel.h"

@implementation TRUserInfoModel
@synthesize id, first_name, last_name, sex, age, city, logo, business;
@synthesize interests;

+ (Class)interests_class {
    return [TRUserResolutionModel class];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if ((self = [super init]))
    {
        self.id = [aDecoder decodeObjectForKey:@"id"];
        self.first_name = [aDecoder decodeObjectForKey:@"first_name"];
        self.last_name = [aDecoder decodeObjectForKey:@"last_name"];
        self.sex = [aDecoder decodeObjectForKey:@"sex"];
        self.age = [aDecoder decodeObjectForKey:@"age"];
        self.city = [aDecoder decodeObjectForKey:@"city"];
        self.logo = [aDecoder decodeObjectForKey:@"logo"];
        self.business = [aDecoder decodeObjectForKey:@"business"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.id forKey:@"id"];
    [aCoder encodeObject:self.first_name forKey:@"first_name"];
    [aCoder encodeObject:self.last_name forKey:@"last_name"];
    [aCoder encodeObject:self.sex forKey:@"sex"];
    [aCoder encodeObject:self.age forKey:@"age"];
    [aCoder encodeObject:self.city forKey:@"city"];
    [aCoder encodeObject:self.logo forKey:@"logo"];
    [aCoder encodeObject:self.business forKey:@"business"];
}

@end
