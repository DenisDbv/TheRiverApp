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

+ (instancetype)sharedInstance
{
    return [ABMultiton sharedInstanceOfClass:[self class]];
}

-(id) init
{
    [self createsUserObjects];
    
    [self createMindObjects];
    
    return [super init];
}

-(void) createsUserObjects
{
    TRUserModel *userModel1 = [[TRUserModel alloc] init];
    userModel1.logo = @"IamChinaMan.JPG";
    userModel1.firstName = @"Денис";
    userModel1.lastName = @"Дубов";
    userModel1.yearsOld = @"28 лет";
    userModel1.city = @"Гонконг";
    userModel1.businessLogo = @"background.jpg";
    userModel1.businessTitle = @"Бассейны в кредит";
    userModel1.businessBeforeTitle = @"Было: 100000 рублей";
    userModel1.businessAfterTitle = @"Стало: 5 000 000 рублей";
    
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

@end
