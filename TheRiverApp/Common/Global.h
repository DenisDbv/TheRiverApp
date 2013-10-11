//
//  Global.h
//  TheRiverApp
//
//  Created by DenisDbv on 03.09.13.
//  Copyright (c) 2013 axbx. All rights reserved.
//

#ifndef TheRiverApp_Global_h
#define TheRiverApp_Global_h

#import "TRAppDelegate.h"

#define AppDelegateInstance() (TRAppDelegate *)[[UIApplication sharedApplication] delegate]

#define SERVER_HOSTNAME @"http://bmreki.ru"
#define ROW_HEIGHT  32.0

#define IS_IPHONE5 (([[UIScreen mainScreen] bounds].size.height-568)?NO:YES)
#define IS_OS_5_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 5.0)
#define IS_OS_6_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 6.0)
#define IS_OS_7_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)

#endif
