//
//  NSManagedObject+Helper.h
//  TheRiverApp
//
//  Created by Admin on 22.09.13.
//  Copyright (c) 2013 axbx. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface NSManagedObject (Helper)

+ (id)create;

- (BOOL)save;
- (void)delete;

+ (NSArray *)all;
+ (NSArray *)where:(id)condition;

@end
