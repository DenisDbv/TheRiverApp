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
#import "WDActivityIndicator.h"
#import <RNGridMenu/RNGridMenu.h>

@interface TRMyContactListBar ()
@property (nonatomic, copy) TRContactsListModel *_contactList;
@property (nonatomic, retain) TRSearchBarVC *searchBarController;
@property (nonatomic, retain) UITableView *contactsTableView;
@property (nonatomic, retain) UIActivityIndicatorView *activityIndicator;
@property (nonatomic, retain) UIActivityIndicatorView *activityIndicatorInHeader;
@end

@implementation TRMyContactListBar
{
    TRSectionHeaderView * headerView;
    NSIndexPath *lastSelectedIndex;
    
    NSTimer *refreshListTimer;
}
@synthesize _contactList;
@synthesize activityIndicator, activityIndicatorInHeader;

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
    
    NSInteger yOffset = 0;
    
    if(IS_OS_7_OR_LATER)
        yOffset = 15;
    
    UIView *substrateView = [[UIView alloc] initWithFrame:CGRectMake(0, yOffset, 320.0, 70)];
    substrateView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:substrateView];
    
    _searchBarController = [[TRSearchBarVC alloc] init];
    _searchBarController.delegate = (id)self;
    _searchBarController.searchBar.frame = CGRectOffset(_searchBarController.searchBar.frame, 0, yOffset + (substrateView.frame.size.height-_searchBarController.searchBar.frame.size.height)/2);
    [_searchBarController.searchBar sizeToFit];
    [self.view addSubview:_searchBarController.searchBar];
    
    _contactsTableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0f, 70.0f+yOffset,
                                                                       320.0, CGRectGetHeight(self.view.bounds)-(70.0+yOffset))
                                                      style:UITableViewStylePlain];
	_contactsTableView.delegate = (id)self;
	_contactsTableView.dataSource = (id)self;
	_contactsTableView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    //_contactsTableView.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleHeight;
	_contactsTableView.backgroundColor = [UIColor whiteColor];
    [_contactsTableView setSeparatorColor: [UIColor colorWithRed:204.0/255.0
                                                           green:204.0/255.0
                                                            blue:204.0/255.0
                                                           alpha:1.0]];
    if ([_contactsTableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [_contactsTableView setSeparatorInset:UIEdgeInsetsZero];
    }
    
    /*[_contactsTableView setBackgroundColor:[UIColor colorWithRed:51.0/255.0
     green:51.0/255.0
     blue:51.0/255.0
     alpha:1.0]];*/
    //_contactsTableView.nxEV_emptyView = all;
	[self.view addSubview: _contactsTableView];
    
    [self.view setBackgroundColor:[UIColor clearColor]];
    
    //self.view.backgroundColor = [UIColor whiteColor];
    
    [self refreshContactListWithCenterIndicator:YES];
    
    [self createTimer];
}

-(void) createTimer
{
    refreshListTimer = [NSTimer scheduledTimerWithTimeInterval:60.0 target:self selector:@selector(refreshByTableHeader) userInfo:nil repeats:YES];
}

