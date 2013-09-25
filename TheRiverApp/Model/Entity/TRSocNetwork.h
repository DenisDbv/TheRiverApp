//
//  TRSocNetwork.h
//  TheRiverApp
//
//  Created by Admin on 23.09.13.
//  Copyright (c) 2013 axbx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class TRContact;

@interface TRSocNetwork : NSManagedObject

@property (nonatomic, retain) NSString * skype;
@property (nonatomic, retain) NSString * facebook;
@property (nonatomic, retain) NSString * vkontakte;
@property (nonatomic, retain) NSString * twitter;
@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) TRContact *contact;

@end
