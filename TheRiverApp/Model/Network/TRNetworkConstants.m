//
//  TRNetworkConstants.m
//  TheRiverApp
//
//  Created by DenisDbv on 21.09.13.
//  Copyright (c) 2013 axbx. All rights reserved.
//

#import "TRNetworkConstants.h"

#pragma mark - Авторизация и ключи для авторизации
// Авторизация
NSString *const kTG_API_AuthUrl = @"http://kostum5.ru/api/login/";
// Ключи для авторизации
NSString *const kTGUserLoginKey = @"email";
NSString *const kTGUserPasswordKey = @"password";

//http://bmreki.ru
//http://kostum5.ru
NSString *const kTG_API_CitiesList = @"http://kostum5.ru/api/get_city_list/";
NSString *const kTG_API_IndustryList = @"http://kostum5.ru/api/get_scope_work_list/";
NSString *const kTG_API_PartyUsersList = @"http://kostum5.ru/api/search_1_method/";
NSString *const kTG_API_PartnersList = @"http://kostum5.ru/api/search_2_method/";
NSString *const kTG_API_BusinessList = @"http://kostum5.ru/api/get_all_business/";
NSString *const kTG_API_BusinessDesc = @"http://kostum5.ru/api/get_business_info/";
NSString *const kTG_API_ContactList = @"http://kostum5.ru/api/get_player_contact_list/";
NSString *const kTG_API_MeetingList = @"http://kostum5.ru/api/get_events_list/";
NSString *const kTG_API_MeetingSbscr = @"http://kostum5.ru/api/subscribe_event/";

NSString *const kTGTokenKey = @"token";
NSString *const kTGCityKey = @"city";
NSString *const kTGScopeWorkKey = @"scope_work";
NSString *const kTGQueryKey = @"query";