-(void) removeTimer
{
    [refreshListTimer invalidate];
    refreshListTimer = nil;
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

-(void) refreshByTableHeader
{
    NSLog(@"Refresh list by timer");
    [self refreshContactListWithCenterIndicator:NO];
}

-(void) refreshContactListWithCenterIndicator:(BOOL)isCenter
{
    if(activityIndicator == nil && isCenter == YES)    {
        activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [activityIndicator setCenter:CGPointMake(270.0/2, (_contactsTableView.bounds.size.height)/2)];
        [_contactsTableView addSubview:activityIndicator];
        [activityIndicator startAnimating];
    } else  {
        [activityIndicatorInHeader startAnimating];
    }
    
    [[TRContactsManager client] downloadContactList:^(LRRestyResponse *response, TRContactsListModel *contactList) {
        
        if(activityIndicator != nil)    {
            [activityIndicator stopAnimating];
            [activityIndicator removeFromSuperview];
            activityIndicator = nil;
        } else  {
            [activityIndicatorInHeader stopAnimating];
        }
        
        _contactList = contactList;
        
        [_contactsTableView reloadData];
        
    } andFailedOperation:^(LRRestyResponse *response) {
        [activityIndicator stopAnimating];
        [activityIndicator removeFromSuperview];
        activityIndicator = nil;
    }];
}

#pragma mark UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _contactList.user.count;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    headerView =  [[TRSectionHeaderView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(tableView.bounds), 25.0f)
                                                                         withTitle:@"КОНТАКТЫ"
                                                                   withButtonTitle:@""//РЕДАКТИРОВАТЬ
                                                                           byBlock:^{
                                                                               //[self checkoutTableToEditMode];
                                                                           }];
    [headerView setAutoresizingMask:UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth];
    
    activityIndicatorInHeader = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(10, 5, 10, 10)];
    activityIndicatorInHeader.color = [UIColor redColor];
    //[headerView addSubview:activityIndicatorInHeader];
    
    return headerView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 25.0;
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
                 TRUserProfileController *userProfileVC = [[TRUserProfileController alloc] initByUserModel:[_contactList.user objectAtIndex:touchView.tag] isIam:NO];
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
    
    lastSelectedIndex = indexPath;
    
    [self onCommunicateClick];
    
    /*TRUserInfoModel *userUnit = [_contactList.user objectAtIndex:indexPath.row];
    
    NSString *phone = @"";
    NSString *skype = @"";
    NSString *fb = @"";
    NSString *vk = @"";
    NSString *email = @"";
    
    if(userUnit.email.length > 0)
        email = userUnit.email;
    if(userUnit.contact_data.phone.count > 0)
        phone = [userUnit.contact_data.phone objectAtIndex:0];
    if(userUnit.contact_data.skype.length > 0)
        skype = userUnit.contact_data.skype;
    if(userUnit.contact_data.fb.length > 0)
        fb = userUnit.contact_data.fb;
    if(userUnit.contact_data.vk.length > 0)
        vk = userUnit.contact_data.vk;
    
    REActivity *customActivity = [[REActivity alloc] initWithTitle:@"Телефон"
                                                             image:[UIImage imageNamed:@"Phone.png"]
                                                       actionBlock:^(REActivity *activity, REActivityViewController *activityViewController) {
                                                                                                                      
                                                           [activityViewController dismissViewControllerAnimated:YES completion:^{
                                                               [[TRBindingManager sharedInstance] callBinding:userUnit];
                                                           }];
                                                       }];
    
    REActivity *customSkypeActivity = [[REActivity alloc] initWithTitle:@"Skype"
                                                             image:[UIImage imageNamed:@"skype.png"]
                                                       actionBlock:^(REActivity *activity, REActivityViewController *activityViewController) {
                                                           
                                                           [activityViewController dismissViewControllerAnimated:YES completion:^{
                                                               [[TRBindingManager sharedInstance] skypeBinding:userUnit];
                                                           }];
                                                       }];
    
    REActivity *messageActivity = [[REActivity alloc] initWithTitle:@"SMS"
                                                           image:[UIImage imageNamed:@"REActivityViewController.bundle/Icon_Message"]
                                                     actionBlock:^(REActivity *activity, REActivityViewController *activityViewController) {
                                                         [activityViewController dismissViewControllerAnimated:YES completion:^{
                                                             [[TRBindingManager sharedInstance] smsBinding:userUnit];
                                                         }];
                                                     }];
    
    REActivity *mailActivity = [[REActivity alloc] initWithTitle:@"Email"
                                                              image:[UIImage imageNamed:@"REActivityViewController.bundle/Icon_Mail"]
                                                        actionBlock:^(REActivity *activity, REActivityViewController *activityViewController) {
                                                            [activityViewController dismissViewControllerAnimated:YES completion:^{
                                                                [[TRBindingManager sharedInstance] emailBinding:userUnit];
                                                            }];
                                                        }];
    
    REVKActivity *vkActivity = [[REVKActivity alloc] initWithTitle:@"ВКонтакте" image:[UIImage imageNamed:@"REActivityViewController.bundle/Icon_VK"] actionBlock:^(REActivity *activity, REActivityViewController *activityViewController) {
        [activityViewController dismissViewControllerAnimated:YES completion:^{
            [[TRBindingManager sharedInstance] vkBinding:userUnit];
        }];
    }];
    
    REFacebookActivity *facebookActivity = [[REFacebookActivity alloc] initWithTitle:@"Facebook" image:[UIImage imageNamed:@"REActivityViewController.bundle/Icon_Facebook"] actionBlock:^(REActivity *activity, REActivityViewController *activityViewController) {
        [activityViewController dismissViewControllerAnimated:YES completion:^{
            [[TRBindingManager sharedInstance] fbBinding:userUnit];
        }];
    }];
    
    NSArray *activities = @[customActivity, customSkypeActivity, messageActivity, mailActivity,
                            vkActivity, facebookActivity];
    REActivityViewController *activityViewController = [[REActivityViewController alloc] initWithViewController:self activities:activities];
    [activityViewController presentFromRootViewController];*/
    
}

