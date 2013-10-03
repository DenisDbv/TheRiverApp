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
@end

@implementation TRPartyUsersFilter
{
    TRPartyUsersListVC *rootController;
    
    NSIndexPath *preLastCitySelectIndexPath;
    NSIndexPath *lastCitySelectIndexPath;
    
    NSIndexPath *preLastIndustrySelectIndexPath;
    NSIndexPath *lastIndustrySelectIndexPath;
}
@synthesize levelButton, categoryButton, cancelButton, successButton;
@synthesize headButtonsView, subHeadButtonsView;
@synthesize citiesTableView, industriesTableView;

- (id)initWithFrame:(CGRect)frame byRootTarget:(id)target
{
    self = [super initWithFrame:frame];
    if (self) {
        
        rootController = target;
        
        lastCitySelectIndexPath = [NSIndexPath indexPathForRow:-1 inSection:0];
        lastIndustrySelectIndexPath = [NSIndexPath indexPathForRow:-1 inSection:0];
        preLastCitySelectIndexPath = [NSIndexPath indexPathForRow:-1 inSection:0];
        preLastIndustrySelectIndexPath = [NSIndexPath indexPathForRow:-1 inSection:0];
        
        [self createSubHeadButtons];
        [self createHeadButtons];
        
        NSLog(@"%i", [TRSearchPUManager client].cityList.count);
    }
    return self;
}

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
    [UIView animateWithDuration:HIDE_TIME animations:^{
        headButtonsView.alpha = 0;
        subHeadButtonsView.alpha = 1;
        rootController.tableView.contentOffset = CGPointMake(0, -rootController.tableView.frame.size.height);
    }];
}

-(void) showRootContent
{
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
        lastCitySelectIndexPath = preLastCitySelectIndexPath;
       [self hideCitiesTableView];
    }
    else    {
        lastIndustrySelectIndexPath = preLastIndustrySelectIndexPath;
        [self hideIndustryTableView];
    }
}

-(void) onSuccessButtonClick:(NVUIGradientButton*)sender
{
    [self showRootContent];
    
    if(citiesTableView != nil)
        [self hideCitiesTableView];
    else
        [self hideIndustryTableView];
    
    
    NSString *cityName;
    NSString *industryName;
    
    if(lastCitySelectIndexPath.row >= 0)
        cityName = [[TRSearchPUManager client].cityList objectAtIndex:lastCitySelectIndexPath.row];
    else
        cityName = @"";
    
    if(lastIndustrySelectIndexPath.row >= 0)
        industryName = [[TRSearchPUManager client].industryList objectAtIndex:lastIndustrySelectIndexPath.row];
    else
        industryName = @"";
    
    [rootController refreshUserListByCity: cityName andIndustry: industryName];
}

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
    
    levelButton = [[NVUIGradientButton alloc] initWithFrame:CGRectMake(0, roundf(self.bounds.size.height-41)/2, 80, 41) style:NVUIGradientButtonStyleDefault];
    levelButton.rightAccessoryImage = [UIImage imageNamed:@"dropdown-icon@2x.png"];
    [levelButton addTarget:self action:@selector(onCityButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    levelButton.tintColor = levelButton.highlightedTintColor = [UIColor clearColor];
    levelButton.borderColor = [UIColor clearColor]; //colorWithRed:77.0/255.0 green:112.0/255.0 blue:255.0/255.0 alpha:0.5];
    levelButton.highlightedBorderColor = [UIColor clearColor]; //[UIColor colorWithRed:77.0/255.0 green:112.0/255.0 blue:255.0/255.0 alpha:1.0];
    [levelButton setCornerRadius:4.0f];
    [levelButton setGradientEnabled:NO];
    [levelButton setBorderWidth:2.0];
    levelButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:16];
    levelButton.textColor = [UIColor colorWithRed:77.0/255.0 green:112.0/255.0 blue:255.0/255.0 alpha:1.0];
    levelButton.highlightedTextColor = [UIColor blueColor];
    levelButton.textShadowColor = [UIColor whiteColor];
    levelButton.highlightedTextShadowColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.5];
    levelButton.text = @"Город";
    [headButtonsView addSubview:levelButton];
    UIImageView *imgLeftButton = [[UIImageView alloc] initWithImage:dropDownImage];
    imgLeftButton.frame = CGRectMake(levelButton.frame.size.width-dropDownImage.size.width+5, 19, dropDownImage.size.width/2, dropDownImage.size.height/2);
    [levelButton addSubview:imgLeftButton];
    
    categoryButton = [[NVUIGradientButton alloc] initWithFrame:CGRectMake(roundf(self.bounds.size.width-120-0), roundf(self.bounds.size.height-41)/2, 120, 41) style:NVUIGradientButtonStyleDefault];
    categoryButton.rightAccessoryImage = dropDownImage;
    [categoryButton addTarget:self action:@selector(onIndustrialButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    categoryButton.tintColor = categoryButton.highlightedTintColor = [UIColor clearColor];
    categoryButton.borderColor = [UIColor clearColor]; //colorWithRed:77.0/255.0 green:112.0/255.0 blue:255.0/255.0 alpha:0.5];
    categoryButton.highlightedBorderColor = [UIColor clearColor]; //[UIColor colorWithRed:77.0/255.0 green:112.0/255.0 blue:255.0/255.0 alpha:1.0];
    [categoryButton setCornerRadius:4.0f];
    [categoryButton setGradientEnabled:NO];
    [categoryButton setBorderWidth:2.0];
    categoryButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:16];
    categoryButton.textColor = [UIColor colorWithRed:77.0/255.0 green:112.0/255.0 blue:255.0/255.0 alpha:1.0];
    categoryButton.highlightedTextColor = [UIColor blueColor];
    categoryButton.textShadowColor = [UIColor whiteColor];
    categoryButton.highlightedTextShadowColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.5];
    categoryButton.text = @"Отрасли";
    [headButtonsView addSubview:categoryButton];
    UIImageView *imgRightButton = [[UIImageView alloc] initWithImage:dropDownImage];
    imgRightButton.frame = CGRectMake(categoryButton.frame.size.width-dropDownImage.size.width-3, 19, dropDownImage.size.width/2, dropDownImage.size.height/2);
    [categoryButton addSubview:imgRightButton];
    
    [self addSubview:headButtonsView];
}

