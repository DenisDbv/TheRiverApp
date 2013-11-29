//
//  TRAppDelegate.m
//  TheRiverApp
//
//  Created by DenisDbv on 01.09.13.
//  Copyright (c) 2013 axbx. All rights reserved.
//

#import "TRAppDelegate.h"

#import "MFSideMenu.h"
#import "OBAlert.h"

#import "TRAuthViewController.h"
#import "TRLeftRootMenuBar.h"
#import "TRMyContactListBar.h"
#import "TRTestViewController.h"
#import "TRScrollViewController.h"
#import "TRNavigationController.h"

#import <Harpy/Harpy.h>
#import <Reachability/Reachability.h>
#import <YRDropdownView/YRDropdownView.h>
#import <ISDiskCache/ISDiskCache.h>
#import <SIAlertView/SIAlertView.h>
#import <JSONKit/JSONKit.h>

#import "PW_SBJsonParser.h"

#import "TRMindBaseListVC.h"
#import "TRMeetingsBaseListVC.h"
#import "TRNewsListVC.h"
#import "Toast+UIView.h"

@interface TRAppDelegate()
@property (nonatomic, copy) NSData *pushToken;

@property (nonatomic, retain) MFSideMenuContainerViewController *rootContainer;
@property (nonatomic, retain) UIViewController *mainController;
@property (nonatomic, retain) TRLeftRootMenuBar *leftRootMenuBar;
@property (nonatomic, retain) TRMyContactListBar *rightMyContactList;
@end

@implementation TRAppDelegate
{
    OBAlert *alert;
    
}

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

-(NSInteger) osVersion
{
    NSArray *versionCompatibility = [[UIDevice currentDevice].systemVersion componentsSeparatedByString:@"."];
    return [[versionCompatibility objectAtIndex:0] intValue];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    NSLog(@"App path: %@", [[NSBundle mainBundle] resourcePath]);
    
    [Glazum setOptions:@{GlazumOptionDebug:@YES}];
    
    [self registerDevice];
    
    //set custom delegate for push handling
	PushNotificationManager * pushManager = [PushNotificationManager pushManager];
	pushManager.delegate = self;
	if ([launchOptions objectForKey:UIApplicationLaunchOptionsLocationKey]) {
		PushNotificationManager * pushManager = [PushNotificationManager pushManager];
		[pushManager startLocationTracking];
    }
    
    [ISDiskCache sharedCache].limitOfSize = 10 * 1024 * 1024; // 10MB
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
        [application setStatusBarStyle:UIStatusBarStyleLightContent];
        self.window.clipsToBounds = YES;
        self.window.frame =  CGRectMake(0,20,self.window.frame.size.width,self.window.frame.size.height-20);
        
        //Added on 19th Sep 2013
        self.window.bounds = CGRectMake(0, 20, self.window.frame.size.width, self.window.frame.size.height);
    }
    
    [self setupAppearance];
    
    if( [[TRAuthManager client] isAuth] == NO )
    {
        NSLog(@"User is not authorized");
        
        [self presentLoginViewController];
        
    } else
    {
        NSLog(@"User has been authenticated by token: %@", [TRAuthManager client].iamData.token);
        
        [self registerUserForFeedBack];
        
        [self presentTheRiverControllers];
        
        [self checkBusinessURL];
    }
    
    //[self showFontsList];
    
    [[Harpy sharedInstance] setAppID:@"725299549"];
    [[Harpy sharedInstance] setAppName:@"The River"];
    [[Harpy sharedInstance] setAlertType:HarpyAlertTypeForce];
    [[Harpy sharedInstance] checkVersion];
    
    Reachability* reach = [Reachability reachabilityForInternetConnection];
    reach.reachableBlock = ^(Reachability*reach)
    {
        [YRDropdownView hideDropdownInView:self.window animated:YES];
    };
    reach.unreachableBlock = ^(Reachability*reach)
    {
        NSLog(@"Internet access denied");
        UIViewController *rootViewController = [UIApplication sharedApplication].delegate.window.rootViewController;
        
        [YRDropdownView showDropdownInView:rootViewController.view.window
                                     title:@"Предупреждение!"
                                    detail:@"Не обнаружено подключение к интернету.\nВсе процессы в приложении будут временно приостановлены, до возобновления подключения."
                                     image:[UIImage imageNamed:@"dropdown-alert"]
                                  animated:YES
                                 hideAfter:10];
    };
    [reach startNotifier];
    
    return YES;
}

