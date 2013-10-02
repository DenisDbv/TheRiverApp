//
//  TRMyContactListBar.m
//  TheRiverApp
//
//  Created by DenisDbv on 02.09.13.
//  Copyright (c) 2013 axbx. All rights reserved.
//

#import "TRMyContactListBar.h"
#import "TRSearchBarVC.h"
#import "TRSectionHeaderView.h"
#import "TRFavoritesEditList.h"
#import "TRUserProfileController.h"
#import "TRContactCell.h"

#import "MFSideMenu.h"
#import "UIView+GestureBlocks.h"
//#import <UITableView-NXEmptyView/UITableView+NXEmptyView.h>
#import <REActivityViewController/REActivityViewController.h>
#import <SSToolkit/SSToolkit.h>
#import <QuartzCore/QuartzCore.h>
#import <SIAlertView/SIAlertView.h>

@interface TRMyContactListBar ()
@property (nonatomic, retain) TRContactsListModel *_contactList;
@property (nonatomic, retain) TRSearchBarVC *searchBarController;
@property (nonatomic, retain) UITableView *contactsTableView;
@end

@implementation TRMyContactListBar
@synthesize _contactList;

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

    _searchBarController = [[TRSearchBarVC alloc] init];
    _searchBarController.delegate = (id)self;
    [self.view addSubview:_searchBarController.searchBar];
    [_searchBarController.searchBar sizeToFit];
    
    _contactsTableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0f, 44.0f,
                                                                       320.0, CGRectGetHeight(self.view.bounds)-44.0)
                                                      style:UITableViewStylePlain];
	_contactsTableView.delegate = (id)self;
	_contactsTableView.dataSource = (id)self;
	_contactsTableView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
	_contactsTableView.backgroundColor = [UIColor whiteColor];
    [_contactsTableView setSeparatorColor:[UIColor colorWithRed:41.0/255.0
                                                          green:41.0/255.0
                                                           blue:41.0/255.0
                                                          alpha:1.0]];
    [_contactsTableView setBackgroundColor:[UIColor colorWithRed:51.0/255.0
                                                           green:51.0/255.0
                                                            blue:51.0/255.0
                                                           alpha:1.0]];
    //_contactsTableView.nxEV_emptyView = all;
	[self.view addSubview: _contactsTableView];
    
    [self.view setBackgroundColor:[UIColor clearColor]];
    
    //self.view.backgroundColor = [UIColor whiteColor];
    
    [self refreshContactList];
}

-(void) viewDidAppear:(BOOL)animated
{
    [UIView beginAnimations:nil context:NULL];
    [self toShortWidth];
    [_searchBarController.searchBar layoutSubviews];
    [UIView commitAnimations];
    
    [_searchBarController.searchBar sizeToFit];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void) refreshContactList
{
    [[TRContactsManager client] downloadContactList:^(LRRestyResponse *response, TRContactsListModel *contactList) {
        _contactList = contactList;
        
        [_contactsTableView reloadData];
    } andFailedOperation:nil];
}

