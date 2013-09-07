//
//  TRUserManager.m
//  TheRiverApp
//
//  Created by DenisDbv on 07.09.13.
//  Copyright (c) 2013 axbx. All rights reserved.
//

#import "TRUserManager.h"
#import <ABMultiton/ABMultiton.h>

#import "TRUserModel.h"

@interface TRUserManager()

@end

@implementation TRUserManager

@synthesize usersObject;

+ (instancetype)sharedIsntance
{
    return [ABMultiton sharedInstanceOfClass:[self class]];
}

-(id) init
{
    [self createsUserObjects];
    
    return [super init];
}

-(void) createsUserObjects
{
    TRUserModel *userModel1 = [[TRUserModel alloc] init];
    userModel1.logo = @"IamAppleDev.jpg";
    userModel1.firstName = @"Дубов";
    userModel1.lastName = @"Денис";
    userModel1.yearsOld = @"28 лет";
    userModel1.city = @"Гонконг";
    
    usersObject = [[NSArray alloc] initWithObjects:userModel1, nil];
}

@end
