//
//  TRLeftRootMenuBar.m
//  TheRiverApp
//
//  Created by DenisDbv on 02.09.13.
//  Copyright (c) 2013 axbx. All rights reserved.
//

#import "TRLeftRootMenuBar.h"
#import "TRRootMenuCell.h"
#import "TRSectionHeaderView.h"
#import "MFSideMenu.h"

#import "TRUserProfileController.h"

@interface TRLeftRootMenuBar ()
@property (nonatomic, retain) UITableView *rootMenuTableView;
@end

@implementation TRLeftRootMenuBar

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _rootMenuTableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0f, 0.0f,
                                                                       320.0, CGRectGetHeight(self.view.bounds))
                                                      style:UITableViewStylePlain];
	_rootMenuTableView.delegate = (id)self;
	_rootMenuTableView.dataSource = (id)self;
	_rootMenuTableView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
	_rootMenuTableView.backgroundColor = [UIColor whiteColor];
    [_rootMenuTableView setSeparatorColor:[UIColor colorWithRed:49.0/255.0
                                                          green:54.0/255.0
                                                           blue:57.0/255.0
                                                          alpha:1.0]];
    [_rootMenuTableView setBackgroundColor:[UIColor colorWithRed:77.0/255.0
                                                           green:79.0/255.0
                                                            blue:80.0/255.0
                                                           alpha:1.0]];
	[self.view addSubview: _rootMenuTableView];
    
    [self.view setBackgroundColor:[UIColor clearColor]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(section == TRRootMenuSectionProfile)
    {
        return 1;
    } else if(section == TRRootMenuSectionFavorite)
    {
        return 4;
    }else if(section == TRRootMenuSectionKnowledge)
    {
        return 3;
    }else if(section == TRRootMenuSectionMy)
    {
        return 2;
    }
    
    return 0;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    TRSectionHeaderView * headerView;
    
    if(section == TRRootMenuSectionProfile)
    {
        headerView =  [[TRSectionHeaderView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(tableView.bounds), 0.0f)];
    } else if(section == TRRootMenuSectionFavorite)
    {
        headerView =  [[TRSectionHeaderView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(tableView.bounds), 32.0)];
        [headerView setTitle:@"ИЗБРАННОЕ"];
    }else if(section == TRRootMenuSectionKnowledge)
    {
        headerView =  [[TRSectionHeaderView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(tableView.bounds), 32.0f)];
        [headerView setTitle:@"ЗНАНИЯ"];
    }else if(section == TRRootMenuSectionMy)
    {
        headerView =  [[TRSectionHeaderView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(tableView.bounds), 32.0f)];
        [headerView setTitle:@"МОЁ"];
    }
    
    [headerView setAutoresizingMask:UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth];
    return headerView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(section == TRRootMenuSectionProfile)
        return 0;
    
    return 32.0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TRRootMenuCell* cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil)
    {
        cell = [[TRRootMenuCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
        [cell setBackgroundColor:[UIColor clearColor]];
        [cell.textLabel setTextColor:[UIColor whiteColor]];
        [cell.textLabel setFont:[UIFont fontWithName:@"Helvetica" size:16]];
        
        cell.badge.fontSize = 13;
        cell.badgeTextColor = [UIColor whiteColor];
    }
    
    switch (indexPath.section) {
        case TRRootMenuSectionProfile:  {
            if( indexPath.row == 0 )   {
                cell.imageView.image = [UIImage imageNamed:@"IamAppleDev2.jpg"];
                cell.textLabel.text = @"Дубов Денис";
            }
            break;
        }
        case TRRootMenuSectionFavorite: {
            switch (indexPath.row) {
                case 0:
                    cell.imageView.image = [UIImage imageNamed:@"news.png"];
                    cell.textLabel.text = @"Лента новостей";
                    cell.badgeString = @"10+";
                    break;
                case 1:
                    cell.imageView.image = [UIImage imageNamed:@"comments.png"];
                    cell.textLabel.text = @"Сообщения";
                    cell.badgeString = @"3";
                    break;
                case 2:
                    cell.imageView.image = [UIImage imageNamed:@"calendar.png"];
                    cell.textLabel.text = @"Мероприятия";
                    break;
                case 3:
                    cell.textLabel.text = @"Поиск участников";
                    break;
            }
            break;
        }
        case TRRootMenuSectionKnowledge: {
            switch (indexPath.row) {
                case 0:
                    cell.textLabel.text = @"Реки";
                    break;
                case 1:
                    cell.textLabel.text = @"Кейсы";
                    cell.badgeString = @"1+";
                    break;
                case 2:
                    cell.imageView.image = [UIImage imageNamed:@"bookmark.png"];
                    cell.textLabel.text = @"База знаний";
                    break;
            }
            break;
        }
        case TRRootMenuSectionMy: {
            switch (indexPath.row) {
                case 0:
                    cell.textLabel.text = @"Мои посты";
                    break;
                case 1:
                    cell.textLabel.text = @"Мои подписки";
                    break;
            }
            break;
        }
            
        default:
            break;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if(indexPath.section == TRRootMenuSectionProfile && indexPath.row == 0) {
        [self.menuContainerViewController setMenuState:MFSideMenuStateClosed completion:^{
            TRUserProfileController *userProfileVC = [[TRUserProfileController alloc] init];
            [AppDelegateInstance() changeCenterViewController:userProfileVC];
        }];
    }
}

@end
