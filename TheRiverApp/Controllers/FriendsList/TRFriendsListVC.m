//
//  TRFriendsListVC.m
//  TheRiverApp
//
//  Created by DenisDbv on 10.09.13.
//  Copyright (c) 2013 axbx. All rights reserved.
//

#import "TRFriendsListVC.h"
#import "UIBarButtonItem+BarButtonItemExtended.h"
#import "TRFriendCell.h"
#import "MFSideMenu.h"
#import "TRUserProfileController.h"

#import <SDWebImage/UIImageView+WebCache.h>
#import <UIActivityIndicator-for-SDWebImage/UIImageView+UIActivityIndicatorForSDWebImage.h>
#import "UIImage+Resize.h"

@interface TRFriendsListVC ()
@property (nonatomic, copy) TRContactsListModel *_contactList;
@end

@implementation TRFriendsListVC
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
    
    _contactList = [TRContactsManager client].lastContactArray;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"TRFriendCell" bundle:nil] forCellReuseIdentifier:@"FriendCell"];
    
    [self addSwipeGestureRecognizer];
    
    UIBarButtonItem *onCancelButton = [UIBarButtonItem barItemWithImage:[UIImage imageNamed:@"toolbar-back-button@2x.png"] target:self action:@selector(onBack)];
    [onCancelButton setBackgroundImage:[UIImage new] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [self.navigationItem setLeftBarButtonItem:onCancelButton animated:YES];
    
    /*[_tableView setSeparatorColor:[UIColor colorWithRed:41.0/255.0
                                                          green:41.0/255.0
                                                           blue:41.0/255.0
                                                          alpha:1.0]];
    [_tableView setBackgroundColor:[UIColor colorWithRed:51.0/255.0
                                                           green:51.0/255.0
                                                            blue:51.0/255.0
                                                           alpha:1.0]];*/
    [_tableView reloadData];
}

-(void) viewWillAppear:(BOOL)animated
{
    self.menuContainerViewController.panMode = MFSideMenuPanModeNone;
}

-(void) viewWillDisappear:(BOOL)animated
{
    self.menuContainerViewController.panMode = MFSideMenuPanModeDefault;
}

-(void) onBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Swipe gesture

- (void)addSwipeGestureRecognizer
{
    UISwipeGestureRecognizer *swipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeRecognized:)];
    [self.view addGestureRecognizer:swipeGestureRecognizer];
}

- (void)swipeRecognized:(UISwipeGestureRecognizer *)gestureRecognizer
{
    if (gestureRecognizer.state == UIGestureRecognizerStateEnded &&
        gestureRecognizer.direction & UISwipeGestureRecognizerDirectionRight) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _contactList.user.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 69.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TRFriendCell* cell = [tableView dequeueReusableCellWithIdentifier:@"FriendCell"];
    if (cell == nil)
    {
        cell = [[TRFriendCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"FriendCell"];
        [cell setBackgroundColor:[UIColor clearColor]];
        [cell.textLabel setTextColor:[UIColor whiteColor]];
        [cell.textLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:19]];
    }
    
    TRUserInfoModel *userUnit = [_contactList.user objectAtIndex:indexPath.row];
    
    NSString *logoURLString = [SERVER_HOSTNAME stringByAppendingString:userUnit.logo];
    cell.friendLogo.image = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:[logoURLString stringByAppendingString:@"_small"]];
    if(cell.friendLogo.image.size.width == 0)
        cell.friendLogo.image = [UIImage imageNamed:@"rightbar_contact_placeholder.png"];
    
    cell.friendName.text = [NSString stringWithFormat:@"%@ %@", userUnit.first_name, userUnit.last_name];
    
    NSMutableArray *business = [[NSMutableArray alloc] init];
    for(TRBusinessScopeModel *str in userUnit.business.industries)
    {
        [business addObject:str.name];
    }
    cell.friendCurrentBusiness.text = [business componentsJoinedByString:@", "];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    TRUserInfoModel *userUnit = [_contactList.user objectAtIndex:indexPath.row];
    
    self.menuContainerViewController.panMode = MFSideMenuPanModeDefault;
    [self.menuContainerViewController setMenuState:MFSideMenuStateClosed completion:^{
        TRUserProfileController *userProfileVC = [[TRUserProfileController alloc] initByUserModel: userUnit isIam:NO];
        [AppDelegateInstance() changeCenterViewController:userProfileVC];
    }];
}

@end