-(void) createSubHeadButtons
{
    subHeadButtonsView = [[UIView alloc] initWithFrame: self.bounds];
    subHeadButtonsView.alpha = 0;
    
    cancelButton = [[NVUIGradientButton alloc] initWithFrame:CGRectMake(0, roundf(self.bounds.size.height-41)/2, 80, 41) style:NVUIGradientButtonStyleDefault];
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
    [subHeadButtonsView addSubview:successButton];
    
    [self addSubview:subHeadButtonsView];
}

-(void) createCitiesTableView
{
    citiesTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.bounds.size.height,
                                                                   self.bounds.size.width,
                                                                   rootController.tableView.bounds.size.height-self.bounds.size.height)];
    citiesTableView.separatorColor = [UIColor blackColor];
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
    industriesTableView.separatorColor = [UIColor blackColor];
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(tableView == citiesTableView)
        return [TRSearchPUManager client].cityList.count;
    else
        return [TRSearchPUManager client].industryList.count;
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
        
        if(indexPath.row == lastCitySelectIndexPath.row)
        {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
        else
            cell.accessoryType = UITableViewCellAccessoryNone;
        
        cell.textLabel.text = [[TRSearchPUManager client].cityList objectAtIndex:indexPath.row];
    }
    else
    {
        if(indexPath.row == lastIndustrySelectIndexPath.row)
        {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
        else
            cell.accessoryType = UITableViewCellAccessoryNone;
        
        cell.textLabel.text = [[TRSearchPUManager client].industryList objectAtIndex:indexPath.row];
    }
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if(tableView == citiesTableView) {
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:lastCitySelectIndexPath];
        cell.accessoryType = UITableViewCellAccessoryNone;
        
        cell = [tableView cellForRowAtIndexPath:indexPath];
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        
        preLastCitySelectIndexPath = lastCitySelectIndexPath;
        lastCitySelectIndexPath = indexPath;
    } else {
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:lastIndustrySelectIndexPath];
        cell.accessoryType = UITableViewCellAccessoryNone;
        
        cell = [tableView cellForRowAtIndexPath:indexPath];
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        
        preLastIndustrySelectIndexPath = lastIndustrySelectIndexPath;
        lastIndustrySelectIndexPath = indexPath;
    }
}

@end
