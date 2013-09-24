//
//  TRMyContactListBar.m
//  TheRiverApp
//
//  Created by DenisDbv on 02.09.13.
//  Copyright (c) 2013 axbx. All rights reserved.
//

#import "TRMyContactListBar.h"
#import "TRContactsSearchBarVC.h"
#import "TRSectionHeaderView.h"
#import "TRFavoritesEditList.h"
#import "TRUserProfileController.h"

#import "MFSideMenu.h"
#import "UIView+GestureBlocks.h"
//#import <UITableView-NXEmptyView/UITableView+NXEmptyView.h>
#import <REActivityViewController/REActivityViewController.h>
#import <SSToolkit/SSToolkit.h>
#import <QuartzCore/QuartzCore.h>
#import <SIAlertView/SIAlertView.h>

#import "TRContact.h"
#import "TRTel.h"
#import "TRSocNetwork.h"
#import "UIImageView+AFNetworking.h"

#define HOST_URL @"http://kostum5.ru"

@interface TRMyContactListBar ()
@property (nonatomic, retain) TRContactsSearchBarVC *searchBarController;
@property (nonatomic, retain) UITableView *contactsTableView;
@end

@implementation TRMyContactListBar
{
    NSArray* favContacts;
    NSArray* otherContacts;
}
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
#if TEST_UIAPPEARANCE
    [[SIAlertView appearance] setDefaultButtonImage:[[UIImage imageNamed:@"button-default.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(15,5,14,6)] forState:UIControlStateNormal];
    [[SIAlertView appearance] setDefaultButtonImage:[[UIImage imageNamed:@"button-default.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(15,5,14,6)] forState:UIControlStateHighlighted];
#endif
    _searchBarController = [[TRContactsSearchBarVC alloc] init];
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
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(updateContacts:)
                                                 name:@"ContactsUpdatedNotification"
                                               object:nil];
    NSLog(@"contacts did load");
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:@"ContactsUpdatedNotification"];
}

-(void)updateContacts:(id)notification
{
    favContacts = [TRContact where:@"isStar == true"];
    otherContacts = [TRContact where:@"isStar == false"];
    NSLog(@"update contacts %d", favContacts.count+otherContacts.count);
    [self.contactsTableView reloadData];
}

-(void) viewDidAppear:(BOOL)animated
{
    [UIView beginAnimations:nil context:NULL];
    [self toShortWidth];
    [_searchBarController.searchBar layoutSubviews];
    [UIView commitAnimations];
    
    [_searchBarController.searchBar sizeToFit];
    
    NSLog(@"contacts did appear");
    [self updateContacts:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(section == 0)
        return favContacts.count;
    else
        return otherContacts.count;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if(section == 0)    {
        TRSectionHeaderView * headerView =  [[TRSectionHeaderView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(tableView.bounds), 32.0f)
                                                                             withTitle:@"ИЗБРАННОЕ"
                                                                       withButtonTitle:@"РЕДАКТИРОВАТЬ"
                                                                               byBlock:^{
                                                                                   [self checkoutTableToEditMode];
                                                                               }];
        [headerView setAutoresizingMask:UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth];
        return headerView;
    }
    else
    {
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(tableView.bounds), 10)];
        lineView.backgroundColor = [UIColor lightGrayColor];
        return lineView;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(section == 0)
        return 32.0;
    else
        return 10.0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 59.0f; //44.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    __block UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
        [cell setBackgroundColor:[UIColor clearColor]];
        [cell.textLabel setTextColor:[UIColor whiteColor]];
        [cell.textLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:19]];
        
        [cell.imageView initialiseTapHandler:^(UIGestureRecognizer *sender) {
            UIImageView *touchView = (UIImageView*)sender.view;
            
            [self.menuContainerViewController setMenuState:MFSideMenuStateClosed completion:^{
                //TRUserProfileController *userProfileVC = [[TRUserProfileController alloc] initByUserModel:[[TRUserManager sharedInstance].usersObject objectAtIndex:touchView.tag]];
                //[AppDelegateInstance() changeProfileViewController:userProfileVC];
            }];
            
        } forTaps:1];
    }
    
    cell.imageView.tag = indexPath.row;    
    
    TRContact* contact;
    if (indexPath.section == 0){
        contact = favContacts[indexPath.row];
    }else{
        contact = otherContacts[indexPath.row];
    }

    if (contact.logo != nil){
        __weak UITableViewCell* blockCell = cell;
        NSURL* url = [NSURL URLWithString:[HOST_URL stringByAppendingString:contact.logo]];
        NSURLRequest* request = [NSURLRequest requestWithURL:url];
        [cell.imageView setImageWithURLRequest:request
                              placeholderImage:nil
                                       success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                                           blockCell.imageView.image = image;
                                           [blockCell setNeedsLayout];
                                       }
                                       failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
                                           NSLog(@"cell image error %@", [error localizedDescription]);
                                       }];
        //[cell.imageView setImageWithURL:[NSURL URLWithString:[HOST_URL stringByAppendingString:contact.logo]]];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", contact.firstName, contact.lastName];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    //TRUserModel *userUnit = [[TRUserManager sharedInstance].usersObject objectAtIndex:indexPath.row];
    TRContact* contact;
    if (indexPath.section == 0){
        contact = favContacts[indexPath.row];
    }else{
        contact = otherContacts[indexPath.row];
    }
    
    TRTel* tel = contact.tel.anyObject;
    TRSocNetwork* socNetwork = contact.socNetwork.anyObject;
    
    REActivity *customActivity = [[REActivity alloc] initWithTitle:@"Телефон"
                                                             image:[UIImage imageNamed:@"Phone.png"]
                                                       actionBlock:^(REActivity *activity, REActivityViewController *activityViewController) {
                                                                                                                      
                                                           [activityViewController dismissViewControllerAnimated:YES completion:^{
                                                               NSString *phoneNumber = [@"tel://" stringByAppendingString:
                                                                                        tel.number];
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
                                                                   [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"skype:denisdbv?call"]];
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
                                  @"recipient": tel.number == nil ? @"" : tel.number,
                                };
    
    /*
    REMailActivity *mailActivity = [[REMailActivity alloc] init];
    mailActivity.userInfo = @{
                              @"text": @"Привет! :)",
                              @"recipient":userUnit.contactEmail,
                            };
    */
    
    REVKActivity *vkActivity = [[REVKActivity alloc] initWithTitle:@"ВКонтакте" image:[UIImage imageNamed:@"REActivityViewController.bundle/Icon_VK"] actionBlock:^(REActivity *activity, REActivityViewController *activityViewController) {
        [activityViewController dismissViewControllerAnimated:YES completion:^{
            NSURL *url = [NSURL URLWithString:socNetwork.vkontakte];
            [[UIApplication sharedApplication] openURL:url];
        }];
    }];
    
    REFacebookActivity *facebookActivity = [[REFacebookActivity alloc] initWithTitle:@"Facebook" image:[UIImage imageNamed:@"REActivityViewController.bundle/Icon_Facebook"] actionBlock:^(REActivity *activity, REActivityViewController *activityViewController) {
        [activityViewController dismissViewControllerAnimated:YES completion:^{
            NSURL *url = [NSURL URLWithString:socNetwork.facebook];
            [[UIApplication sharedApplication] openURL:url];
        }];
    }];
    
    RETwitterActivity *twitterActivity = [[RETwitterActivity alloc] initWithTitle:@"Twitter" image:[UIImage imageNamed:@"REActivityViewController.bundle/Icon_Twitter"] actionBlock:^(REActivity *activity, REActivityViewController *activityViewController) {
        [activityViewController dismissViewControllerAnimated:YES completion:^{
            NSURL *url = [NSURL URLWithString:socNetwork.twitter];
            [[UIApplication sharedApplication] openURL:url];
        }];
    }];
    
    NSArray *activities = @[customActivity, customSkypeActivity, messageActivity, /*mailActivity,*/
                            vkActivity, facebookActivity, twitterActivity ];
    REActivityViewController *activityViewController = [[REActivityViewController alloc] initWithViewController:self activities:activities];
    [activityViewController presentFromRootViewController];
    
}

#pragma mark SearchNearContactsDelegate

-(void) searchBarClick:(UISearchBar*)searchBar
{
    [UIView beginAnimations:nil context:NULL];
    [self toFullWidth];
    [_searchBarController.searchBar layoutSubviews];
    [UIView commitAnimations];
    
    //[_searchBarController.searchBar setShowsCancelButton:YES animated:YES];
    
    self.menuContainerViewController.panMode = MFSideMenuPanModeNone;
}

-(void) searchBarCancel:(UISearchBar*)searchBar
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
