//
//  TRPartyUsersFilter.m
//  TheRiverApp
//
//  Created by DenisDbv on 24.09.13.
//  Copyright (c) 2013 axbx. All rights reserved.
//

#import "TRPartyUsersFilter.h"
#import <NVUIGradientButton/NVUIGradientButton.h>
#import <SSToolkit/SSToolkit.h>

#import "TRPartySearchBar.h"
#import "TRPartyUsersListVC.h"

#define HIDE_TIME   0.3
#define SHOW_TIME   0.1

@interface TRPartyUsersFilter()
@property (nonatomic, retain) NVUIGradientButton *levelButton;
@property (nonatomic, retain) NVUIGradientButton *categoryButton;
@property (nonatomic, retain) UIView *headButtonsView;

@property (nonatomic, retain) NVUIGradientButton *cancelButton;
@property (nonatomic, retain) NVUIGradientButton *successButton;
@property (nonatomic, retain) UIView *subHeadButtonsView;

@property (nonatomic, retain) UITableView *citiesTableView;
@property (nonatomic, retain) UITableView *industriesTableView;

@property (nonatomic, copy) NSMutableArray *_citiesList;
@property (nonatomic, copy) NSMutableArray *_industryList;
@property (nonatomic, copy) NSArray *_visibleCitiesList;
@property (nonatomic, copy) NSArray *_visibleIndustryList;

@property (nonatomic, retain) TRPartySearchBar *searchBar;
@end

@implementation TRPartyUsersFilter
{
    TRPartyUsersListVC *rootController;
    
    NSIndexPath *lastCitySelectIndexPath;
    NSIndexPath *lastIndustrySelectIndexPath;
    
    UIImageView *imgLeftButton;
    UIImageView *imgRightButton;
    
    CGRect keyboardFrame;
}

@synthesize levelButton, categoryButton, cancelButton, successButton;
@synthesize headButtonsView, subHeadButtonsView;
@synthesize citiesTableView, industriesTableView;
@synthesize _citiesList, _industryList, _visibleCitiesList, _visibleIndustryList;
@synthesize searchBar;

- (id)initWithFrame:(CGRect)frame byRootTarget:(id)target
{
    self = [super initWithFrame:frame];
    if (self) {
        
        rootController = target;
        
        lastCitySelectIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        lastIndustrySelectIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        
        [self createSubHeadButtons];
        [self createHeadButtons];
        
        _citiesList = [[NSMutableArray alloc] initWithArray:[TRSearchPUManager client].cityList copyItems:YES];
        _industryList = [[NSMutableArray alloc] initWithArray:[TRSearchPUManager client].industryList copyItems:YES];
        [_citiesList insertObject:@"Все города" atIndex:0];
        [_industryList insertObject:@"Все отрасли" atIndex:0];
        
        _visibleCitiesList = [[NSArray alloc] initWithArray:_citiesList copyItems:YES];
        _visibleIndustryList = [[NSArray alloc] initWithArray:_industryList copyItems:YES];
    }
    return self;
}

/*- (void) keyboardShown:(NSNotification *)note{
    
    [[[note userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] getValue:&keyboardFrame];
    
    if(citiesTableView != nil)  {
        CGRect tableViewFrame = citiesTableView.frame;
        tableViewFrame.size.height -= keyboardFrame.size.height;
        [citiesTableView setFrame:tableViewFrame];
    }
    else    {
        CGRect tableViewFrame = industriesTableView.frame;
        tableViewFrame.size.height -= keyboardFrame.size.height;
        [industriesTableView setFrame:tableViewFrame];
    }
}

- (void) keyboardHidden:(NSNotification *)note{
    
    if(citiesTableView != nil)  {
        CGRect tableViewFrame = citiesTableView.frame;
        tableViewFrame.size.height += keyboardFrame.size.height;
        [citiesTableView setFrame:tableViewFrame];
    }
    else    {
        CGRect tableViewFrame = industriesTableView.frame;
        tableViewFrame.size.height += keyboardFrame.size.height;
        [industriesTableView setFrame:tableViewFrame];
    }
}*/

-(void) onCityButtonClick:(NVUIGradientButton*)sender
{
    [self hideRootContent];
    [self showCitiesTableView];
}

-(void) onIndustrialButtonClick:(NVUIGradientButton*)sender
{
    [self hideRootContent];
    [self showIndustryTableView];
}

