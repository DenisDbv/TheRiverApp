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
#import <SDWebImage/UIImageView+WebCache.h>
#import <UIActivityIndicator-for-SDWebImage/UIImageView+UIActivityIndicatorForSDWebImage.h>
#import "UIImage+Resize.h"

#import "UIView+GestureBlocks.h"
#import "TRUserProfileController.h"
#import "TRMindBaseListVC.h"
#import "TRBusinessBaseListVC.h"
#import "TRMeetingsBaseListVC.h"
#import "TRPartyUsersListVC.h"
#import "TRWebView.h"
#import "TRNewsListVC.h"

#import "LKBadgeView.h"

@interface TRLeftRootMenuBar ()
@property (nonatomic, retain) UITableView *rootMenuTableView;
@property (nonatomic, strong) LKBadgeView* badgeView;
@end

@implementation TRLeftRootMenuBar
@synthesize badgeView;

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
    return 7;
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
        
        //TRUserModel *userModel = [[TRUserManager sharedInstance].usersObject objectAtIndex:0];
        
        
        //Лого пользователя
        //UIImage *image = [UIImage imageNamed: userModel.logo];
        
        NSString *logoURLString = [SERVER_HOSTNAME stringByAppendingString:[TRAuthManager client].iamData.user.logo];
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.frame = CGRectMake(10.0, 20.0, 90.0, 90.0);
        imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        imageView.layer.borderColor = [UIColor clearColor].CGColor;
        imageView.layer.cornerRadius = CGRectGetHeight(imageView.bounds) / 2;
        imageView.clipsToBounds = YES;
        [header addSubview:imageView];
        
        /*if([[SDImageCache sharedImageCache] imageFromDiskCacheForKey:[logoURLString stringByAppendingString:@"_leftLogo"]] == nil) {
            [imageView setImageWithURL:[NSURL URLWithString:logoURLString] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
                UIImage *logoImageTest = [image resizedImageWithContentMode:UIViewContentModeScaleAspectFill bounds:CGSizeMake(90.0, 90.0) interpolationQuality:kCGInterpolationHigh];
                logoImageTest = [logoImageTest croppedImage:CGRectMake(0, 0, 90.0, 90.0)];
                
                [[SDImageCache sharedImageCache] storeImage:logoImageTest forKey:[logoURLString stringByAppendingString:@"_leftLogo"] toDisk:YES];
                
                [imageView setImage:logoImageTest];
            } usingActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        } else  {
            [imageView setImage:[[SDImageCache sharedImageCache] imageFromDiskCacheForKey:[logoURLString stringByAppendingString:@"_leftLogo"]]];
        }*/
        
        if([TRAuthManager client].iamData.user.logo_profile.length > 0)   {
            NSString *logoURLString = [SERVER_HOSTNAME stringByAppendingString:[TRAuthManager client].iamData.user.logo_profile];
            
            UIImage *img = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:[logoURLString stringByAppendingString:@"_leftLogo"]];
            if(img == nil) {
                [imageView setImageWithURL:[NSURL URLWithString:logoURLString] placeholderImage:[UIImage new]
                                 completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
                                     [[SDImageCache sharedImageCache] storeImage:image forKey:logoURLString toDisk:YES];
                                     
                                     /*image = [image resizedImageWithContentMode:UIViewContentModeScaleAspectFill bounds:CGSizeMake(90.0, 90.0) interpolationQuality:kCGInterpolationHigh];
                                     image = [image croppedImage:CGRectMake(0, 0, 90.0, 90.0)];*/
                                     [[SDImageCache sharedImageCache] storeImage:image forKey:[logoURLString stringByAppendingString:@"_leftLogo"] toDisk:YES];
                                     
                                 } usingActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
            } else  {
                [imageView setImage: img];
            }
        } else  {
            [imageView setImage:[UIImage new]];
        }
        
        
        //ФИО пользователя
        UILabel *nameLabel = [[UILabel alloc] init];
        nameLabel.backgroundColor = [UIColor clearColor];
        nameLabel.textColor = [UIColor whiteColor];
        nameLabel.font = [UIFont fontWithName:@"HypatiaSansPro-Bold" size:25];
        nameLabel.numberOfLines = 2;
        //nameLabel.lineBreakMode = NSLineBreakByWordWrapping;
        nameLabel.text = [NSString stringWithFormat:@"%@ %@", [TRAuthManager client].iamData.user.first_name, [TRAuthManager client].iamData.user.last_name];
        [nameLabel sizeToFit];
        [header addSubview:nameLabel];
        
        CGSize size = [nameLabel.text sizeWithFont:nameLabel.font constrainedToSize:CGSizeMake(270.0-117.0-20.0, FLT_MAX) lineBreakMode:nameLabel.lineBreakMode ];
        nameLabel.frame = CGRectMake(imageView.frame.origin.x+imageView.frame.size.width+15, 40, size.width, 70);
        //nameLabel.backgroundColor = [UIColor redColor];
        //NSLog(@"%@", NSStringFromCGSize(size));
        
        
        //Настройки пользователя
        UIView *settingView = [[UIView alloc] initWithFrame:CGRectMake(header.bounds.size.width-40, 0, 40, 40)];
        [settingView initialiseTapHandler:^(UIGestureRecognizer *sender) {
            NSString *urlDirect = [NSString stringWithFormat:@"%@/edit_1/?token=%@", SERVER_HOSTNAME, [TRAuthManager client].iamData.token];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlDirect]];
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
        
        
        //По нажатию на хедер
        [header initialiseTapHandler:^(UIGestureRecognizer *sender) {
            [self.menuContainerViewController setMenuState:MFSideMenuStateClosed completion:^{
                TRUserProfileController *userProfileVC = [[TRUserProfileController alloc] initByUserModel:[TRAuthManager client].iamData.user isIam:YES];
                [AppDelegateInstance() changeProfileViewController:userProfileVC];
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
        {
            cell.textLabel.text = @"Новости";
            
            badgeView = [[LKBadgeView alloc] initWithFrame:CGRectMake(85, 10, 50, 30)];
            badgeView.textColor = [UIColor whiteColor];
            badgeView.badgeColor = [UIColor redColor];
            badgeView.font = [UIFont fontWithName:@"HelveticaNeue" size:14];
            [cell.contentView addSubview:badgeView];
        }
            break;
        case 1:
            //cell.imageView.image = [UIImage imageNamed:@"news.png"];
            cell.textLabel.text = @"Мероприятия";
            //cell.badgeString = @"10+";
            break;
        case 2:
            //cell.imageView.image = [UIImage imageNamed:@"comments.png"];
            cell.textLabel.text = @"Участники";
            //cell.badgeString = @"3";
            break;
        case 3:
            //cell.imageView.image = [UIImage imageNamed:@"comments.png"];
            cell.textLabel.text = @"База знаний";
            //cell.badgeString = @"3";
            break;
        case 4:
            //cell.imageView.image = [UIImage imageNamed:@"comments.png"];
            cell.textLabel.text = @"Бизнесы";
            //cell.badgeString = @"3";
            break;
        case 5:
            //cell.imageView.image = [UIImage imageNamed:@"calendar.png"];
            cell.textLabel.text = @"Предложить идею";
            break;
        case 6:
            cell.textLabel.text = @"Выход";
            //cell.badgeString = @"1+";
            break;
            
        default:
            break;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if(indexPath.row == 7)  {
        
    } else if(indexPath.row == 6)   {
        /*[self.menuContainerViewController setMenuState:MFSideMenuStateClosed completion:^{
            
            TRMindBaseListVC *mindBaseList = [[TRMindBaseListVC alloc] init];
            [AppDelegateInstance() changeCenterViewController:mindBaseList];
            
        }];*/
        [self logout];
    } else if(indexPath.row == 5)   {
        NSLog(@"%@, %@ %@", [TRAuthManager client].iamData.email, [TRAuthManager client].iamData.user.first_name, [TRAuthManager client].iamData.user.last_name);
        [self.menuContainerViewController setMenuState:MFSideMenuStateClosed completion:^{
            
            UVConfig *config = [UVConfig configWithSite:@"axbx.uservoice.com"
                                                 andKey:@"8xnEIOixzm30U9B2U4m5dg"
                                              andSecret:@"6PgTEB830Y6rN1CMqWonDcD9Xhfy9cc2fRwHWlWbk"
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
    } else if(indexPath.row == 4)   {
        [self.menuContainerViewController setMenuState:MFSideMenuStateClosed completion:^{
            
            TRBusinessBaseListVC *businessBaseList = [[TRBusinessBaseListVC alloc] init];
            [AppDelegateInstance() changeCenterViewController:businessBaseList];
            
        }];
    } else if(indexPath.row == 3)   {
        [self.menuContainerViewController setMenuState:MFSideMenuStateClosed completion:^{
            
            TRMindBaseListVC *mindBaseList = [[TRMindBaseListVC alloc] init];
            [AppDelegateInstance() changeCenterViewController:mindBaseList];
            
        }];
    } else if(indexPath.row == 2)   {
        [self.menuContainerViewController setMenuState:MFSideMenuStateClosed completion:^{
            
            TRPartyUsersListVC *partyUserList = [[TRPartyUsersListVC alloc] init];
            [AppDelegateInstance() changeCenterViewController:partyUserList];
            
        }];
    } else if(indexPath.row == 1)   {
        [self.menuContainerViewController setMenuState:MFSideMenuStateClosed completion:^{
            
            TRMeetingsBaseListVC *meetingBaseList = [[TRMeetingsBaseListVC alloc] init];
            [AppDelegateInstance() changeCenterViewController:meetingBaseList];
            
        }];
    } else if(indexPath.row == 0)   {
        [self.menuContainerViewController setMenuState:MFSideMenuStateClosed completion:^{
            
            TRNewsListVC *newsListVC = [[TRNewsListVC alloc] init];
            [AppDelegateInstance() changeCenterViewController:newsListVC];
        }];
    }
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
                              [AppDelegateInstance() logout];
                          }];
    [alertView show];
}

-(void) showBadgeNews:(NSInteger)newsCount
{
    if(newsCount != 0)
        badgeView.text = [NSString stringWithFormat:@"%i", newsCount];
    else
        badgeView.text = @"";
}

@end