-(void) checkBusinessURL
{
    /*if([TRAuthManager client].iamData.user.url.length == 0) {
        SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:nil andMessage:@"Хотите ли вы указать сайт для своего бизнеса?"];
        alertView.messageFont = [UIFont fontWithName:@"HypatiaSansPro-Medium" size:18];
        [alertView addButtonWithTitle:@"НЕТ"
                                 type:SIAlertViewButtonTypeCancel
                              handler:^(SIAlertView *alertView) {
                                  
                                  NSLog(@"Cancel Clicked");
                              }];
        [alertView addButtonWithTitle:@"ДА"
                                 type:SIAlertViewButtonTypeDefault
                              handler:^(SIAlertView *alertView) {
                                  NSString *urlDirect = [NSString stringWithFormat:@"%@/edit_3/?token=%@", SERVER_HOSTNAME, [TRAuthManager client].iamData.token];
                                  [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlDirect]];
                              }];
        [alertView show];
    }*/
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    BOOL result = [[userDefaults objectForKey:@"disable_alert_profile_edit"] boolValue];
    
    if( (([TRAuthManager client].iamData.user.url.length == 0) || ([TRAuthManager client].iamData.user.contact_data.thegame.length == 0)) && !result )
    {
        SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:nil andMessage:@"Профили участников обновлены, хотите дополнить свой профиль ссылкой на сайт бизнеса и ссылкой на свою страницу THE GAME? (если вы участвуете)"];
        alertView.messageFont = [UIFont fontWithName:@"HypatiaSansPro-Regular" size:18];
        [alertView addButtonWithTitle:@"ПОЗЖЕ"
                                 type:SIAlertViewButtonTypeCancel
                              handler:^(SIAlertView *alertView) {
                                  
                                  NSLog(@"Cancel Clicked");
                                  
                                  NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                                  [userDefaults setObject:[NSNumber numberWithBool:YES] forKey:@"disable_alert_profile_edit"];
                                  [userDefaults synchronize];
                                  
                                  UIViewController *test =  _rootContainer.centerViewController;
                                  [test.view makeToast:@"Вы сможете дополнить информацию позже, в настройках своего профиля." duration:5.0 position:nil];
                              }];
        [alertView addButtonWithTitle:@"ДА"
                                 type:SIAlertViewButtonTypeDefault
                              handler:^(SIAlertView *alertView) {
                                  NSString *urlDirect = [NSString stringWithFormat:@"%@/editurl/?token=%@", SERVER_HOSTNAME, [TRAuthManager client].iamData.token];
                                  [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlDirect]];
                              }];
        [alertView show];
    }
}

-(void) setStatusBarHide:(BOOL)status
{
    if(status)  {
        [[UIApplication sharedApplication] setStatusBarHidden:YES];
        self.window.frame =  CGRectMake(0,0, self.window.frame.size.width,self.window.frame.size.height);
        self.window.bounds = CGRectMake(0,0, self.window.frame.size.width, self.window.frame.size.height);
    } else  {
        [[UIApplication sharedApplication] setStatusBarHidden:NO];
        if(IS_OS_7_OR_LATER)    {
            self.window.frame =  CGRectMake(0,20, self.window.frame.size.width,self.window.frame.size.height-20);
            self.window.bounds = CGRectMake(0,20, self.window.frame.size.width, self.window.frame.size.height);
        }
    }
}

-(void) logout
{
    [_rightMyContactList removeTimer];
    [[TRAuthManager client] logout];
    [AppDelegateInstance() presentLoginViewController];
}