-(void) onCommunicateClick
{
    [self showGrid];
}

- (void)showGrid {
    NSInteger numberOfOptions = 6;
    NSMutableArray *itemsArray = [[NSMutableArray alloc] init];
    TRUserInfoModel *userInfo = [_contactList.user objectAtIndex:lastSelectedIndex.row];
    TRContactDataModel *contactData = userInfo.contact_data;
    
    if(contactData.phone.count > 0)
        [itemsArray addObject: [[RNGridMenuItem alloc] initWithImage:[UIImage imageNamed:@"Phone.png"] title:@"Телефон"]];
    else
        [itemsArray addObject:[[RNGridMenuItem alloc] initWithImage:[UIImage imageNamed:@"phone_black.png"] title:@"Телефон" disable:YES]];

    if(contactData.skype.length > 0)
        [itemsArray addObject:[[RNGridMenuItem alloc] initWithImage:[UIImage imageNamed:@"skype.png"] title:@"Skype"]];
    else
        [itemsArray addObject:[[RNGridMenuItem alloc] initWithImage:[UIImage imageNamed:@"skype_black.png"] title:@"Skype" disable:YES]];
    
    if(contactData.phone.count > 0)
        [itemsArray addObject: [[RNGridMenuItem alloc] initWithImage:[UIImage imageNamed:@"REActivityViewController.bundle/Icon_Message"] title:@"SMS"]];
    else
        [itemsArray addObject: [[RNGridMenuItem alloc] initWithImage:[UIImage imageNamed:@"message_black.png"] title:@"SMS" disable:YES]];
    
    if(userInfo.email.length > 0)
        [itemsArray addObject:[[RNGridMenuItem alloc] initWithImage:[UIImage imageNamed:@"REActivityViewController.bundle/Icon_Mail"] title:@"Email"]];
    else
        [itemsArray addObject:[[RNGridMenuItem alloc] initWithImage:[UIImage imageNamed:@"mail_black.png"] title:@"Email" disable:YES]];
    
    if(contactData.vk.length > 0)
        [itemsArray addObject:[[RNGridMenuItem alloc] initWithImage:[UIImage imageNamed:@"REActivityViewController.bundle/Icon_VK"] title:@"Vkontakte"]];
    else
        [itemsArray addObject:[[RNGridMenuItem alloc] initWithImage:[UIImage imageNamed:@"vk_black.png"] title:@"Vkontakte" disable:YES]];
    
    if(contactData.fb.length > 0)
        [itemsArray addObject:[[RNGridMenuItem alloc] initWithImage:[UIImage imageNamed:@"REActivityViewController.bundle/Icon_Facebook"] title:@"Facebook"]];
    else
        [itemsArray addObject:[[RNGridMenuItem alloc] initWithImage:[UIImage imageNamed:@"facebook_black.png"] title:@"Facebook" disable:YES]];
    
    /*NSArray *items = @[
                       [[RNGridMenuItem alloc] initWithImage:[UIImage imageNamed:@"Phone.png"] title:@"Телефон"],
                       [[RNGridMenuItem alloc] initWithImage:[UIImage imageNamed:@"skype.png"] title:@"Skype"],
                       [[RNGridMenuItem alloc] initWithImage:[UIImage imageNamed:@"REActivityViewController.bundle/Icon_Message"] title:@"SMS"],
                       [[RNGridMenuItem alloc] initWithImage:[UIImage imageNamed:@"REActivityViewController.bundle/Icon_Mail"] title:@"Email"],
                       [[RNGridMenuItem alloc] initWithImage:[UIImage imageNamed:@"REActivityViewController.bundle/Icon_VK"] title:@"Vkontakte"],
                       [[RNGridMenuItem alloc] initWithImage:[UIImage imageNamed:@"REActivityViewController.bundle/Icon_Facebook"] title:@"Facebook"]
                       ];
    */
    RNGridMenu *av = [[RNGridMenu alloc] initWithItems:[itemsArray subarrayWithRange:NSMakeRange(0, numberOfOptions)]];
    av.delegate = self;
    av.itemFont = [UIFont fontWithName:@"HelveticaNeue-Bold" size:13];
    UIViewController *rootViewController = [UIApplication sharedApplication].delegate.window.rootViewController;
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
    
    [av showInViewController:rootViewController center:CGPointMake(screenWidth/2.0f, screenHeight/2.0f)];
}

