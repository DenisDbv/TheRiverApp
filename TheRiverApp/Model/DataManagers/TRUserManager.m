//
//  TRUserManager.m
//  TheRiverApp
//
//  Created by DenisDbv on 07.09.13.
//  Copyright (c) 2013 axbx. All rights reserved.
//

#import "TRUserManager.h"
#import "TRUserModel.h"
#import "TRMeetingModel.h"

@interface TRUserManager()

@end

@implementation TRUserManager

@synthesize usersObject;
@synthesize mindObjects;
@synthesize businessObjects;
@synthesize meetingObjects;

+ (instancetype)sharedInstance
{
    return [ABMultiton sharedInstanceOfClass:[self class]];
}

-(id) init
{
    [self createsUserObjects];
    
    [self createMindObjects];
    
    [self createBusinessObjects];
    
    [self createMeetingObjects];
    
    return [super init];
}

-(void) createsUserObjects
{
    TRUserModel *userModel1 = [[TRUserModel alloc] init];
    userModel1.logo = @"1.jpg";
    userModel1.firstName = @"Анастасия";
    userModel1.lastName = @"Затевахина";
    userModel1.yearsOld = @"23 года";
    userModel1.city = @"Москва";
    userModel1.businessLogo = @"background.jpg";
    userModel1.businessTitle = @"Бассейны в кредит";
    userModel1.businessBeforeTitle = @"Было: 100000 рублей";
    userModel1.businessAfterTitle = @"Стало: 5 000 000 рублей";
    userModel1.contactPhone = @"+79275551234";
    userModel1.contactEmail = @"denisdbv@mail.ru";
    userModel1.contactVK = @"http://vk.com/denisdbv";
    userModel1.contactFB = @"http://facebook.ru/profile";
    userModel1.contactTwitter = @"http://twitter.com/profile";
    
    TRUserModel *userModel2 = [[TRUserModel alloc] init];
    userModel2.logo = @"2.jpg";
    userModel2.firstName = @"Артем";
    userModel2.lastName = @"Уколов";
    userModel2.yearsOld = @"28 лет";
    userModel2.city = @"Чебоксары";
    userModel2.businessLogo = @"background.jpg";
    userModel2.businessTitle = @"Бассейны в кредит";
    userModel2.businessBeforeTitle = @"Было: 100000 рублей";
    userModel2.businessAfterTitle = @"Стало: 5 000 000 рублей";
    userModel2.contactPhone = @"+79275551234";
    userModel2.contactEmail = @"denisdbv@mail.ru";
    userModel2.contactVK = @"http://vk.com/denisdbv";
    userModel2.contactFB = @"http://facebook.ru/profile";
    userModel2.contactTwitter = @"http://twitter.com/profile";
    
    TRUserModel *userModel3 = [[TRUserModel alloc] init];
    userModel3.logo = @"3.jpg";
    userModel3.firstName = @"Роман";
    userModel3.lastName = @"Малышев";
    userModel3.yearsOld = @"28 лет";
    userModel3.city = @"Гонконг";
    userModel3.businessLogo = @"background.jpg";
    userModel3.businessTitle = @"Бассейны в кредит";
    userModel3.businessBeforeTitle = @"Было: 100000 рублей";
    userModel3.businessAfterTitle = @"Стало: 5 000 000 рублей";
    userModel3.contactPhone = @"+79275551234";
    userModel3.contactEmail = @"denisdbv@mail.ru";
    userModel3.contactVK = @"http://vk.com/denisdbv";
    userModel3.contactFB = @"http://facebook.ru/profile";
    userModel3.contactTwitter = @"http://twitter.com/profile";
    
    TRUserModel *userModel4 = [[TRUserModel alloc] init];
    userModel4.logo = @"4.jpg";
    userModel4.firstName = @"Михаил";
    userModel4.lastName = @"Якимов";
    userModel4.yearsOld = @"28 лет";
    userModel4.city = @"Гонконг";
    userModel4.businessLogo = @"background.jpg";
    userModel4.businessTitle = @"Бассейны в кредит";
    userModel4.businessBeforeTitle = @"Было: 100000 рублей";
    userModel4.businessAfterTitle = @"Стало: 5 000 000 рублей";
    userModel4.contactPhone = @"+79275551234";
    userModel4.contactEmail = @"denisdbv@mail.ru";
    userModel4.contactVK = @"http://vk.com/denisdbv";
    userModel4.contactFB = @"http://facebook.ru/profile";
    userModel4.contactTwitter = @"http://twitter.com/profile";
    
    TRUserModel *userModel5 = [[TRUserModel alloc] init];
    userModel5.logo = @"5.jpg";
    userModel5.firstName = @"Игорь";
    userModel5.lastName = @"Чередник";
    userModel5.yearsOld = @"28 лет";
    userModel5.city = @"Гонконг";
    userModel5.businessLogo = @"background.jpg";
    userModel5.businessTitle = @"Бассейны в кредит";
    userModel5.businessBeforeTitle = @"Было: 100000 рублей";
    userModel5.businessAfterTitle = @"Стало: 5 000 000 рублей";
    userModel5.contactPhone = @"+79275551234";
    userModel5.contactEmail = @"denisdbv@mail.ru";
    userModel5.contactVK = @"http://vk.com/denisdbv";
    userModel5.contactFB = @"http://facebook.ru/profile";
    userModel5.contactTwitter = @"http://twitter.com/profile";
    
    TRUserModel *userModel6 = [[TRUserModel alloc] init];
    userModel6.logo = @"6.jpg";
    userModel6.firstName = @"Алина";
    userModel6.lastName = @"Жукова";
    userModel6.yearsOld = @"28 лет";
    userModel6.city = @"Гонконг";
    userModel6.businessLogo = @"background.jpg";
    userModel6.businessTitle = @"Бассейны в кредит";
    userModel6.businessBeforeTitle = @"Было: 100000 рублей";
    userModel6.businessAfterTitle = @"Стало: 5 000 000 рублей";
    userModel6.contactPhone = @"+79275551234";
    userModel6.contactEmail = @"denisdbv@mail.ru";
    userModel6.contactVK = @"http://vk.com/denisdbv";
    userModel6.contactFB = @"http://facebook.ru/profile";
    userModel6.contactTwitter = @"http://twitter.com/profile";
    
    TRUserModel *userModel7 = [[TRUserModel alloc] init];
    userModel7.logo = @"7.jpg";
    userModel7.firstName = @"Оксана";
    userModel7.lastName = @"Копылова";
    userModel7.yearsOld = @"28 лет";
    userModel7.city = @"Гонконг";
    userModel7.businessLogo = @"background.jpg";
    userModel7.businessTitle = @"Бассейны в кредит";
    userModel7.businessBeforeTitle = @"Было: 100000 рублей";
    userModel7.businessAfterTitle = @"Стало: 5 000 000 рублей";
    userModel7.contactPhone = @"+79275551234";
    userModel7.contactEmail = @"denisdbv@mail.ru";
    userModel7.contactVK = @"http://vk.com/denisdbv";
    userModel7.contactFB = @"http://facebook.ru/profile";
    userModel7.contactTwitter = @"http://twitter.com/profile";
    
    TRUserModel *userModel8 = [[TRUserModel alloc] init];
    userModel8.logo = @"8.jpg";
    userModel8.firstName = @"Вадим";
    userModel8.lastName = @"Байчук";
    userModel8.yearsOld = @"28 лет";
    userModel8.city = @"Гонконг";
    userModel8.businessLogo = @"background.jpg";
    userModel8.businessTitle = @"Бассейны в кредит";
    userModel8.businessBeforeTitle = @"Было: 100000 рублей";
    userModel8.businessAfterTitle = @"Стало: 5 000 000 рублей";
    userModel8.contactPhone = @"+79275551234";
    userModel8.contactEmail = @"denisdbv@mail.ru";
    userModel8.contactVK = @"http://vk.com/denisdbv";
    userModel8.contactFB = @"http://facebook.ru/profile";
    userModel8.contactTwitter = @"http://twitter.com/profile";
    
    TRUserModel *userModel9 = [[TRUserModel alloc] init];
    userModel9.logo = @"9.jpg";
    userModel9.firstName = @"Артур";
    userModel9.lastName = @"Файзрахманов";
    userModel9.yearsOld = @"28 лет";
    userModel9.city = @"Гонконг";
    userModel9.businessLogo = @"background.jpg";
    userModel9.businessTitle = @"Бассейны в кредит";
    userModel9.businessBeforeTitle = @"Было: 100000 рублей";
    userModel9.businessAfterTitle = @"Стало: 5 000 000 рублей";
    userModel9.contactPhone = @"+79275551234";
    userModel9.contactEmail = @"denisdbv@mail.ru";
    userModel9.contactVK = @"http://vk.com/denisdbv";
    userModel9.contactFB = @"http://facebook.ru/profile";
    userModel9.contactTwitter = @"http://twitter.com/profile";
    
    TRUserModel *userModel10 = [[TRUserModel alloc] init];
    userModel10.logo = @"10.jpg";
    userModel10.firstName = @"Александра";
    userModel10.lastName = @"Хамич";
    userModel10.yearsOld = @"28 лет";
    userModel10.city = @"Гонконг";
    userModel10.businessLogo = @"background.jpg";
    userModel10.businessTitle = @"Бассейны в кредит";
    userModel10.businessBeforeTitle = @"Было: 100000 рублей";
    userModel10.businessAfterTitle = @"Стало: 5 000 000 рублей";
    userModel10.contactPhone = @"+79275551234";
    userModel10.contactEmail = @"denisdbv@mail.ru";
    userModel10.contactVK = @"http://vk.com/denisdbv";
    userModel10.contactFB = @"http://facebook.ru/profile";
    userModel10.contactTwitter = @"http://twitter.com/profile";
    
    TRUserModel *userModel11 = [[TRUserModel alloc] init];
    userModel11.logo = @"11.jpg";
    userModel11.firstName = @"Артём";
    userModel11.lastName = @"Карцызин";
    userModel11.yearsOld = @"28 лет";
    userModel11.city = @"Гонконг";
    userModel11.businessLogo = @"background.jpg";
    userModel11.businessTitle = @"Бассейны в кредит";
    userModel11.businessBeforeTitle = @"Было: 100000 рублей";
    userModel11.businessAfterTitle = @"Стало: 5 000 000 рублей";
    userModel11.contactPhone = @"+79275551234";
    userModel11.contactEmail = @"denisdbv@mail.ru";
    userModel11.contactVK = @"http://vk.com/denisdbv";
    userModel11.contactFB = @"http://facebook.ru/profile";
    userModel11.contactTwitter = @"http://twitter.com/profile";
    
    TRUserModel *userModel12 = [[TRUserModel alloc] init];
    userModel12.logo = @"12.jpg";
    userModel12.firstName = @"Кирилл";
    userModel12.lastName = @"Гуреев";
    userModel12.yearsOld = @"28 лет";
    userModel12.city = @"Гонконг";
    userModel12.businessLogo = @"background.jpg";
    userModel12.businessTitle = @"Бассейны в кредит";
    userModel12.businessBeforeTitle = @"Было: 100000 рублей";
    userModel12.businessAfterTitle = @"Стало: 5 000 000 рублей";
    userModel12.contactPhone = @"+79275551234";
    userModel12.contactEmail = @"denisdbv@mail.ru";
    userModel12.contactVK = @"http://vk.com/denisdbv";
    userModel12.contactFB = @"http://facebook.ru/profile";
    userModel12.contactTwitter = @"http://twitter.com/profile";
    
    TRUserModel *userModel13 = [[TRUserModel alloc] init];
    userModel13.logo = @"13.jpg";
    userModel13.firstName = @"Ксения";
    userModel13.lastName = @"Ильиных";
    userModel13.yearsOld = @"28 лет";
    userModel13.city = @"Гонконг";
    userModel13.businessLogo = @"background.jpg";
    userModel13.businessTitle = @"Бассейны в кредит";
    userModel13.businessBeforeTitle = @"Было: 100000 рублей";
    userModel13.businessAfterTitle = @"Стало: 5 000 000 рублей";
    userModel13.contactPhone = @"+79275551234";
    userModel13.contactEmail = @"denisdbv@mail.ru";
    userModel13.contactVK = @"http://vk.com/denisdbv";
    userModel13.contactFB = @"http://facebook.ru/profile";
    userModel13.contactTwitter = @"http://twitter.com/profile";
    
    TRUserModel *userModel14 = [[TRUserModel alloc] init];
    userModel14.logo = @"14.jpg";
    userModel14.firstName = @"Антон";
    userModel14.lastName = @"Гиричев";
    userModel14.yearsOld = @"28 лет";
    userModel14.city = @"Гонконг";
    userModel14.businessLogo = @"background.jpg";
    userModel14.businessTitle = @"Бассейны в кредит";
    userModel14.businessBeforeTitle = @"Было: 100000 рублей";
    userModel14.businessAfterTitle = @"Стало: 5 000 000 рублей";
    userModel14.contactPhone = @"+79275551234";
    userModel14.contactEmail = @"denisdbv@mail.ru";
    userModel14.contactVK = @"http://vk.com/denisdbv";
    userModel14.contactFB = @"http://facebook.ru/profile";
    userModel14.contactTwitter = @"http://twitter.com/profile";
    
    TRUserModel *userModel15 = [[TRUserModel alloc] init];
    userModel15.logo = @"15.jpg";
    userModel15.firstName = @"Юлия";
    userModel15.lastName = @"Елупова";
    userModel15.yearsOld = @"28 лет";
    userModel15.city = @"Гонконг";
    userModel15.businessLogo = @"background.jpg";
    userModel15.businessTitle = @"Бассейны в кредит";
    userModel15.businessBeforeTitle = @"Было: 100000 рублей";
    userModel15.businessAfterTitle = @"Стало: 5 000 000 рублей";
    userModel15.contactPhone = @"+79275551234";
    userModel15.contactEmail = @"denisdbv@mail.ru";
    userModel15.contactVK = @"http://vk.com/denisdbv";
    userModel15.contactFB = @"http://facebook.ru/profile";
    userModel15.contactTwitter = @"http://twitter.com/profile";
    
    TRUserModel *userModel16 = [[TRUserModel alloc] init];
    userModel16.logo = @"16.jpg";
    userModel16.firstName = @"Елена";
    userModel16.lastName = @"Глухова";
    userModel16.yearsOld = @"28 лет";
    userModel16.city = @"Гонконг";
    userModel16.businessLogo = @"background.jpg";
    userModel16.businessTitle = @"Бассейны в кредит";
    userModel16.businessBeforeTitle = @"Было: 100000 рублей";
    userModel16.businessAfterTitle = @"Стало: 5 000 000 рублей";
    userModel16.contactPhone = @"+79275551234";
    userModel16.contactEmail = @"denisdbv@mail.ru";
    userModel16.contactVK = @"http://vk.com/denisdbv";
    userModel16.contactFB = @"http://facebook.ru/profile";
    userModel16.contactTwitter = @"http://twitter.com/profile";
    
    TRUserModel *userModel17 = [[TRUserModel alloc] init];
    userModel17.logo = @"17.jpg";
    userModel17.firstName = @"Виталий";
    userModel17.lastName = @"Передереев";
    userModel17.yearsOld = @"28 лет";
    userModel17.city = @"Гонконг";
    userModel17.businessLogo = @"background.jpg";
    userModel17.businessTitle = @"Бассейны в кредит";
    userModel17.businessBeforeTitle = @"Было: 100000 рублей";
    userModel17.businessAfterTitle = @"Стало: 5 000 000 рублей";
    userModel17.contactPhone = @"+79275551234";
    userModel17.contactEmail = @"denisdbv@mail.ru";
    userModel17.contactVK = @"http://vk.com/denisdbv";
    userModel17.contactFB = @"http://facebook.ru/profile";
    userModel17.contactTwitter = @"http://twitter.com/profile";
    
    TRUserModel *userModel18 = [[TRUserModel alloc] init];
    userModel18.logo = @"18.jpg";
    userModel18.firstName = @"Андрей";
    userModel18.lastName = @"Чертков";
    userModel18.yearsOld = @"28 лет";
    userModel18.city = @"Гонконг";
    userModel18.businessLogo = @"background.jpg";
    userModel18.businessTitle = @"Бассейны в кредит";
    userModel18.businessBeforeTitle = @"Было: 100000 рублей";
    userModel18.businessAfterTitle = @"Стало: 5 000 000 рублей";
    userModel18.contactPhone = @"+79275551234";
    userModel18.contactEmail = @"denisdbv@mail.ru";
    userModel18.contactVK = @"http://vk.com/denisdbv";
    userModel18.contactFB = @"http://facebook.ru/profile";
    userModel18.contactTwitter = @"http://twitter.com/profile";
    
    TRUserModel *userModel19 = [[TRUserModel alloc] init];
    userModel19.logo = @"19.jpg";
    userModel19.firstName = @"Кристина";
    userModel19.lastName = @"Бережнева";
    userModel19.yearsOld = @"28 лет";
    userModel19.city = @"Гонконг";
    userModel19.businessLogo = @"background.jpg";
    userModel19.businessTitle = @"Бассейны в кредит";
    userModel19.businessBeforeTitle = @"Было: 100000 рублей";
    userModel19.businessAfterTitle = @"Стало: 5 000 000 рублей";
    userModel19.contactPhone = @"+79275551234";
    userModel19.contactEmail = @"denisdbv@mail.ru";
    userModel19.contactVK = @"http://vk.com/denisdbv";
    userModel19.contactFB = @"http://facebook.ru/profile";
    userModel19.contactTwitter = @"http://twitter.com/profile";
    
    usersObject = [[NSArray alloc] initWithObjects:userModel1, userModel2, userModel3, userModel4, userModel5, userModel6, userModel7,
                   userModel8, userModel9, userModel10, userModel11, userModel12, userModel13, userModel14, userModel15, userModel16,
                   userModel17, userModel18, userModel19, nil];
}

