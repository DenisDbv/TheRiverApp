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
NSString *const kTG_API_AuthUrl = @"http://bmreki.ru/api/login/";
NSString *const kTG_API_AuthProfilerefresh = @"http://bmreki.ru/api/get_profile_info/?token=%@&id=%@";
// Ключи для авторизации
NSString *const kTGUserLoginKey = @"email";
NSString *const kTGUserPasswordKey = @"password";

//http://bmreki.ru
//http://bmreki.ru
NSString *const kTG_API_CitiesList = @"http://bmreki.ru/api/get_city_list/";
NSString *const kTG_API_IndustryList = @"http://bmreki.ru/api/get_scope_work_list/";
NSString *const kTG_API_PartyUsersList = @"http://bmreki.ru/api/search_1_method/";
NSString *const kTG_API_PartnersList = @"http://bmreki.ru/api/search_2_method/";
NSString *const kTG_API_BusinessList = @"http://bmreki.ru/api/get_all_business/";
NSString *const kTG_API_BusinessDesc = @"http://bmreki.ru/api/get_business_info/";
NSString *const kTG_API_ContactList = @"http://bmreki.ru/api/get_player_contact_list/";
NSString *const kTG_API_MeetingList = @"http://bmreki.ru/api/get_events_list/";
NSString *const kTG_API_MeetingSbscr = @"http://bmreki.ru/api/subscribe_event/";
NSString *const kTG_API_NewsList = @"http://bmreki.ru/api/get_news_list/?token=%@&page=%i&last_entry=%@"; //token, page, last refresh date news
NSString *const kTG_API_NewsDesc = @"http://bmreki.ru/api/get_news/?token=%@&id=%@";   //token, id
NSString *const kTG_API_MindList = @"http://bmreki.ru/api/get_bd_list/?token=%@&page=%i";   //token, page
NSString *const kTG_API_MindDesc = @"http://bmreki.ru/api/get_bd_knowlege/?token=%@&id=%@";
NSString *const kTG_API_MindSearch = @"http://bmreki.ru/api/search_knowlege_method/";

NSString *const kTGTokenKey = @"token";
NSString *const kTGCityKey = @"city";
NSString *const kTGScopeWorkKey = @"scope_work";
NSString *const kTGQueryKey = @"query";