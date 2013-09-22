//
//  TRTel.h
//  TheRiverApp
//
//  Created by Admin on 22.09.13.
//  Copyright (c) 2013 axbx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface TRTel : NSManagedObject

@property (nonatomic, retain) NSString * number;
@property (nonatomic, retain) NSManagedObject *contact;

@end