-(void) createMindObjects
{
    TRMindModel *mindModel1 = [[TRMindModel alloc] init];
    mindModel1.mindLogo = @"1b.png";
    mindModel1.mindTitle = @"Бизнес Молодость: Гиперзабывчивость";
    mindModel1.mindAuthor = @"Михаил Дашкиев";
    mindModel1.mindDayCreate = @"01-08-2013";
    mindModel1.mindLevel = MindLevel1;
    mindModel1.mindRating = 10;
    mindModel1.mindURL = @"http://zomgg.ru/reki/base/01/body.html";
    
    TRMindModel *mindModel2 = [[TRMindModel alloc] init];
    mindModel2.mindLogo = @"2b.png";
    mindModel2.mindTitle = @"Как лучше распределять деньги и обязанности между партнерами?";
    mindModel2.mindAuthor = @"Петр Осипов";
    mindModel2.mindDayCreate = @"10-07-2013";
    mindModel2.mindLevel = MindLevel1;
    mindModel2.mindRating = 105;
    mindModel2.mindURL = @"http://zomgg.ru/reki/base/02/body.html";
    
    TRMindModel *mindModel3 = [[TRMindModel alloc] init];
    mindModel3.mindLogo = @"3b.png";
    mindModel3.mindTitle = @"НТКЗЯ – беспрецедентный двигатель бизнес-процессов";
    mindModel3.mindAuthor = @"Михаил Дашкиев";
    mindModel3.mindDayCreate = @"08-07-2013";
    mindModel3.mindLevel = MindLevel1;
    mindModel3.mindRating = 1386;
    mindModel3.mindURL = @"http://zomgg.ru/reki/base/03/body.html";
    
    TRMindModel *mindModel4 = [[TRMindModel alloc] init];
    mindModel4.mindLogo = @"4b.png";
    mindModel4.mindTitle = @"Эффективные продажи. Как отойти от стереотипов и начать продавать";
    mindModel4.mindAuthor = @"Петр Осипов";
    mindModel4.mindDayCreate = @"07-05-2013";
    mindModel4.mindLevel = MindLevel1;
    mindModel4.mindRating = 2587;
    mindModel4.mindURL = @"http://zomgg.ru/reki/base/04/body.html";
    
    TRMindModel *mindModel5 = [[TRMindModel alloc] init];
    mindModel5.mindLogo = @"5b.png";
    mindModel5.mindTitle = @"Все познается в сравнении, или  Чем полезен ЧСМ";
    mindModel5.mindAuthor = @"Михаил Дашкиев";
    mindModel5.mindDayCreate = @"24-06-2013";
    mindModel5.mindLevel = MindLevel1;
    mindModel5.mindRating = 1482;
    mindModel5.mindURL = @"http://zomgg.ru/reki/base/05/body.html";
    
    TRMindModel *mindModel6 = [[TRMindModel alloc] init];
    mindModel6.mindLogo = @"6b.png";
    mindModel6.mindTitle = @"Классификация сотрудников, или Откуда берутся \"Ангелы\"?";
    mindModel6.mindAuthor = @"Петр Осипов";
    mindModel6.mindDayCreate = @"06-06-2013";
    mindModel6.mindLevel = MindLevel1;
    mindModel6.mindRating = 724;
    mindModel6.mindURL = @"http://zomgg.ru/reki/base/06/body.html";
    
    TRMindModel *mindModel7 = [[TRMindModel alloc] init];
    mindModel7.mindLogo = @"7b.png";
    mindModel7.mindTitle = @"Петр Осипов: феномен Ямы, второй уровень";
    mindModel7.mindAuthor = @"Петр Осипов";
    mindModel7.mindDayCreate = @"03-06-2013";
    mindModel7.mindLevel = MindLevel1;
    mindModel7.mindRating = 1482;
    mindModel7.mindURL = @"http://zomgg.ru/reki/base/07/body.html";
    
    TRMindModel *mindModel8 = [[TRMindModel alloc] init];
    mindModel8.mindLogo = @"8b.jpg";
    mindModel8.mindTitle = @"Яма";
    mindModel8.mindAuthor = @"Михаил Дашкиев";
    mindModel8.mindDayCreate = @"22-05-2012";
    mindModel8.mindLevel = MindLevel1;
    mindModel8.mindRating = 704;
    mindModel8.mindURL = @"http://zomgg.ru/reki/base/08/body.html";
    
    TRMindModel *mindModel9 = [[TRMindModel alloc] init];
    mindModel9.mindLogo = @"9b.png";
    mindModel9.mindTitle = @"От идеи к миллионам. Рецепт внедрения инноваций в бизнес";
    mindModel9.mindAuthor = @"Алексей Нониашвили";
    mindModel9.mindDayCreate = @"15-05-2013";
    mindModel9.mindLevel = MindLevel1;
    mindModel9.mindRating = 1261;
    mindModel9.mindURL = @"http://zomgg.ru/reki/base/09/body.html";
    
    mindObjects = [[NSArray alloc] initWithObjects:mindModel1,
                   mindModel2,
                   mindModel3,
                   mindModel4,
                   mindModel5,
                   mindModel6,
                   mindModel7,
                   mindModel8,
                   mindModel9, nil];
}