#pragma mark - RNGridMenuDelegate

- (void)gridMenu:(RNGridMenu *)gridMenu willDismissWithSelectedItem:(RNGridMenuItem *)item atIndex:(NSInteger)itemIndex {
    switch (itemIndex) {
        case 0:
            [[TRBindingManager sharedInstance] callBinding:[_contactList.user objectAtIndex:lastSelectedIndex.row]];
            break;
        case 1:
            [[TRBindingManager sharedInstance] skypeBinding:[_contactList.user objectAtIndex:lastSelectedIndex.row]];
            break;
        case 2:
            [[TRBindingManager sharedInstance] smsBinding:[_contactList.user objectAtIndex:lastSelectedIndex.row]];
            break;
        case 3:
            [[TRBindingManager sharedInstance] emailBinding:[_contactList.user objectAtIndex:lastSelectedIndex.row]];
            break;
        case 4:
            [[TRBindingManager sharedInstance] vkBinding:[_contactList.user objectAtIndex:lastSelectedIndex.row]];
            break;
        case 5:
            [[TRBindingManager sharedInstance] fbBinding:[_contactList.user objectAtIndex:lastSelectedIndex.row]];
            break;
        default:
            break;
    }
}

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    [controller dismissViewControllerAnimated:YES completion:nil];
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

-(void) clickOnItemInSearchVC:(TRUserInfoModel*)userInfo
{
    [_searchBarController.searchBar resignFirstResponder];
    
    [UIView animateWithDuration:0 animations:^{
        [self toShortWidth];
        [_searchBarController.searchBar layoutSubviews];
    } completion:^(BOOL finished) {
        self.menuContainerViewController.panMode = MFSideMenuPanModeDefault;
        
        [self.menuContainerViewController setMenuState:MFSideMenuStateClosed completion:^{
            TRUserProfileController *userProfileVC = [[TRUserProfileController alloc] initByUserModel:userInfo isIam:NO];
            [AppDelegateInstance() changeProfileViewController:userProfileVC];
        }];
    }];
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
