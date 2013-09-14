//
//  TRAppDelegate.h
//  TheRiverApp
//
//  Created by DenisDbv on 01.09.13.
//  Copyright (c) 2013 axbx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TRUserProfileController.h"

@interface TRAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

-(void) changeCenterViewController:(UIViewController*)newController;
-(void) changeProfileViewController:(TRUserProfileController*)newController;

@end