-(void) hideRootContent
{
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShown:) name:UIKeyboardDidShowNotification object:nil];
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHidden:) name:UIKeyboardWillHideNotification object:nil];
    
    [UIView animateWithDuration:HIDE_TIME animations:^{
        headButtonsView.alpha = 0;
        subHeadButtonsView.alpha = 1;
        rootController.tableView.contentOffset = CGPointMake(0, -rootController.tableView.frame.size.height);
    }];
}

-(void) showRootContent
{
    //[[NSNotificationCenter defaultCenter] removeObserver:UIKeyboardDidShowNotification];
    //[[NSNotificationCenter defaultCenter] removeObserver:UIKeyboardWillHideNotification];
    
    [UIView animateWithDuration:SHOW_TIME animations:^{
        headButtonsView.alpha = 1;
        subHeadButtonsView.alpha = 0;
        rootController.tableView.contentOffset = CGPointMake(0, -self.bounds.size.height);
    }];
}

-(void) onCancelButtonClick:(NVUIGradientButton*)sender
{
    [self showRootContent];
    
    if(citiesTableView != nil)  {
       [self hideCitiesTableView];
    }
    else    {
        [self hideIndustryTableView];
    }
}

/*-(void) onSuccessButtonClick:(NVUIGradientButton*)sender
{
    [self showRootContent];
    
    if(citiesTableView != nil)
        [self hideCitiesTableView];
    else
        [self hideIndustryTableView];
    
    
    NSString *cityName;
    NSString *industryName;
    
    if(lastCitySelectIndexPath.row >= 1)
        cityName = [_citiesList objectAtIndex:lastCitySelectIndexPath.row];
    else
        cityName = @"";
    
    if(lastIndustrySelectIndexPath.row >= 1)
        industryName = [_industryList objectAtIndex:lastIndustrySelectIndexPath.row];
    else
        industryName = @"";
    
    [rootController refreshUserListByCity: cityName andIndustry: industryName];
}*/

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:224.0/255.0 green:224.0/255.0 blue:224.0/255.0 alpha:1.0].CGColor);
    
    // Draw them with a 2.0 stroke width so they are a bit more visible.
    CGContextSetLineWidth(context, 2.0);
    
    CGContextMoveToPoint(context, 0, rect.size.height); //start at this point
    
    CGContextAddLineToPoint(context, rect.size.width, rect.size.height); //draw to this point
    
    // and now draw the Path!
    CGContextStrokePath(context);
}

