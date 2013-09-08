//
//  TRUserManager.m
//  TheRiverApp
//
//  Created by DenisDbv on 07.09.13.
//  Copyright (c) 2013 axbx. All rights reserved.
//

#import "TRUserManager.h"
#import "TRUserModel.h"

@interface TRUserManager()

@end

@implementation TRUserManager

@synthesize usersObject;

+ (instancetype)sharedInstance
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
    userModel1.firstName = @"Денис";
    userModel1.lastName = @"Дубов";
    userModel1.yearsOld = @"28 лет";
    userModel1.city = @"Гонконг";
    userModel1.businessLogo = @"background.jpg";
    userModel1.businessTitle = @"Бассейны в кредит";
    userModel1.businessBeforeTitle = @"Было: 100000 рублей";
    userModel1.businessAfterTitle = @"Стало: 5 000 000 рублей";
    
    usersObject = [[NSArray alloc] initWithObjects:userModel1, nil];
}

@end
