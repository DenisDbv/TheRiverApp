//
//  TRUserManager.m
//  TheRiverApp
//
//  Created by DenisDbv on 07.09.13.
//  Copyright (c) 2013 axbx. All rights reserved.
//

#import "TRUserManager.h"
#import "TRUserModel.h"

@interface TRUserManager()

@end

@implementation TRUserManager

@synthesize usersObject;
@synthesize mindObjects;
@synthesize businessObjects;

+ (instancetype)sharedInstance
{
    return [ABMultiton sharedInstanceOfClass:[self class]];
}

-(id) init
{
    [self createsUserObjects];
    
    [self createMindObjects];
    
    [self createBusinessObjects];
    
    return [super init];
}

-(void) createsUserObjects
{
    TRUserModel *userModel1 = [[TRUserModel alloc] init];
    userModel1.logo = @"IamChinaMan.JPG";
    userModel1.firstName = @"Анастасия";
    userModel1.lastName = @"Затевахина";
    userModel1.yearsOld = @"28 лет";
    userModel1.city = @"Гонконг";
    userModel1.businessLogo = @"background.jpg";
    userModel1.businessTitle = @"Бассейны в кредит";
    userModel1.businessBeforeTitle = @"Было: 100000 рублей";
    userModel1.businessAfterTitle = @"Стало: 5 000 000 рублей";
    userModel1.contactPhone = @"+79275551234";
    userModel1.contactEmail = @"mail@mail.ru";
    userModel1.contactFB = @"vk.com/profile";
    userModel1.contactVK = @"facebook.ru/profile";
    userModel1.contactTwitter = @"twitter.com/profile";
    
    usersObject = [[NSArray alloc] initWithObjects:userModel1, nil];
}

-(void) createMindObjects
{
    TRMindModel *mindModel1 = [[TRMindModel alloc] init];
    mindModel1.mindLogo = @"background.jpg";
    mindModel1.mindTitle = @"Бизнес Молодость: Гиперзабывчивость";
    mindModel1.mindAuthor = @"Михаил Дашкиев";
    mindModel1.mindDayCreate = @"01-08-2013";
    mindModel1.mindLevel = MindLevel1;
    mindModel1.mindRating = 10;
    mindModel1.mindURL = @"http://zomgg.ru/reki/base/01/body.html";
    
    TRMindModel *mindModel2 = [[TRMindModel alloc] init];
    mindModel2.mindLogo = @"background.jpg";
    mindModel2.mindTitle = @"Как лучше распределять деньги и обязанности между партнерами?";
    mindModel2.mindAuthor = @"Петр Осипов";
    mindModel2.mindDayCreate = @"10-07-2013";
    mindModel2.mindLevel = MindLevel1;
    mindModel2.mindRating = 105;
    mindModel2.mindURL = @"http://zomgg.ru/reki/base/02/body.html";
    
    TRMindModel *mindModel3 = [[TRMindModel alloc] init];
    mindModel3.mindLogo = @"background.jpg";
    mindModel3.mindTitle = @"НТКЗЯ – беспрецедентный двигатель бизнес-процессов";
    mindModel3.mindAuthor = @"Михаил Дашкиев";
    mindModel3.mindDayCreate = @"08-07-2013";
    mindModel3.mindLevel = MindLevel1;
    mindModel3.mindRating = 1386;
    mindModel3.mindURL = @"http://zomgg.ru/reki/base/03/body.html";
    
    TRMindModel *mindModel4 = [[TRMindModel alloc] init];
    mindModel4.mindLogo = @"background.jpg";
    mindModel4.mindTitle = @"Эффективные продажи. Как отойти от стереотипов и начать продавать";
    mindModel4.mindAuthor = @"Петр Осипов";
    mindModel4.mindDayCreate = @"07-05-2013";
    mindModel4.mindLevel = MindLevel1;
    mindModel4.mindRating = 2587;
    mindModel4.mindURL = @"http://zomgg.ru/reki/base/04/body.html";
    
    TRMindModel *mindModel5 = [[TRMindModel alloc] init];
    mindModel5.mindLogo = @"background.jpg";
    mindModel5.mindTitle = @"Все познается в сравнении, или  Чем полезен ЧСМ";
    mindModel5.mindAuthor = @"Михаил Дашкиев";
    mindModel5.mindDayCreate = @"24-06-2013";
    mindModel5.mindLevel = MindLevel1;
    mindModel5.mindRating = 1482;
    mindModel5.mindURL = @"http://zomgg.ru/reki/base/05/body.html";
    
    TRMindModel *mindModel6 = [[TRMindModel alloc] init];
    mindModel6.mindLogo = @"background.jpg";
    mindModel6.mindTitle = @"Классификация сотрудников, или Откуда берутся \"Ангелы\"?";
    mindModel6.mindAuthor = @"Петр Осипов";
    mindModel6.mindDayCreate = @"06-06-2013";
    mindModel6.mindLevel = MindLevel1;
    mindModel6.mindRating = 724;
    mindModel6.mindURL = @"http://zomgg.ru/reki/base/06/body.html";
    
    TRMindModel *mindModel7 = [[TRMindModel alloc] init];
    mindModel7.mindLogo = @"background.jpg";
    mindModel7.mindTitle = @"Петр Осипов: феномен Ямы, второй уровень";
    mindModel7.mindAuthor = @"Петр Осипов";
    mindModel7.mindDayCreate = @"03-06-2013";
    mindModel7.mindLevel = MindLevel1;
    mindModel7.mindRating = 1482;
    mindModel7.mindURL = @"http://zomgg.ru/reki/base/07/body.html";
    
    TRMindModel *mindModel8 = [[TRMindModel alloc] init];
    mindModel8.mindLogo = @"background.jpg";
    mindModel8.mindTitle = @"Яма";
    mindModel8.mindAuthor = @"Михаил Дашкиев";
    mindModel8.mindDayCreate = @"22-05-2012";
    mindModel8.mindLevel = MindLevel1;
    mindModel8.mindRating = 704;
    mindModel8.mindURL = @"http://zomgg.ru/reki/base/08/body.html";
    
    TRMindModel *mindModel9 = [[TRMindModel alloc] init];
    mindModel9.mindLogo = @"background.jpg";
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
    businessModel1.businessLogo = @"background.jpg";
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
    businessModel2.businessLogo = @"background.jpg";
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
    businessModel3.businessLogo = @"background.jpg";
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
    businessModel4.businessLogo = @"background.jpg";
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
    businessModel5.businessLogo = @"background.jpg";
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
    businessModel6.businessLogo = @"background.jpg";
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
    businessModel7.businessLogo = @"background.jpg";
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
    businessModel8.businessLogo = @"background.jpg";
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
    businessModel9.businessLogo = @"background.jpg";
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

@end