-(void) createHeadButtons
{
    headButtonsView = [[UIView alloc] initWithFrame: self.bounds];
    
    UIImage *dropDownImage = [UIImage imageNamed:@"dropdown-icon@2x.png"];
    
    levelButton = [[NVUIGradientButton alloc] initWithFrame:CGRectMake(0, roundf(self.bounds.size.height-41)/2, 140, 41) style:NVUIGradientButtonStyleDefault];
    levelButton.rightAccessoryImage = [UIImage imageNamed:@"dropdown-icon@2x.png"];
    [levelButton addTarget:self action:@selector(onCityButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    levelButton.tintColor = levelButton.highlightedTintColor = [UIColor clearColor];
    levelButton.borderColor = [UIColor clearColor]; //colorWithRed:77.0/255.0 green:112.0/255.0 blue:255.0/255.0 alpha:0.5];
    levelButton.highlightedBorderColor = [UIColor clearColor]; //[UIColor colorWithRed:77.0/255.0 green:112.0/255.0 blue:255.0/255.0 alpha:1.0];
    [levelButton setCornerRadius:4.0f];
    [levelButton setGradientEnabled:NO];
    [levelButton setBorderWidth:2.0];
    levelButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:16];
    levelButton.titleLabel.textAlignment = NSTextAlignmentLeft;
    levelButton.textColor = [UIColor colorWithRed:77.0/255.0 green:112.0/255.0 blue:255.0/255.0 alpha:1.0];
    levelButton.highlightedTextColor = [UIColor blueColor];
    levelButton.textShadowColor = [UIColor whiteColor];
    levelButton.highlightedTextShadowColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.5];
    //levelButton.text = @"Все города";
    [headButtonsView addSubview:levelButton];
    imgLeftButton = [[UIImageView alloc] initWithImage:dropDownImage];
    imgLeftButton.frame = CGRectMake(levelButton.frame.size.width-dropDownImage.size.width+5, 19, dropDownImage.size.width/2, dropDownImage.size.height/2);
    [levelButton addSubview:imgLeftButton];
    
    categoryButton = [[NVUIGradientButton alloc] initWithFrame:CGRectMake(roundf(self.bounds.size.width-140-3), roundf(self.bounds.size.height-41)/2, 140, 41) style:NVUIGradientButtonStyleDefault];
    categoryButton.rightAccessoryImage = dropDownImage;
    [categoryButton addTarget:self action:@selector(onIndustrialButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    categoryButton.tintColor = categoryButton.highlightedTintColor = [UIColor clearColor];
    categoryButton.borderColor = [UIColor clearColor]; //colorWithRed:77.0/255.0 green:112.0/255.0 blue:255.0/255.0 alpha:0.5];
    categoryButton.highlightedBorderColor = [UIColor clearColor]; //[UIColor colorWithRed:77.0/255.0 green:112.0/255.0 blue:255.0/255.0 alpha:1.0];
    [categoryButton setCornerRadius:4.0f];
    [categoryButton setGradientEnabled:NO];
    [categoryButton setBorderWidth:2.0];
    categoryButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:16];
    categoryButton.titleLabel.textAlignment = NSTextAlignmentRight;
    categoryButton.textColor = [UIColor colorWithRed:77.0/255.0 green:112.0/255.0 blue:255.0/255.0 alpha:1.0];
    categoryButton.highlightedTextColor = [UIColor blueColor];
    categoryButton.textShadowColor = [UIColor whiteColor];
    categoryButton.highlightedTextShadowColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.5];
    //categoryButton.text = @"Все отрасли";
    [headButtonsView addSubview:categoryButton];
    imgRightButton = [[UIImageView alloc] initWithImage:dropDownImage];
    imgRightButton.frame = CGRectMake(categoryButton.frame.size.width-dropDownImage.size.width-3, 19, dropDownImage.size.width/2, dropDownImage.size.height/2);
    [categoryButton addSubview:imgRightButton];
    
    [self refreshMainButtonTitles:@"Все города" :@"Все отрасли"];
    
    [self addSubview:headButtonsView];
}

-(NSInteger) getSizeMainButtonWithText:(NSString*)text
{
    return [text sizeWithFont:[UIFont fontWithName:@"HelveticaNeue" size:16] constrainedToSize:CGSizeMake(120, 20) lineBreakMode:NSLineBreakByTruncatingTail].width;
}

-(void) createSubHeadButtons
{
    subHeadButtonsView = [[UIView alloc] initWithFrame: self.bounds];
    subHeadButtonsView.alpha = 0;
    
    /*cancelButton = [[NVUIGradientButton alloc] initWithFrame:CGRectMake(0, roundf(self.bounds.size.height-41)/2, 80, 41) style:NVUIGradientButtonStyleDefault];
    [cancelButton addTarget:self action:@selector(onCancelButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    cancelButton.tintColor = cancelButton.highlightedTintColor = [UIColor clearColor];
    cancelButton.borderColor = [UIColor clearColor]; //colorWithRed:77.0/255.0 green:112.0/255.0 blue:255.0/255.0 alpha:0.5];
    cancelButton.highlightedBorderColor = [UIColor clearColor]; //colorWithRed:77.0/255.0 green:112.0/255.0 blue:255.0/255.0 alpha:1.0];
    [cancelButton setCornerRadius:4.0f];
    [cancelButton setGradientEnabled:NO];
    [cancelButton setBorderWidth:2.0];
    cancelButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Regular" size:16];
    cancelButton.textColor = cancelButton.highlightedTextColor = [UIColor colorWithRed:77.0/255.0 green:112.0/255.0 blue:255.0/255.0 alpha:1.0];
    cancelButton.textShadowColor = [UIColor whiteColor];
    cancelButton.highlightedTextShadowColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.5];
    cancelButton.text = @"Отмена";
    [subHeadButtonsView addSubview:cancelButton];
    
    successButton = [[NVUIGradientButton alloc] initWithFrame:CGRectMake(roundf(self.bounds.size.width-80-0), roundf(self.bounds.size.height-41)/2, 80, 41) style:NVUIGradientButtonStyleDefault];
    [successButton addTarget:self action:@selector(onSuccessButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    successButton.tintColor = successButton.highlightedTintColor = [UIColor clearColor];
    successButton.borderColor = [UIColor clearColor]; //colorWithRed:77.0/255.0 green:112.0/255.0 blue:255.0/255.0 alpha:0.5];
    successButton.highlightedBorderColor = [UIColor clearColor]; //colorWithRed:77.0/255.0 green:112.0/255.0 blue:255.0/255.0 alpha:1.0];
    [successButton setCornerRadius:4.0f];
    [successButton setGradientEnabled:NO];
    [successButton setBorderWidth:2.0];
    successButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:16];
    successButton.textColor = successButton.highlightedTextColor = [UIColor colorWithRed:77.0/255.0 green:112.0/255.0 blue:255.0/255.0 alpha:1.0];
    successButton.textShadowColor = [UIColor whiteColor];
    successButton.highlightedTextShadowColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.5];
    successButton.text = @"Готово";
    //[subHeadButtonsView addSubview:successButton];*/
    
    searchBar = [[TRPartySearchBar alloc] initWithFrame:CGRectMake(5, 0, self.frame.size.width-10, 35)];
    searchBar.frame = CGRectOffset(searchBar.frame, 0, (self.frame.size.height-40)/2);
    [searchBar setShowsCancelButton:YES];
    searchBar.delegate = self;
    [subHeadButtonsView addSubview:searchBar];
    
    [self addSubview:subHeadButtonsView];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    [self refreshDataBySearchString:searchText];
}

