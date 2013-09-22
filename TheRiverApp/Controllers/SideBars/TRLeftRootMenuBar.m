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

#import <uservoice-iphone-sdk/UserVoice.h>
#import <SSToolkit/SSToolkit.h>
#import <SIAlertView/SIAlertView.h>

#import "UIView+GestureBlocks.h"
#import "TRUserProfileController.h"
#import "TRMindBaseListVC.h"
#import "TRBusinessBaseListVC.h"
#import "TRMeetingsBaseListVC.h"

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
    [_rootMenuTableView setSeparatorColor:[UIColor colorWithRed:41.0/255.0
                                                          green:41.0/255.0
                                                           blue:41.0/255.0
                                                          alpha:1.0]];
    [_rootMenuTableView setBackgroundColor:[UIColor colorWithRed:51.0/255.0
                                                           green:51.0/255.0
                                                            blue:51.0/255.0
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    /*if(section == TRRootMenuSectionProfile)
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
    }*/
    return 6;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    /*TRSectionHeaderView * headerView;
    
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
    return headerView;*/
    
    if(section == 0)
    {
        UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(tableView.bounds), 130.0)];
        header.backgroundColor = [UIColor colorWithRed:51.0/255.0
                                                 green:51.0/255.0
                                                  blue:51.0/255.0
                                                 alpha:1.0];
        
        TRUserModel *userModel = [[TRUserManager sharedInstance].usersObject objectAtIndex:0];
        
        UIImage *image = [UIImage imageNamed: userModel.logo];
        
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        imageView.frame = CGRectMake(10.0, 20.0, 90.0, 90.0);
        imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        //imageView.layer.borderWidth = 1;
        imageView.layer.borderColor = [UIColor clearColor].CGColor;
        imageView.layer.cornerRadius = CGRectGetHeight(imageView.bounds) / 2;
        imageView.clipsToBounds = YES;
        [header addSubview:imageView];
        
        UILabel *nameLabel = [[UILabel alloc] init];
        nameLabel.backgroundColor = [UIColor clearColor];
        nameLabel.textColor = [UIColor whiteColor];
        nameLabel.font = [UIFont fontWithName:@"HypatiaSansPro-Bold" size:25];
        nameLabel.numberOfLines = 2;
        nameLabel.lineBreakMode = NSLineBreakByWordWrapping;
        nameLabel.text = [NSString stringWithFormat:@"%@ %@", userModel.firstName, userModel.lastName];
        [nameLabel sizeToFit];
        [header addSubview:nameLabel];
        
        CGSize size = [nameLabel.text sizeWithFont:nameLabel.font constrainedToSize:CGSizeMake(270.0-117.0-20.0, FLT_MAX) lineBreakMode:nameLabel.lineBreakMode ];
        nameLabel.frame = CGRectMake(imageView.frame.origin.x+imageView.frame.size.width+15, 40, size.width, size.height);
        
        UIView *settingView = [[UIView alloc] initWithFrame:CGRectMake(header.bounds.size.width-40, 0, 40, 40)];
        [settingView initialiseTapHandler:^(UIGestureRecognizer *sender) {
            [self logout];
        } forTaps:1];
        UIImageView *settingsImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cog-gray-icon@2x.png"]];
        settingsImageView.userInteractionEnabled = YES;
        settingsImageView.frame = CGRectMake(0, 0, settingsImageView.frame.size.width/2, settingsImageView.frame.size.height/2);
        settingsImageView.center = CGPointMake(settingView.frame.size.width/2, settingView.frame.size.height/2);
        [settingView addSubview:settingsImageView];
        [header addSubview:settingView];
        
        SSLineView *bottomLine = [[SSLineView alloc] initWithFrame:CGRectMake(0, header.bounds.size.height-1, header.bounds.size.width, 1)];
        [bottomLine setLineColor:[UIColor colorWithRed:41.0/255.0
                                                green:41.0/255.0
                                                 blue:41.0/255.0
                                                alpha:1.0]];
        [header addSubview:bottomLine];
        
        [header initialiseTapHandler:^(UIGestureRecognizer *sender) {
            [self.menuContainerViewController setMenuState:MFSideMenuStateClosed completion:^{
                TRUserProfileController *userProfileVC = [[TRUserProfileController alloc] initByUserModel:[[TRUserManager sharedInstance].usersObject objectAtIndex:0]];
                [AppDelegateInstance() changeProfileViewController:userProfileVC];
                
                [[TRAuthManager client] logout];
            }];
        } forTaps:1];
        
        return header;
    }
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(section == 0)
        return 130;
    
    return 0.0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 59.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TRRootMenuCell* cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil)
    {
        cell = [[TRRootMenuCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
        [cell setBackgroundColor:[UIColor clearColor]];
        [cell.textLabel setTextColor:[UIColor whiteColor]];
        [cell.textLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:19]];
        
        cell.badge.fontSize = 13;
        cell.badgeTextColor = [UIColor whiteColor];
    }
    
    switch (indexPath.row) {
        case 0:
            //cell.imageView.image = [UIImage imageNamed:@"news.png"];
            cell.textLabel.text = @"Новости";
            //cell.badgeString = @"10+";
            break;
        case 1:
            //cell.imageView.image = [UIImage imageNamed:@"comments.png"];
            cell.textLabel.text = @"Сообщения";
            //cell.badgeString = @"3";
            break;
        case 2:
            //cell.imageView.image = [UIImage imageNamed:@"calendar.png"];
            cell.textLabel.text = @"Мероприятия";
            break;
        case 3:
            cell.textLabel.text = @"Кейсы";
            //cell.badgeString = @"1+";
            break;
        case 4:
            //cell.imageView.image = [UIImage imageNamed:@"bookmark.png"];
            cell.textLabel.text = @"База знаний";
            break;
        case 5:
            //cell.imageView.image = [UIImage imageNamed:@"bookmark.png"];
            cell.textLabel.text = @"Оставить отзыв";
            break;
            
        default:
            break;
    }
    /*switch (indexPath.section) {
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
    }*/
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if(indexPath.row == 5)   {
        [self.menuContainerViewController setMenuState:MFSideMenuStateClosed completion:^{
            UVConfig *config = [UVConfig configWithSite:@"brandymint.uservoice.com"
                                                 andKey:@"6P7WTuK36Q8gbXrnjXSug"
                                              andSecret:@"N6YtFh854EPUu7y5rAWNA319UzNSsu3P6ufEfUolnuU"
                                               andEmail:[TRAuthManager client].iamData.email
                                         andDisplayName:[NSString stringWithFormat:@"%@ %@", [TRAuthManager client].iamData.user.first_name, [TRAuthManager client].iamData.user.last_name]
                                                andGUID:[[TRAuthManager client].iamData.user.id stringValue]];
            //config.showForum = NO;
            //config.showPostIdea = NO;
            //config.showKnowledgeBase = NO;
            config.showContactUs = NO;
            //[UserVoice presentUserVoiceNewIdeaFormForParentViewController:self andConfig:config];
            [UserVoice presentUserVoiceInterfaceForParentViewController:self andConfig:config];
        }];
    } else if(indexPath.row == 4)  {
        [self.menuContainerViewController setMenuState:MFSideMenuStateClosed completion:^{
            
            TRMindBaseListVC *mindBaseList = [[TRMindBaseListVC alloc] init];
            [AppDelegateInstance() changeCenterViewController:mindBaseList];
            
        }];
    } else if(indexPath.row == 3)   {
        [self.menuContainerViewController setMenuState:MFSideMenuStateClosed completion:^{
            
            TRBusinessBaseListVC *businessBaseList = [[TRBusinessBaseListVC alloc] init];
            [AppDelegateInstance() changeCenterViewController:businessBaseList];
            
        }];
    } else if(indexPath.row == 2)   {
        [self.menuContainerViewController setMenuState:MFSideMenuStateClosed completion:^{
            
            TRMeetingsBaseListVC *meetingBaseList = [[TRMeetingsBaseListVC alloc] init];
            [AppDelegateInstance() changeCenterViewController:meetingBaseList];
            
        }];
    }
    /*if(indexPath.section == TRRootMenuSectionProfile && indexPath.row == 0) {
        [self.menuContainerViewController setMenuState:MFSideMenuStateClosed completion:^{
            TRUserProfileController *userProfileVC = [[TRUserProfileController alloc] initByUserModel:[[TRUserManager sharedInstance].usersObject objectAtIndex:0]];
            [AppDelegateInstance() changeCenterViewController:userProfileVC];
        }];
    } else if(indexPath.section == TRRootMenuSectionKnowledge && indexPath.row == 2) {
        [self.menuContainerViewController setMenuState:MFSideMenuStateClosed completion:^{
            
            TRMindBaseListVC *mindBaseList = [[TRMindBaseListVC alloc] init];
            [AppDelegateInstance() changeCenterViewController:mindBaseList];
            
        }];
    } else if(indexPath.section == TRRootMenuSectionKnowledge && indexPath.row == 1) {
        [self.menuContainerViewController setMenuState:MFSideMenuStateClosed completion:^{
            
            TRBusinessBaseListVC *businessBaseList = [[TRBusinessBaseListVC alloc] init];
            [AppDelegateInstance() changeCenterViewController:businessBaseList];
            
        }];
    }*/
}

-(void) logout
{
    SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:nil andMessage:@"Выйти?"];
    alertView.messageFont = [UIFont fontWithName:@"HypatiaSansPro-Regular" size:18];
    [alertView addButtonWithTitle:@"НЕТ"
                             type:SIAlertViewButtonTypeCancel
                          handler:^(SIAlertView *alertView) {
                              NSLog(@"Cancel Clicked");
                          }];
    [alertView addButtonWithTitle:@"ДА"
                             type:SIAlertViewButtonTypeDefault
                          handler:^(SIAlertView *alertView) {
                              [AppDelegateInstance() presentLoginViewController];
                          }];
    [alertView show];
}

@end