#pragma mark UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _contactList.user.count;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    TRSectionHeaderView * headerView =  [[TRSectionHeaderView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(tableView.bounds), 32.0f)
                                                                         withTitle:@"ИЗБРАННОЕ"
                                                                   withButtonTitle:@"РЕДАКТИРОВАТЬ"
                                                                           byBlock:^{
                                                                               [self checkoutTableToEditMode];
                                                                           }];
    [headerView setAutoresizingMask:UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth];
    return headerView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 32.0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 59.0f; //44.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TRContactCell* cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil)
    {
        cell = [[TRContactCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
         
         [cell.imageView initialiseTapHandler:^(UIGestureRecognizer *sender) {
             UIImageView *touchView = (UIImageView*)sender.view;
             [self.menuContainerViewController setMenuState:MFSideMenuStateClosed completion:^{
                 TRUserProfileController *userProfileVC = [[TRUserProfileController alloc] initByUserModel:[_contactList.user objectAtIndex:touchView.tag]];
                 [AppDelegateInstance() changeProfileViewController:userProfileVC];
             }];
         
         } forTaps:1];
    }
    
    cell.imageView.tag = indexPath.row;
    
    TRUserInfoModel *userUnit = [_contactList.user objectAtIndex:indexPath.row];
    [cell reloadWithModel:userUnit];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    TRUserInfoModel *userUnit = [_contactList.user objectAtIndex:indexPath.row];
    
    NSString *phone = @"";
    NSString *skype = @"";
    NSString *fb = @"";
    NSString *vk = @"";
    NSString *email = @"";
    
    if(userUnit.contact_data.phone.count > 0)
        phone = [userUnit.contact_data.phone objectAtIndex:0];
    if(userUnit.contact_data.skype.length > 0)
        phone = userUnit.contact_data.skype;
    if(userUnit.contact_data.fb.length > 0)
        phone = userUnit.contact_data.fb;
    if(userUnit.contact_data.vk.length > 0)
        phone = userUnit.contact_data.vk;
    
    REActivity *customActivity = [[REActivity alloc] initWithTitle:@"Телефон"
                                                             image:[UIImage imageNamed:@"Phone.png"]
                                                       actionBlock:^(REActivity *activity, REActivityViewController *activityViewController) {
                                                                                                                      
                                                           [activityViewController dismissViewControllerAnimated:YES completion:^{
                                                               NSString *phoneNumber = [@"tel://" stringByAppendingString:phone];
                                                               [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneNumber]];
                                                           }];
                                                       }];
    
    REActivity *customSkypeActivity = [[REActivity alloc] initWithTitle:@"Skype"
                                                             image:[UIImage imageNamed:@"skype.png"]
                                                       actionBlock:^(REActivity *activity, REActivityViewController *activityViewController) {
                                                           
                                                           [activityViewController dismissViewControllerAnimated:YES completion:^{
                                                               BOOL installed = [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"skype:"]];
                                                               if(installed)
                                                               {
                                                                   [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"skype:%@?call", skype]]];
                                                               }
                                                               else
                                                               {
                                                                   SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:nil andMessage:@"У Вас не установлено приложение Skype.\n Установить?"];
                                                                   alertView.messageFont = [UIFont fontWithName:@"HypatiaSansPro-Regular" size:18];
                                                                   [alertView addButtonWithTitle:@"НЕТ"
                                                                                            type:SIAlertViewButtonTypeCancel
                                                                                         handler:^(SIAlertView *alertView) {
                                                                                             NSLog(@"Cancel Clicked");
                                                                                         }];
                                                                   [alertView addButtonWithTitle:@"ДА"
                                                                                            type:SIAlertViewButtonTypeDefault
                                                                                         handler:^(SIAlertView *alertView) {
                                                                                             [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://itunes.com/apps/skype/skype"]];
                                                                                         }];
                                                                   [alertView show];
                                                               }
                                                           }];
                                                       }];
    
    REMessageActivity *messageActivity = [[REMessageActivity alloc] init];
    messageActivity.userInfo = @{
                                  @"text": @"Привет! :)",
                                  @"recipient":phone,
                                };
    
    REMailActivity *mailActivity = [[REMailActivity alloc] init];
    mailActivity.userInfo = @{
                              @"text": @"Привет! :)",
                              @"recipient":email,
                            };
    
    REVKActivity *vkActivity = [[REVKActivity alloc] initWithTitle:@"ВКонтакте" image:[UIImage imageNamed:@"REActivityViewController.bundle/Icon_VK"] actionBlock:^(REActivity *activity, REActivityViewController *activityViewController) {
        [activityViewController dismissViewControllerAnimated:YES completion:^{
            NSURL *url = [NSURL URLWithString:vk];
            [[UIApplication sharedApplication] openURL:url];
        }];
    }];
    
    REFacebookActivity *facebookActivity = [[REFacebookActivity alloc] initWithTitle:@"Facebook" image:[UIImage imageNamed:@"REActivityViewController.bundle/Icon_Facebook"] actionBlock:^(REActivity *activity, REActivityViewController *activityViewController) {
        [activityViewController dismissViewControllerAnimated:YES completion:^{
            NSURL *url = [NSURL URLWithString:fb];
            [[UIApplication sharedApplication] openURL:url];
        }];
    }];
    
    NSArray *activities = @[customActivity, customSkypeActivity, messageActivity, mailActivity,
                            vkActivity, facebookActivity];
    REActivityViewController *activityViewController = [[REActivityViewController alloc] initWithViewController:self activities:activities];
    [activityViewController presentFromRootViewController];
    
}

#pragma mark SearchNearContactsDelegate

-(void) onClickBySearchBar:(UISearchBar*)searchBar
{
    [UIView beginAnimations:nil context:NULL];
    [self toFullWidth];
    [_searchBarController.searchBar layoutSubviews];
    [UIView commitAnimations];
    
    //[_searchBarController.searchBar setShowsCancelButton:YES animated:YES];
    
    self.menuContainerViewController.panMode = MFSideMenuPanModeNone;
}

-(void) onCancelSearchBar:(UISearchBar*)searchBar
{
    [_searchBarController.searchBar resignFirstResponder];
    
    [UIView beginAnimations:nil context:NULL];
    [self toShortWidth];
    [_searchBarController.searchBar layoutSubviews];
    [UIView commitAnimations];
    
    //[_searchBarController.searchBar setShowsCancelButton:NO animated:YES];
    
    self.menuContainerViewController.panMode = MFSideMenuPanModeDefault;
}

#pragma mark Click on edit in header section

-(void) checkoutTableToEditMode
{
    //!!! Заплатка. При переходе из окна выбора избранных, текущий searchBar остался в тех же размерах что и
    // до перехода, поэтому после трансформации ширины экрана с большего на меньший появляется пробел справа.
    // Увеличим searchBar до 320 и в viewDidAppear будем его уменьшать пропорционально изменению ширины.
    CGRect rect = _searchBarController.searchBar.frame;
    rect.size.width = 320.0;
    _searchBarController.searchBar.frame = rect;
    
    [self.navigationController pushViewController:[[TRFavoritesEditList alloc] init] animated:NO];
}

@end