-(void) refreshDataBySearchString:(NSString*)searchText
{
    NSPredicate *predicate;
    if(searchText.length > 0)
    {
        predicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS[cd] %@", searchText];
        
        if(citiesTableView != nil)  {
            _visibleCitiesList = [_citiesList filteredArrayUsingPredicate:predicate];
            [citiesTableView reloadData];
        }
        else    {
            _visibleIndustryList = [_industryList filteredArrayUsingPredicate:predicate];
            [industriesTableView reloadData];
        }
    } else  {
        if(citiesTableView != nil)  {
            _visibleCitiesList = _citiesList;
            [citiesTableView reloadData];
        }
        else    {
            _visibleIndustryList = _industryList;
            [industriesTableView reloadData];
        }
    }
}

- (void)searchBarCancelButtonClicked:(UISearchBar *) aSearchBar
{
    [aSearchBar resignFirstResponder];
    
    [self onCancelButtonClick:nil];
}

-(void) createCitiesTableView
{
    citiesTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.bounds.size.height,
                                                                   self.bounds.size.width,
                                                                   rootController.tableView.bounds.size.height-self.bounds.size.height)];
    citiesTableView.separatorColor = [UIColor colorWithRed:204.0/255.0
                                                     green:204.0/255.0
                                                      blue:204.0/255.0
                                                     alpha:1.0];
    citiesTableView.alpha = 0;
    citiesTableView.delegate = self;
    citiesTableView.dataSource = self;
    citiesTableView.allowsMultipleSelection = YES;
    
    [rootController.view addSubview: citiesTableView];
}

-(void) showCitiesTableView
{
    [self createCitiesTableView];
    
    [UIView animateWithDuration:SHOW_TIME animations:^{
        citiesTableView.alpha = 1;
    }];
    
    [searchBar setPlaceholder:@"Введите город"];
    [searchBar setText:@""];
    [searchBar becomeFirstResponder];
    [self refreshDataBySearchString:@""];
}

-(void) hideCitiesTableView
{
    [UIView animateWithDuration:HIDE_TIME animations:^{
        citiesTableView.alpha = 0;
    } completion:^(BOOL finished) {
        [citiesTableView removeFromSuperview];
        citiesTableView = nil;
    }];
}

-(void) createIndustryTableView
{
    industriesTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.bounds.size.height,
                                                                    self.bounds.size.width,
                                                                    rootController.tableView.bounds.size.height-self.bounds.size.height)];
    industriesTableView.separatorColor = [UIColor colorWithRed:204.0/255.0
                                                         green:204.0/255.0
                                                          blue:204.0/255.0
                                                         alpha:1.0];
    industriesTableView.alpha = 0;
    industriesTableView.delegate = self;
    industriesTableView.dataSource = self;
    industriesTableView.allowsMultipleSelection = YES;
    
    [rootController.view addSubview: industriesTableView];
}

