//
//  TRAppDelegate.m
//  TheRiverApp
//
//  Created by DenisDbv on 01.09.13.
//  Copyright (c) 2013 axbx. All rights reserved.
//

#import "TRAppDelegate.h"

#import "MFSideMenu.h"

#import "TRLoginViewController.h"
#import "TRAuthViewController.h"
#import "TRLeftRootMenuBar.h"
#import "TRMyContactListBar.h"
#import "TRTestViewController.h"
#import "TRScrollViewController.h"

@interface TRAppDelegate()
@property (nonatomic, retain) MFSideMenuContainerViewController *rootContainer;
@property (nonatomic, retain) UIViewController *mainController;
@property (nonatomic, retain) TRLeftRootMenuBar *leftRootMenuBar;
@property (nonatomic, retain) TRMyContactListBar *rightMyContactList;
@end

@implementation TRAppDelegate

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    NSLog(@"App path: %@", [[NSBundle mainBundle] resourcePath]);
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    [self updateDataFromServer];
    
    [self setupAppearance];
    
    if( [[TRAuthManager client] isAuth] == NO )
    {
        NSLog(@"User is not authorized");
        
        [self presentLoginViewController];
        
    } else
    {
        NSLog(@"User has been authenticated");
        
        [TRUserManager sharedInstance];
        
        [self presentTheRiverControllers];
    }
    
    //[self showFontsList];
    
    return YES;
}

-(void) updateDataFromServer
{
    [[TRSearchPUManager client] downloadCitiesList:nil andFailedOperation:nil];
    [[TRSearchPUManager client] downloadIndustryList:nil andFailedOperation:nil];
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    NSLog(@"%@", [url absoluteString]);
    
    if( [[TRAuthManager client] isAuth] == YES)
        return NO;
    
    /*NSLog(@"scheme: %@", [url scheme]);
    NSLog(@"host: %@", [url host]);
    NSLog(@"port: %@", [url port]);
    NSLog(@"path: %@", [url path]);
    NSLog(@"path components: %@", [url pathComponents]);
    NSLog(@"parameterString: %@", [url parameterString]);
    NSLog(@"query: %@", [url query]);
    NSLog(@"fragment: %@", [url fragment]);*/
    
    NSString *login = @"";
    NSString *queryString = [url query];
    NSArray *splitArray = [queryString componentsSeparatedByString:@"="];
    if(splitArray.count == 2)
        login = [splitArray objectAtIndex:1];
    
    [self presentAuthViewController:login];
    
    return YES;
}

- (void)setupAppearance {
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackOpaque];
    
    [[UINavigationBar appearance] setTintColor:[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.9]];
    
    [[UINavigationBar appearance] setShadowImage:[[UIImage alloc] init]];
}

- (void) presentLoginViewController
{
    TRLoginViewController *loginViewController = [[TRLoginViewController alloc] init];
    self.window.rootViewController = loginViewController;
    [self.window makeKeyAndVisible];
}

- (void) presentAuthViewController:(NSString*)login
{
    TRAuthViewController *authViewController = [[TRAuthViewController alloc] init];
    self.window.rootViewController = authViewController;
    [self.window makeKeyAndVisible];
    
    authViewController.loginField.text = login;
    [authViewController.passwordField becomeFirstResponder];
}

- (void) presentTheRiverControllers
{
    _leftRootMenuBar = [[TRLeftRootMenuBar alloc] init];
    _rightMyContactList = [[TRMyContactListBar alloc] init];
    _mainController = [[TRUserProfileController alloc] initByUserModel: [TRAuthManager client].iamData.user];
    _rootContainer = [MFSideMenuContainerViewController
                      containerWithCenterViewController: [[UINavigationController alloc] initWithRootViewController: _mainController]
                      leftMenuViewController: _leftRootMenuBar
                      rightMenuViewController: [[UINavigationController alloc] initWithRootViewController:_rightMyContactList]];
    [_rootContainer.shadow setEnabled:NO];
    
    self.window.rootViewController = _rootContainer;
    [self.window makeKeyAndVisible];
}

-(void) changeCenterViewController:(UIViewController*)newController
{   
    [_rootContainer.centerViewController setViewControllers:@[newController] animated:NO];
}

-(void) pushCenterViewController:(UIViewController*)newController
{
    [_rootContainer.centerViewController pushViewController:newController animated:YES];
}

-(void) changeProfileViewController:(TRUserProfileController*)newController
{
    id currentCenterController = [[_rootContainer.centerViewController viewControllers] objectAtIndex:0];
    
    if(![currentCenterController isKindOfClass:[TRUserProfileController class]])
    {
        [self changeCenterViewController:newController];
        return;
    }
    
    if( [newController.userDataObject.id integerValue] != [((TRUserProfileController*)currentCenterController).userDataObject.id integerValue] )
        [self changeCenterViewController:newController];
    
    /*if( ![newController.userDataObject.lastName isEqualToString:((TRUserProfileController*)currentCenterController).userDataObject.lastName] )
        [self changeCenterViewController:newController];*/
}

-(void) showFontsList
{
    NSArray *familyNames = [[NSArray alloc] initWithArray:[UIFont familyNames]];
    
    NSArray *fontNames;
    NSInteger indFamily, indFont;
    for (indFamily=0; indFamily<[familyNames count]; ++indFamily)
    {
        NSLog(@"Family name: %@", [familyNames objectAtIndex:indFamily]);
        fontNames = [[NSArray alloc] initWithArray:
                     [UIFont fontNamesForFamilyName:
                      [familyNames objectAtIndex:indFamily]]];
        for (indFont=0; indFont<[fontNames count]; ++indFont)
        {
            NSLog(@"    Font name: %@", [fontNames objectAtIndex:indFont]);
        }
    }
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
             // Replace this implementation with code to handle the error appropriately.
             // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        } 
    }
}

#pragma mark - Core Data stack

// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"TheRiverApp" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"TheRiverApp.sqlite"];
    
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter:
         @{NSMigratePersistentStoresAutomaticallyOption:@YES, NSInferMappingModelAutomaticallyOption:@YES}
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }    
    
    return _persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

@end
