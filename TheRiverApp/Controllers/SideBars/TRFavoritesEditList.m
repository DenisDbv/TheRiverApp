//
//  TRFavoritesEditList.m
//  TheRiverApp
//
//  Created by DenisDbv on 02.09.13.
//  Copyright (c) 2013 axbx. All rights reserved.
//

#import "TRFavoritesEditList.h"
#import "TRSearchBarVC.h"
#import "TRSectionHeaderView.h"
#import "UISearchBar+cancelButton.h"

#import "MFSideMenu.h"
#import "TRContact.h"
#import "UIImageView+AFNetworking.h"
#import "TRDownloadManager.h"

#define HOST_URL @"http://kostum5.ru"


@interface TRFavoritesEditList ()
@property (nonatomic, retain) TRSearchBarVC *searchBarController;
@property (nonatomic, retain) UITableView *contactsTableView;
@end

@implementation TRFavoritesEditList
{
    NSArray* favContacts;
    NSArray* otherContacts;
    
    //NSInteger inFavotite;
    //NSInteger outFavorite;
    
    UIButton *buttonCopy;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)updateData
{
    favContacts = [TRContact where:@"isStar == true"];
    otherContacts = [TRContact where:@"isStar == false"];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //inFavotite = 1;
    //outFavorite = 25;
    [self updateData];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(menuStateEventOccurred:)
                                                 name:MFSideMenuStateNotificationEvent
                                               object:nil];
    
    [self toFullWidth];
    self.menuContainerViewController.panMode = MFSideMenuPanModeNone;
	
    _searchBarController = [[TRSearchBarVC alloc] init];
    _searchBarController.delegate = (id)self;
    [self.view addSubview:_searchBarController.searchBar];
    [_searchBarController.searchBar sizeToFit];
    
    _contactsTableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0f, 44.0f,
                                                                       320, CGRectGetHeight(self.view.bounds)-44.0)
                                                      style:UITableViewStylePlain];
	_contactsTableView.delegate = (id)self;
	_contactsTableView.dataSource = (id)self;
	_contactsTableView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
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
}

-(void) viewWillDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:MFSideMenuStateNotificationEvent];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)menuStateEventOccurred:(NSNotification *)notification {
    MFSideMenuStateEvent event = [[[notification userInfo] objectForKey:@"eventType"] intValue];
    
    if(event == MFSideMenuStateEventMenuAnimationDidEnd)
    {
        [_contactsTableView setEditing:YES animated:YES];
        
        [_searchBarController.searchBar setShowsCancelButton:YES animated:YES];
        //[self renameSearchButtonToTitle:@"Готово"];
    }
}

-(void) renameSearchButtonToTitle:(NSString*)title
{
    UIButton *btn = [_searchBarController.searchBar cancelButton];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn.titleLabel sizeToFit];
    [btn layoutSubviews];
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
        TRSectionHeaderView * headerView =  [[TRSectionHeaderView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(tableView.bounds), 32.0f)];
        [headerView setTitle:@"ИЗБРАННОЕ"];
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
    return 44.0;
}

#pragma mark Delete or Add to favorite list
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0)
        return UITableViewCellEditingStyleDelete;
    else
        return UITableViewCellEditingStyleInsert;
}

- (void)tableView: (UITableView *)tableView commitEditingStyle: (UITableViewCellEditingStyle)editingStyle
forRowAtIndexPath: (NSIndexPath *)indexPath
{
    NSLog(@"commit");
        
    //[tableView beginUpdates];
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        TRContact* contact = favContacts[indexPath.row];
        contact.isStar = false;
        [contact save];
        [[TRDownloadManager instance] toggleContactStarStatus:contact.id];
        
        //[tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [self updateData];
        [tableView reloadData];
    }
    else if(editingStyle == UITableViewCellEditingStyleInsert)
    {
        TRContact* contact = otherContacts[indexPath.row];
        contact.isStar = true;
        [contact save];
        [[TRDownloadManager instance] toggleContactStarStatus:contact.id];
        
        //[tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [self updateData];
        [tableView reloadData];
    }
    //[tableView endUpdates];
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (indexPath.section == 0){
//        return YES;
//    }
    return NO;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
    
}

//- (NSIndexPath *)tableView:(UITableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath
//{
//    
//}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
        [cell setBackgroundColor:[UIColor clearColor]];
        [cell.textLabel setTextColor:[UIColor whiteColor]];
        [cell.textLabel setFont:[UIFont fontWithName:@"Helvetica" size:16]];
    }
    
    TRContact* contact;
    if (indexPath.section == 0){
        contact = favContacts[indexPath.row];
    }else{
        contact = otherContacts[indexPath.row];
    }
    
    if (contact.logo != nil){
        [cell.imageView setImageWithURL:[NSURL URLWithString:[HOST_URL stringByAppendingString:contact.logo]]];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", contact.firstName, contact.lastName];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark SearchNearContactsDelegate

-(void) onClickBySearchBar:(UISearchBar*)searchBar
{
    [self createButtonInSearchBar];
}

-(void) onCancelSearchBar:(UISearchBar*)searchBar
{
    self.menuContainerViewController.panMode = MFSideMenuPanModeDefault;
    [self.navigationController popViewControllerAnimated:NO];
}

-(void) createButtonInSearchBar
{
    if(buttonCopy != nil)
    {
        [buttonCopy removeFromSuperview];
        buttonCopy = nil;
    }
    
    UIButton *cancelButton = [_searchBarController.searchBar cancelButton];
    cancelButton.hidden = NO;
    
    NSData *archivedData = [NSKeyedArchiver archivedDataWithRootObject: cancelButton];
    buttonCopy = [NSKeyedUnarchiver unarchiveObjectWithData: archivedData];
    [buttonCopy addTarget:self action:@selector(onClickCancel:) forControlEvents:UIControlEventTouchUpInside];
    [buttonCopy setTitle:@"Отмена" forState:UIControlStateNormal];
    
    //cancelButton.hidden = YES;
    [cancelButton.superview addSubview:buttonCopy];
    //[_searchBarController.searchBar addSubview:buttonCopy];
    
    NSLog(@"1) %@", NSStringFromCGRect(buttonCopy.frame));
    NSLog(@"2) %@", NSStringFromCGRect(cancelButton.frame));
}

-(void) onClickCancel:(id)sender
{
    _searchBarController.searchBar.text = @"";
    [_searchBarController removeSearchTable];
    
    UIButton *btn = (UIButton*)sender;
    /*UIButton *cancelButton = [_searchBarController.searchBar cancelButton];
    
    [buttonCopy removeFromSuperview];
    buttonCopy = nil;
    
    cancelButton.hidden = NO;*/
    
    [btn addTarget:self action:@selector(onClickCancel2:) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:@"Готово" forState:UIControlStateNormal];
}

-(void) onClickCancel2:(id)sender
{
    [buttonCopy removeFromSuperview];
    buttonCopy = nil;
    
    UIButton *cancelButton = [_searchBarController.searchBar cancelButton];
    cancelButton.hidden = NO;
    
    self.menuContainerViewController.panMode = MFSideMenuPanModeDefault;
    [self.navigationController popViewControllerAnimated:NO];
}


@end