-(void) showIndustryTableView
{
    [self createIndustryTableView];
    
    [UIView animateWithDuration:SHOW_TIME animations:^{
        industriesTableView.alpha = 1;
    }];
    
    [searchBar setPlaceholder:@"Введите отрасль"];
    [searchBar setText:@""];
    [searchBar becomeFirstResponder];
    [self refreshDataBySearchString:@""];
}

-(void) hideIndustryTableView
{
    [UIView animateWithDuration:HIDE_TIME animations:^{
        industriesTableView.alpha = 0;
    } completion:^(BOOL finished) {
        [industriesTableView removeFromSuperview];
        industriesTableView = nil;
    }];
}

#pragma mark - UITableViewDataSource

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [searchBar resignFirstResponder];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(tableView == citiesTableView)
        return _visibleCitiesList.count;
    else
        return _visibleIndustryList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *itemCellIdentifier = @"TRPartyUserFilterCell";
    
    UITableViewCell *cell;
    cell = [tableView dequeueReusableCellWithIdentifier:itemCellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:itemCellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue-Regular" size:18];
    }
    
    if(tableView == citiesTableView) {
        
        /*if(indexPath.row == lastCitySelectIndexPath.row)
        {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
        else
            cell.accessoryType = UITableViewCellAccessoryNone;*/
        
        cell.textLabel.text = [_visibleCitiesList objectAtIndex:indexPath.row];
    }
    else
    {
        /*if(indexPath.row == lastIndustrySelectIndexPath.row)
        {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
        else
            cell.accessoryType = UITableViewCellAccessoryNone;*/
        
        cell.textLabel.text = [_visibleIndustryList objectAtIndex:indexPath.row];
    }
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if(tableView == citiesTableView) {
        /*UITableViewCell *cell = [tableView cellForRowAtIndexPath:lastCitySelectIndexPath];
        cell.accessoryType = UITableViewCellAccessoryNone;
        
        cell = [tableView cellForRowAtIndexPath:indexPath];
        cell.accessoryType = UITableViewCellAccessoryCheckmark;*/
        
        lastCitySelectIndexPath = indexPath;
    } else {
        /*UITableViewCell *cell = [tableView cellForRowAtIndexPath:lastIndustrySelectIndexPath];
        cell.accessoryType = UITableViewCellAccessoryNone;
        
        cell = [tableView cellForRowAtIndexPath:indexPath];
        cell.accessoryType = UITableViewCellAccessoryCheckmark;*/
        
        lastIndustrySelectIndexPath = indexPath;
    }
    
    [self onClickByCell];
}

-(void) onClickByCell
{
    [searchBar resignFirstResponder];
    
    [self showRootContent];
    
    if(citiesTableView != nil)
        [self hideCitiesTableView];
    else
        [self hideIndustryTableView];
    
    
    NSString *cityName;
    NSString *industryName;
    
    cityName = [_visibleCitiesList objectAtIndex:lastCitySelectIndexPath.row];
    industryName = [_visibleIndustryList objectAtIndex:lastIndustrySelectIndexPath.row];
    
    [self refreshMainButtonTitles:cityName :industryName];
    
    if([cityName isEqualToString:@"Все города"])
        cityName = @"";
    if([industryName isEqualToString:@"Все отрасли"])
        industryName = @"";
    
    [rootController refreshUserListByCity: cityName andIndustry: industryName];
}

-(void) refreshMainButtonTitles:(NSString*)cityName :(NSString*)industryName
{
    UIImage *dropDownImage = [UIImage imageNamed:@"dropdown-icon@2x.png"];
    
    levelButton.text = cityName;
    NSInteger leftImageX = [self getSizeMainButtonWithText:cityName];
    
    imgLeftButton.frame = CGRectMake(leftImageX + 13, 19, dropDownImage.size.width/2, dropDownImage.size.height/2);
    
    categoryButton.text = industryName;
    imgRightButton.frame = CGRectMake(categoryButton.frame.size.width-dropDownImage.size.width+5, 19, dropDownImage.size.width/2, dropDownImage.size.height/2);
}

@end