-(void) createBusinessObjects
{
    TRBusinessModel *businessModel1 = [[TRBusinessModel alloc] init];
    businessModel1.firstName = @"Вадим";
    businessModel1.lastName = @"Бойчук";
    businessModel1.age = @"43";
    businessModel1.city = @"Москва";
    businessModel1.businessLogo = @"1k.jpg";
    businessModel1.businessTitle = @"Прошел школу бизнеса 90-х и решил зарабатывать миллионы на женских удовольствиях";
    businessModel1.shortBusinessTitle = @"«Волшебные» бигуди";
    businessModel1.businessBeforeTitle = @"0 рублей";
    businessModel1.businessAfterTitle = @"500000 рублей";
    businessModel1.businessDate = @"01-01-2013";
    businessModel1.businessURL = @"http://zomgg.ru/reki/cases/01/body.html";
    
    TRBusinessModel *businessModel2 = [[TRBusinessModel alloc] init];
    businessModel2.firstName = @"Марина";
    businessModel2.lastName = @"Уколова";
    businessModel2.age = @"24";
    businessModel2.city = @"Москва";
    businessModel2.businessLogo = @"2k.jpg";
    businessModel2.businessTitle = @"250 000 чистой прибыли в месяц на своей Мечте";
    businessModel2.shortBusinessTitle = @"Школа причесок ArtSchool";
    businessModel2.businessBeforeTitle = @"0 рублей";
    businessModel2.businessAfterTitle = @"250000 рублей";
    businessModel2.businessDate = @"02-01-2013";
    businessModel2.businessURL = @"http://zomgg.ru/reki/cases/02/body.html";
    
    TRBusinessModel *businessModel3 = [[TRBusinessModel alloc] init];
    businessModel3.firstName = @"Оксана";
    businessModel3.lastName = @"Копылова";
    businessModel3.age = @"36";
    businessModel3.city = @"Москва";
    businessModel3.businessLogo = @"3k.jpg";
    businessModel3.businessTitle = @"Пришла создать идеальное «спальное место», но решила сначала изменить мир";
    businessModel3.shortBusinessTitle = @"Оптово-розничная продажа мягкой мебели";
    businessModel3.businessBeforeTitle = @"0 рублей";
    businessModel3.businessAfterTitle = @"400000 рублей";
    businessModel3.businessDate = @"03-01-2013";
    businessModel3.businessURL = @"http://zomgg.ru/reki/cases/03/body.html";
    
    TRBusinessModel *businessModel4 = [[TRBusinessModel alloc] init];
    businessModel4.firstName = @"Анастасия";
    businessModel4.lastName = @"Затевахина";
    businessModel4.age = @"25";
    businessModel4.city = @"Москва";
    businessModel4.businessLogo = @"4k.jpg";
    businessModel4.businessTitle = @"За время Коучинга увеличила прибыль в шесть раз, потом начала с нуля строить второй бизнес и теперь зарабатывает 600 000 чистыми в месяц";
    businessModel4.shortBusinessTitle = @"Продакшен студия";
    businessModel4.businessBeforeTitle = @"0 рублей";
    businessModel4.businessAfterTitle = @"500000 рублей";
    businessModel4.businessDate = @"04-01-2013";
    businessModel4.businessURL = @"http://zomgg.ru/reki/cases/04/body.html";
    
    TRBusinessModel *businessModel5 = [[TRBusinessModel alloc] init];
    businessModel5.firstName = @"Олег";
    businessModel5.lastName = @"Шарпатый";
    businessModel5.age = @"23";
    businessModel5.city = @"Москва";
    businessModel5.businessLogo = @"5k.jpg";
    businessModel5.businessTitle = @"За время Коучинга и «Миллиона за сто» увеличил прибыль в шесть раз, купил Maserati кабриолет и GT-R, организовал путешествие Мастер Группы БМ по Америке";
    businessModel5.shortBusinessTitle = @"Туроператор Shine! Adventures";
    businessModel5.businessBeforeTitle = @"200 000 рублей";
    businessModel5.businessAfterTitle = @"1 300 000 рублей";
    businessModel5.businessDate = @"05-01-2013";
    businessModel5.businessURL = @"http://zomgg.ru/reki/cases/05/body.html";
    
    TRBusinessModel *businessModel6 = [[TRBusinessModel alloc] init];
    businessModel6.firstName = @"Михаил";
    businessModel6.lastName = @"Якимов";
    businessModel6.age = @"30";
    businessModel6.city = @"Москва";
    businessModel6.businessLogo = @"6k.jpg";
    businessModel6.businessTitle = @"Бизнес-планы на заказ, консалтинг и сопровождение по всей России: если ты согласен на меньшее, значит, для бизнеса ты не рожден";
    businessModel6.shortBusinessTitle = @"Первая консалтинговая компания";
    businessModel6.businessBeforeTitle = @"250 000 рублей";
    businessModel6.businessAfterTitle = @"1 000 000 рублей";
    businessModel6.businessDate = @"06-01-2013";
    businessModel6.businessURL = @"http://zomgg.ru/reki/cases/06/body.html";
    
    TRBusinessModel *businessModel7 = [[TRBusinessModel alloc] init];
    businessModel7.firstName = @"Антон";
    businessModel7.lastName = @"Агапов";
    businessModel7.age = @"43";
    businessModel7.city = @"Москва";
    businessModel7.businessLogo = @"7k.jpg";
    businessModel7.businessTitle = @"Много лет занимался промышленным альпинизмом, но потом решил, что хочет украшать города и монетизировать навыки теперь зарабатывает 700 000 рублей в месяц чистыми";
    businessModel7.shortBusinessTitle = @"Наружная реклама";
    businessModel7.businessBeforeTitle = @"150 000 рублей";
    businessModel7.businessAfterTitle = @"700 000 рублей";
    businessModel7.businessDate = @"07-01-2013";
    businessModel7.businessURL = @"http://zomgg.ru/reki/cases/07/body.html";
    
    TRBusinessModel *businessModel8 = [[TRBusinessModel alloc] init];
    businessModel8.firstName = @"Александр";
    businessModel8.lastName = @"Лебедев";
    businessModel8.age = @"26";
    businessModel8.city = @"Москва";
    businessModel8.businessLogo = @"8k.jpg";
    businessModel8.businessTitle = @"Он начинал с купонаторов, а сейчас зарабатывает полмиллиона в месяц, создавая бизнес под ключ";
    businessModel8.shortBusinessTitle = @"Открытие языковых школ под ключ";
    businessModel8.businessBeforeTitle = @"175 000 рублей";
    businessModel8.businessAfterTitle = @"500 000 рублей";
    businessModel8.businessDate = @"08-01-2013";
    businessModel8.businessURL = @"http://zomgg.ru/reki/cases/08/body.html";
    
    TRBusinessModel *businessModel9 = [[TRBusinessModel alloc] init];
    businessModel9.firstName = @"Екатерина";
    businessModel9.lastName = @"Калашникова";
    businessModel9.age = @"20";
    businessModel9.city = @"Москва";
    businessModel9.businessLogo = @"9k.jpg";
    businessModel9.businessTitle = @"Освоила сразу несколько профессий, перевернула свое сознание и к 20 годам стала миллионером";
    businessModel9.shortBusinessTitle = @"Агентство перфоманс-маркетинга UpSell";
    businessModel9.businessBeforeTitle = @"500 000 рублей";
    businessModel9.businessAfterTitle = @"100 000 000 рублей";
    businessModel9.businessDate = @"09-01-2013";
    businessModel9.businessURL = @"http://zomgg.ru/reki/cases/09/body.html";
    
    businessObjects = [[NSArray alloc] initWithObjects:businessModel1,
                       businessModel2,
                       businessModel3,
                       businessModel4,
                       businessModel5,
                       businessModel6,
                       businessModel7,
                       businessModel8,
                       businessModel9, nil];
}

-(void) createMeetingObjects
{
    TRMeetingModel *meetingModel1 = [[TRMeetingModel alloc] init];
    meetingModel1.meetingDay = @"16";
    meetingModel1.meetingMonth = @"Сентября";
    meetingModel1.meetingTitle = @"Встреча с Петей Осиповым. Презентация приложения БМ Реки и обсуждение последующих планов.";
    meetingModel1.meetingGroup = @"Пётр Осипов и AXBX";
    meetingModel1.meetingDescription = @"http://zomgg.ru/reki/cases/09/body.html";
    meetingModel1.meetingCity = @"Москва";
    meetingModel1.meetingTime = @"12:00";
    meetingModel1.meetingContact = usersObject;
    meetingModel1.meetingPhoto = @"9k.jpg";
    meetingModel1.meetingURL = @"http://zomgg.ru/reki/cases/09/body.html";
    
    meetingObjects = [[NSArray alloc] initWithObjects:meetingModel1, nil];
}

@end