-(void) showServerErrorMessage
{
    UIViewController *rootViewController = [UIApplication sharedApplication].delegate.window.rootViewController;
    
    if(alert == nil)    {
        alert = [[OBAlert alloc] initInViewController:rootViewController];
        [alert showAlertWithText:@"Возможно на сервере идут технические работы. Пожалуйста авторизируйтесь в системе заного. Заранее просим прощения за связанные с этим неудобства."
                       titleText:@"Ошибка связи"
                      buttonText:@"Авторизоваться"
                           onTap:^{
                               [alert removeAlert];
                               
                               [self logout];
                           }];
    }
}

//succesfully registered for push notifications
- (void) onDidRegisterForRemoteNotificationsWithDeviceToken:(NSString *)token {
	NSLog(@"%@", [NSString stringWithFormat:@"Registered with push token: %@", token] );
}

//failed to register for push notifications
- (void) onDidFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
	NSLog(@"%@",[NSString stringWithFormat:@"Failed to register: %@", [error description]]);
}

//user pressed OK on the push notification
- (void) onPushAccepted:(PushNotificationManager *)pushManager withNotification:(NSDictionary *)pushNotification {

}

- (void) onPushReceived:(PushNotificationManager *)pushManager withNotification:(NSDictionary *)pushNotification onStart:(BOOL)onStart
{
    [PushNotificationManager clearNotificationCenter];
	
	NSLog(@"%@",[NSString stringWithFormat:@"Received push notification: %@", pushNotification] );
    
    NSString *customDataString = [pushManager getCustomPushData:pushNotification];
    
    NSDictionary *jsonData = [customDataString objectFromJSONString];
    
    if(onStart) {
     [self checkAndOpenWindowAfterPushNotifications:[[jsonData objectForKey:@"window_open"] integerValue]];
    } else  {
        UIViewController *test =  _rootContainer.centerViewController;
        switch ([[jsonData objectForKey:@"window_open"] integerValue]) {
            case 1: //Новости
            {
                [test.view makeToast:@"Добавлена новость" duration:3.0 position:nil];
            }
                break;
            case 2: //Мероприятия
            {
                [test.view makeToast:@"Добавлено мероприятие" duration:3.0 position:nil];
            }
                break;
            case 3: //База знаний
            {
                [test.view makeToast:@"Добавлено знание" duration:3.0 position:nil];
            }
                break;
                
            default:
                break;
        }
    }
}

-(void) checkAndOpenWindowAfterPushNotifications:(NSInteger)index
{
    switch (index) {
        case 1: //Новости
        {
            TRNewsListVC *newsListVC = [[TRNewsListVC alloc] init];
            [self changeCenterViewController:newsListVC];
        }
            break;
        case 2: //Мероприятия
        {
            TRMeetingsBaseListVC *meetingBaseList = [[TRMeetingsBaseListVC alloc] init];
            [self changeCenterViewController:meetingBaseList];
        }
            break;
        case 3: //База знаний
        {
            TRMindBaseListVC *mindBaseList = [[TRMindBaseListVC alloc] init];
            [self changeCenterViewController:mindBaseList];
        }
            break;
            
        default:
            break;
    }
}

-(NSData*) getDeviceToken
{
    return self.pushToken;
}

-(void) registerUserForFeedBack
{
    [Glazum setUserIdentifier:[TRAuthManager client].iamData.email];
    NSLog(@"Feedback registered device: %@", [TRAuthManager client].iamData.email);
}

-(void) registerDevice
{
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes: (UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert)];
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken  {
    self.pushToken = deviceToken;
    NSLog(@"My push token is: %@", deviceToken);
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSLog(@"Failed to get push token, error: %@", error);
}

- (void) application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    NSLog(@"Received notification: %@", userInfo);
}

