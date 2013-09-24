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


@interface TRFavoritesEditList ()<UISearchBarDelegate>
@property (nonatomic, retain) UISearchBar *searchBar;
@property (nonatomic, retain) UITableView *contactsTableView;
@end

@implementation TRFavoritesEditList
{
    NSArray* favContacts;
    NSArray* otherContacts;
    BOOL searchActive;
    NSString* filterText;
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
    NSLog(@"update data");
    favContacts = [TRContact favorite];
    if ([filterText length] == 0)
        otherContacts = [TRContact notFavorite];
    else
        otherContacts = [TRContact filterNotFavorite:filterText];
}

-(void)createSearchBar
{
    CGRect searchBarFrame = CGRectMake(0, 0, 260, 44.0);
    self.searchBar = [[UISearchBar alloc] initWithFrame:searchBarFrame];
    self.searchBar.delegate = (id)self;
    self.searchBar.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    self.searchBar.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.searchBar.autocorrectionType = UITextAutocorrectionTypeNo;
    self.searchBar.backgroundImage = [UIImage imageNamed:@"searchBarBG.png"];
    self.searchBar.placeholder = NSLocalizedString(@"Поиск", @"");
    self.searchBar.tintColor = [UIColor colorWithRed:(58.0f/255.0f) green:(67.0f/255.0f) blue:(104.0f/255.0f) alpha:1.0f];
    for (UIView *subview in self.searchBar.subviews) {
        if ([subview isKindOfClass:[UITextField class]]) {
            UITextField *searchTextField = (UITextField *) subview;
            searchTextField.textColor = [UIColor colorWithRed:(154.0f/255.0f) green:(162.0f/255.0f) blue:(176.0f/255.0f) alpha:1.0f];
        }
    }
    [self.searchBar setSearchFieldBackgroundImage:[[UIImage imageNamed:@"searchTextBG.png"]
                                                   resizableImageWithCapInsets:UIEdgeInsetsMake(16.0f, 17.0f, 16.0f, 17.0f)]
                                         forState:UIControlStateNormal];
    [self.searchBar setImage:[UIImage imageNamed:@"searchBarIcon.png"]
            forSearchBarIcon:UISearchBarIconSearch
                       state:UIControlStateNormal];
    [self.searchBar sizeToFit];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self updateData];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(menuStateEventOccurred:)
                                                 name:MFSideMenuStateNotificationEvent
                                               object:nil];
    
    [self toFullWidth];
    self.menuContainerViewController.panMode = MFSideMenuPanModeNone;
	
    
    // search bar
    [self createSearchBar];
    [self.view addSubview:self.searchBar];
    
    
    // tableview
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
    
    [self keybStartListen];
}

-(void) viewWillDisappear:(BOOL)animated
{
    [self keybStopListen];
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
        
        [self.searchBar setShowsCancelButton:YES animated:YES];
        [[self.searchBar cancelButton] setEnabled:YES];
        //[self renameSearchButtonToTitle:@"Готово"];
    }
}

-(void) renameSearchButtonToTitle:(NSString*)title
{
    UIButton *btn = [self.searchBar cancelButton];
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
}





#pragma mark UISearchBarDelegate

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    NSLog(@"search text: %@", searchText);
    filterText = [searchText copy];
    [self updateData];
    [self.contactsTableView reloadData];
}

-(BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    NSLog(@"search begin");
    [[self.searchBar cancelButton] setTitle:@"Отмена" forState:UIControlStateNormal];
    searchActive = YES;
    return YES;
}

-(BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar
{
    NSLog(@"search end");
    searchActive = NO;
    return YES;
}

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    NSLog(@"search cancel click");
    
    if (searchActive){
        self.searchBar.text = @"";
        [self.searchBar resignFirstResponder];
        
        [[self.searchBar cancelButton] setTitle:@"Готово" forState:UIControlStateNormal];
        [[self.searchBar cancelButton] setEnabled:YES];
        
        filterText = nil;
        [self updateData];
        [self.contactsTableView reloadData];
    }else{
        self.menuContainerViewController.panMode = MFSideMenuPanModeDefault;
        [self.navigationController popViewControllerAnimated:NO];
    }

}


#pragma mark Keyboard

-(void)keybStartListen
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

-(void)keybStopListen
{
    [[NSNotificationCenter defaultCenter] removeObserver:UIKeyboardWillShowNotification];
    [[NSNotificationCenter defaultCenter] removeObserver:UIKeyboardWillHideNotification];
}

- (void)keyboardWillShow:(NSNotification *)note
{
    NSDictionary *userInfo = note.userInfo;
    NSTimeInterval duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    UIViewAnimationCurve curve = [userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue];
    
    CGRect keyboardFrameEnd = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    keyboardFrameEnd = [self.view convertRect:keyboardFrameEnd fromView:nil];
    
    [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionBeginFromCurrentState | curve animations:^{
        self.view.frame = CGRectMake(0, 0, keyboardFrameEnd.size.width, keyboardFrameEnd.origin.y);
    } completion:nil];
}

- (void)keyboardWillHide:(NSNotification *)note {
    
    NSDictionary *userInfo = note.userInfo;
    NSTimeInterval duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    UIViewAnimationCurve curve = [userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue];
    
    CGRect keyboardFrameEnd = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    keyboardFrameEnd = [self.view convertRect:keyboardFrameEnd fromView:nil];
    
    [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionBeginFromCurrentState | curve animations:^{
        self.view.frame = CGRectMake(0, 0, keyboardFrameEnd.size.width, keyboardFrameEnd.origin.y);
    } completion:nil];
}

@end
