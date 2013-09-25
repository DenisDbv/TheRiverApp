//
//  NSManagedObject+Helper.m
//  TheRiverApp
//
//  Created by Admin on 22.09.13.
//  Copyright (c) 2013 axbx. All rights reserved.
//

#import "NSManagedObject+Helper.h"
#import "ObjectiveSugar.h"

@implementation NSManagedObject (Helper)

+(NSManagedObjectContext*)context
{
    return [AppDelegateInstance() managedObjectContext];
}

+ (id)create {
    NSManagedObjectContext* context = [self context];
    NSString* className = NSStringFromClass(self);
     return [NSEntityDescription insertNewObjectForEntityForName:className
                                  inManagedObjectContext:context];
}

- (BOOL)save {
    NSManagedObjectContext* context = [[self class] context];
    
    if (context == nil || ![context hasChanges]) return YES;
    
    NSError *error = nil;
    BOOL save = [context save:&error];
    
    if (!save || error) {
        NSLog(@"Unresolved error in saving context for entity:\n%@!\nError: %@", self, error);
        return NO;
    }
    
    return YES;
}

- (void)delete {
    NSManagedObjectContext* context = [[self class] context];
    [context deleteObject:self];
    [self save];
}

+(void)deleteAll{
    NSManagedObjectContext* context = [[self class] context];
    [[self fetchWithPredicate:nil inContext:context] each:^(id object) {
        [object delete];
    }];
}



+ (NSArray *)all {
    NSManagedObjectContext* context = [self context];
    return [self fetchWithPredicate:nil inContext:context];
}

+ (NSArray *)where:(id)condition {
    NSManagedObjectContext* context = [self context];
    NSPredicate *predicate = ([condition isKindOfClass:[NSPredicate class]]) ? condition
    : [self predicateFromStringOrDict:condition];
    
    return [self fetchWithPredicate:predicate inContext:context];
}


+ (NSString *)queryStringFromDictionary:(NSDictionary *)conditions {
    NSMutableString *queryString = [NSMutableString new];
        
    [conditions each:^(id attribute, id value) {
        [queryString appendFormat:@"%@ == '%@'", attribute, value];
        
        if (attribute == conditions.allKeys.last) return;
        [queryString appendString:@" AND "];
    }];
    
    return queryString;
}

+ (NSPredicate *)predicateFromStringOrDict:(id)condition {
    
    if ([condition isKindOfClass:[NSString class]])
        return [NSPredicate predicateWithFormat:condition];
    
    else if ([condition isKindOfClass:[NSDictionary class]])
        return [NSPredicate predicateWithFormat:[self queryStringFromDictionary:condition]];
    
    return nil;
}

+ (NSArray *)fetchWithPredicate:(NSPredicate *)predicate
                      inContext:(NSManagedObjectContext *)context {
    
    NSFetchRequest *request = [self createFetchRequestInContext:context];
    [request setPredicate:predicate];
    
    NSArray *fetchedObjects = [context executeFetchRequest:request error:nil];
    return fetchedObjects.count > 0 ? fetchedObjects : nil;
}

+ (NSFetchRequest *)createFetchRequestInContext:(NSManagedObjectContext *)context {
    NSFetchRequest *request = [NSFetchRequest new];
    NSEntityDescription *entity = [NSEntityDescription entityForName:NSStringFromClass(self)
                                              inManagedObjectContext:context];
    [request setEntity:entity];
    return request;
}

@end
