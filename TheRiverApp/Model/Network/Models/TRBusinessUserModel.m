//
//  TRBusinessUserModel.m
//  TheRiverApp
//
//  Created by DenisDbv on 23.09.13.
//  Copyright (c) 2013 axbx. All rights reserved.
//

#import "TRBusinessUserModel.h"

@implementation TRBusinessUserModel
@synthesize id, company_name, logo, industries, about, profit, employees, desc;

+ (Class)industries_class {
    return [TRBusinessScopeModel class];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if ((self = [super init]))
    {
        self.id = [aDecoder decodeObjectForKey:@"id"];
        self.company_name = [aDecoder decodeObjectForKey:@"company_name"];
        self.logo = [aDecoder decodeObjectForKey:@"logo"];
        self.industries = [aDecoder decodeObjectForKey:@"industries"];
        self.about = [aDecoder decodeObjectForKey:@"about"];
        self.profit = [aDecoder decodeObjectForKey:@"profit"];
        self.employees = [aDecoder decodeObjectForKey:@"employees"];
        self.desc = [aDecoder decodeObjectForKey:@"desc"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.id forKey:@"id"];
    [aCoder encodeObject:self.company_name forKey:@"company_name"];
    [aCoder encodeObject:self.logo forKey:@"logo"];
    [aCoder encodeObject:self.industries forKey:@"industries"];
    [aCoder encodeObject:self.about forKey:@"about"];
    [aCoder encodeObject:self.profit forKey:@"profit"];
    [aCoder encodeObject:self.employees forKey:@"employees"];
    [aCoder encodeObject:self.desc forKey:@"desc"];
}

@end
