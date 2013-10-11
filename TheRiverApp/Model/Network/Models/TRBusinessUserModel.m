//
//  TRBusinessUserModel.m
//  TheRiverApp
//
//  Created by DenisDbv on 23.09.13.
//  Copyright (c) 2013 axbx. All rights reserved.
//

#import "TRBusinessUserModel.h"

@implementation TRBusinessUserModel
@synthesize id, company_name, logo, logo_cell, logo_desc, logo_profile, industries, about, profit, employees, desc;

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
        self.logo_cell = [aDecoder decodeObjectForKey:@"logo_cell"];
        self.logo_desc = [aDecoder decodeObjectForKey:@"logo_desc"];
        self.logo_profile = [aDecoder decodeObjectForKey:@"logo_profile"];
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
    [aCoder encodeObject:self.logo_cell forKey:@"logo_cell"];
    [aCoder encodeObject:self.logo_desc forKey:@"logo_desc"];
    [aCoder encodeObject:self.logo_profile forKey:@"logo_profile"];
    [aCoder encodeObject:self.logo forKey:@"logo"];
    [aCoder encodeObject:self.industries forKey:@"industries"];
    [aCoder encodeObject:self.about forKey:@"about"];
    [aCoder encodeObject:self.profit forKey:@"profit"];
    [aCoder encodeObject:self.employees forKey:@"employees"];
    [aCoder encodeObject:self.desc forKey:@"desc"];
}

@end
