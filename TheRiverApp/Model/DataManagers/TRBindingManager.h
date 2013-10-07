//
//  TRBindingManager.h
//  TheRiverApp
//
//  Created by DenisDbv on 03.10.13.
//  Copyright (c) 2013 axbx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ABMultiton/ABMultitonProtocol.h>
#import <ABMultiton/ABMultiton.h>

@interface TRBindingManager : NSObject <ABMultitonProtocol>

-(void) skypeBinding:(TRUserInfoModel*)userModel;
-(void) callBinding:(TRUserInfoModel*)userModel;
-(void) vkBinding:(TRUserInfoModel*)userModel;
-(void) fbBinding:(TRUserInfoModel*)userModel;
-(void) emailBinding:(TRUserInfoModel*)userModel;
-(void) smsBinding:(TRUserInfoModel*)userModel;

@end
