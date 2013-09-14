//
//  TRSearchBarVC.m
//  TheRiverApp
//
//  Created by DenisDbv on 02.09.13.
//  Copyright (c) 2013 axbx. All rights reserved.
//

#import "TRSearchBarVC.h"
#import "UISearchBar+CancelBtnShow.h"
#import "TRAppDelegate.h"

@interface TRSearchBarVC ()
@property (nonatomic, strong) UISearchDisplayController *searchDisplayController;
@end

@implementation TRSearchBarVC
{
    UIView *frontBlackView;
    UITableView *searchTableView;
    
    //NSMutableArray *_searchBuffer;
    TRAppDelegate *appDelegate;
}
@synthesize searchDisplayController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self initialize];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

-(void) viewWillAppear:(BOOL)animated
{
    [self.searchBar sizeToFit];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) initialize
{
    //_searchBuffer = [NSMutableArray new];
    appDelegate = (TRAppDelegate *)[[UIApplication sharedApplication] delegate];
    
    self.view.autoresizingMask = (UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth);
    
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
    
    self.searchDisplayController = [[UISearchDisplayController alloc] initWithSearchBar:self.searchBar contentsController:self];
    searchDisplayController.delegate = (id)self;
    searchDisplayController.searchResultsDataSource = (id)self;
    searchDisplayController.searchResultsDelegate = (id)self;
    searchTableView = self.searchDisplayController.searchResultsTableView;
}

-(void) removeSearchTable
{
    [self.searchBar resignFirstResponder];
    
    //[self.searchDisplayController.searchResultsTableView removeFromSuperview];
    
    [self hideFrontBlackView];
}

#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:@"Cell"];
    }
    
    //Player *player = [_searchBuffer objectAtIndex:indexPath.row];
    //cell.textLabel.text = player.lastName;
    
	return cell;
}

/*#pragma mark UISearchDisplayDelegate
 - (void)searchDisplayControllerWillBeginSearch:(UISearchDisplayController *)controller {
 
 [self showFronBlackView];
 
 if([self.delegate respondsToSelector:@selector(onClickBySearchBar:)])
 {
 [self.delegate onClickBySearchBar: self.searchBar];
 }
 }
 
 - (void)searchDisplayControllerWillEndSearch:(UISearchDisplayController *)controller {
 
 [self hideFrontBlackView];
 
 if([self.delegate respondsToSelector:@selector(onCancelSearchBar:)])
 {
 [self.delegate onCancelSearchBar: self.searchBar];
 }
 }*/

#pragma mark -
#pragma mark - UISearchControllerDelegate

- (void)searchDisplayController:(UISearchDisplayController *)controller didShowSearchResultsTableView:(UITableView *)tableView
{
	[((UIViewController*)self.delegate).view addSubview: self.searchDisplayController.searchResultsTableView];
    self.searchDisplayController.searchResultsTableView.frame = frontBlackView.frame; //CGRectMake(0, 0,
                                                                           //self.view.bounds.size.width,
                                                                           //self.view.bounds.size.height-self.searchBar.bounds.size.height);
}

- (void)searchDisplayController:(UISearchDisplayController *)controller didHideSearchResultsTableView:(UITableView *)tableView
{
    [self.searchDisplayController.searchResultsTableView removeFromSuperview];
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString {
	if([searchString isEqualToString:@""] == NO)
    {
        /*[_searchBuffer removeAllObjects];
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.lastName contains[c] %@",searchString];
        _searchBuffer = [[appDelegate.playersArray.players filteredArrayUsingPredicate:predicate] mutableCopy];
        [self.searchDisplayController.searchResultsTableView reloadData];*/
    }
	return NO;
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption {
	NSLog(@"==>%i", searchOption);
	return NO;
}

#pragma mark -
#pragma mark - UISearchBarDelegate

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    
    searchBar.showsScopeBar = YES;
	[searchBar sizeToFit];
    //[searchBar setShowsCancelButton:YES animated:YES];
    
    [self showFronBlackView];
    
    if([self.delegate respondsToSelector:@selector(onClickBySearchBar:)])
    {
        [self.delegate onClickBySearchBar: self.searchBar];
    }
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    
    searchBar.showsScopeBar = NO;
	[searchBar sizeToFit];
    //[searchBar setShowsCancelButton:NO animated:YES];
    
    [self hideFrontBlackView];
    
    if([self.delegate respondsToSelector:@selector(onCancelSearchBar:)])
    {
        [self.delegate onCancelSearchBar: self.searchBar];
    }
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [self.searchBar resignFirstResponder];
}

-(void) showFronBlackView
{
    if(frontBlackView == nil)
    {
        frontBlackView = [[UIView alloc] initWithFrame:CGRectMake(0, self.searchBar.frame.origin.y+self.searchBar.bounds.size.height,
                                                                  self.view.bounds.size.width, self.view.bounds.size.height)];
        frontBlackView.backgroundColor = [UIColor blackColor];
        frontBlackView.alpha = 0.0f;
        
        [((UIViewController*)self.delegate).view addSubview:frontBlackView];
        
        [UIView animateWithDuration:0.3f animations:^{
            frontBlackView.alpha = 0.7f;
        }];
    }
}

-(void) hideFrontBlackView
{
    [UIView animateWithDuration:0.3f animations:^{
        frontBlackView.alpha = 0.0f;
    } completion:^(BOOL finished) {
        [frontBlackView removeFromSuperview];
        frontBlackView = nil;
    }];
}

@end
