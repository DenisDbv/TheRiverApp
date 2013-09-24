//
//  TRContact.h
//  TheRiverApp
//
//  Created by Admin on 22.09.13.
//  Copyright (c) 2013 axbx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "NSManagedObject+Helper.h"

@class TRSocNetwork, TRTel;

@interface TRContact : NSManagedObject

@property (nonatomic, retain) NSString * city;
@property (nonatomic, retain) NSString * firstName;
@property (nonatomic, retain) NSString * lastName;
@property (nonatomic) int32_t id;
@property (nonatomic, retain) NSString * logo;
@property (nonatomic) BOOL isStar;
@property (nonatomic, retain) NSSet *tel;
@property (nonatomic, retain) NSSet *socNetwork;
@end

@interface TRContact (CoreDataGeneratedAccessors)

- (void)addTelObject:(TRTel *)value;
- (void)removeTelObject:(TRTel *)value;
- (void)addTel:(NSSet *)values;
- (void)removeTel:(NSSet *)values;

- (void)addSocNetworkObject:(TRSocNetwork *)value;
- (void)removeSocNetworkObject:(TRSocNetwork *)value;
- (void)addSocNetwork:(NSSet *)values;
- (void)removeSocNetwork:(NSSet *)values;

+(NSArray*)favorite;
+(NSArray*)notFavorite;
+(NSArray*)filterNotFavorite:(NSString*)text;

@end