-(void) updateDataFromServer
{
    [[TRAuthManager client] refreshAuthUserProfile:^(LRRestyResponse *response) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"RefreshIam" object:nil];
    } andFailedOperation:^(LRRestyResponse *response) {
        //
    }];
    
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
    
    NSDictionary *attributes =
    [NSDictionary dictionaryWithObjectsAndKeys:
     [UIColor blackColor], UITextAttributeTextColor,
     [UIColor clearColor], UITextAttributeTextShadowColor,
     [NSValue valueWithUIOffset:UIOffsetMake(0, 0)], UITextAttributeTextShadowOffset,
     [UIFont systemFontOfSize:14], UITextAttributeFont,
     nil];
    [[UIBarButtonItem appearanceWhenContainedIn:[UISearchBar class], nil]
     setTitleTextAttributes:attributes forState:UIControlStateNormal];
    [[UIBarButtonItem appearanceWhenContainedIn:[UISearchBar class], nil]
     setTitleTextAttributes:attributes forState:UIControlStateHighlighted];
    
    /*[[UINavigationBar appearance] setBackgroundImage:[[UIImage alloc] init]
                                      forBarPosition:UIBarPositionAny
                                          barMetrics:UIBarMetricsDefault];*/
    
    //[[UINavigationBar appearance] setShadowImage:[[UIImage alloc] init]];
    
    //[[UINavigationBar appearance] setTintColor:[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.9]];
    //[[UINavigationBar appearance] setShadowImage:[[UIImage alloc] init]];
    
    /*NSMutableDictionary *attributes = [[NSMutableDictionary alloc] init];
    [attributes setValue:[UIColor blackColor] forKey:UITextAttributeTextColor];
    [attributes setValue:[UIColor whiteColor] forKey:UITextAttributeTextShadowColor];
    [attributes setValue:[NSValue valueWithUIOffset:UIOffsetMake(0, 1)] forKey:UITextAttributeTextShadowOffset];
    [attributes setValue:[UIFont fontWithName:@"Verdana" size:0.0] forKey:UITextAttributeFont];
    
    [[UIBarButtonItem appearance] setTitleTextAttributes:attributes forState:UIControlStateNormal];*/
}

- (void) presentLoginViewController
{
    //TRLoginViewController *loginViewController = [[TRLoginViewController alloc] init];
    TRAuthViewController *authViewController = [[TRAuthViewController alloc] init];
    self.window.rootViewController = authViewController;
    [self.window makeKeyAndVisible];
}

- (void) presentAuthViewController:(NSString*)login
{
    TRAuthViewController *authViewController = [[TRAuthViewController alloc] init];
    self.window.rootViewController = authViewController;
    [self.window makeKeyAndVisible];
    
    //authViewController.loginField.text = login;
    //[authViewController.passwordField becomeFirstResponder];
}

- (void) presentTheRiverControllers
{
    _leftRootMenuBar = [[TRLeftRootMenuBar alloc] init];
    _rightMyContactList = [[TRMyContactListBar alloc] init];
    _mainController = [[TRUserProfileController alloc] initByUserModel: [TRAuthManager client].iamData.user isIam:YES];
    _rootContainer = [MFSideMenuContainerViewController
                      containerWithCenterViewController: [[TRNavigationController alloc] initWithRootViewController: _mainController]
                      leftMenuViewController: [[TRNavigationController alloc] initWithRootViewController:_leftRootMenuBar]
                      rightMenuViewController: [[TRNavigationController alloc] initWithRootViewController:_rightMyContactList]];
    [_rootContainer.shadow setEnabled:NO];
    
    self.window.rootViewController = _rootContainer;
    [self.window makeKeyAndVisible];
}

-(void) presentModalViewController:(UIViewController*)controller
{
    [_rootContainer presentViewController:controller animated:YES completion:nil];
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
    
    if([_rootContainer.centerViewController viewControllers].count > 1)
        [self changeCenterViewController:newController];
}

-(void) showBadgeNews:(NSInteger)newsCount
{
    [_leftRootMenuBar showBadgeNews:newsCount];
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
    NSLog(@"Start application from background");
    
    [Glazum startUp:@"3f05f6ff-df50-4071-b16f-a8c2def19648"];
    
    [[Harpy sharedInstance] checkVersionDaily];
    
    [self updateDataFromServer];
    
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
