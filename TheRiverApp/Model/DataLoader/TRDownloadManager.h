//
//  TRDownloadManager.h
//  TheRiverApp
//
//  Created by Admin on 22.09.13.
//  Copyright (c) 2013 axbx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TRDownloadManager : NSObject

+(instancetype)intsance;
-(void)download;
-(void)search:(NSString*)query;

@end
