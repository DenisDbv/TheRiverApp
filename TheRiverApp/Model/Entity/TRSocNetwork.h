//
//  TRSocNetwork.h
//  TheRiverApp
//
//  Created by Admin on 22.09.13.
//  Copyright (c) 2013 axbx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class TRContact;

@interface TRSocNetwork : NSManagedObject

@property (nonatomic, retain) NSString * url;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) TRContact *contact;

@property (nonatomic, retain, readonly) NSString * twitter;
@property (nonatomic, retain, readonly) NSString * facebook;
@property (nonatomic, retain, readonly) NSString * vkotakte;

@end
