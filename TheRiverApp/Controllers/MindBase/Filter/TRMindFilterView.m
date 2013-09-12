//
//  TRMindFilterView.m
//  TheRiverApp
//
//  Created by DenisDbv on 12.09.13.
//  Copyright (c) 2013 axbx. All rights reserved.
//

#import "TRMindFilterView.h"
#import <NVUIGradientButton/NVUIGradientButton.h>
#import <SSToolkit/SSToolkit.h>

#import "TRMindBaseListVC.h"

#define HIDE_TIME   0.3
#define SHOW_TIME   0.1

@interface TRMindFilterView()
@property (nonatomic, retain) NVUIGradientButton *levelButton;
@property (nonatomic, retain) NVUIGradientButton *categoryButton;
@property (nonatomic, retain) UIView *headButtonsView;

@property (nonatomic, retain) NVUIGradientButton *cancelButton;
@property (nonatomic, retain) NVUIGradientButton *successButton;
@property (nonatomic, retain) UIView *subHeadButtonsView;

@property (nonatomic, retain) UITableView *levelTableView;
@property (nonatomic, retain) UITableView *categoryTableView;
@end

@implementation TRMindFilterView
{
    TRMindBaseListVC *rootController;
    
    NSArray *levelStringArray;
    NSArray *levelSubStringArray;
    NSArray *categoriesStringArray;
    NSIndexPath *lastSelectIndexPath;
}
@synthesize levelButton, categoryButton, cancelButton, successButton;
@synthesize headButtonsView, subHeadButtonsView;
@synthesize levelTableView, categoryTableView;

- (id)initWithFrame:(CGRect)frame byRootTarget:(id)target
{
    self = [super initWithFrame:frame];
    if (self) {
        rootController = target;
        
        levelStringArray = @[@"Все уровни", @"Уровень 1", @"Уровень 2", @"Уровень 3"];
        levelSubStringArray = @[@"", @"от 120 000", @"от 300 000", @"от 1 000 000"];
        categoriesStringArray = @[@"Бизнес и право", @"Мотивация", @"Вебинары", @"Продвинутый уровень", @"Базовый уровень", @"Скрипты", @"Техники БМ", @"Масштабирование", @"Стиль", @"Выбор ЦА", @"Связи", @"Копирайтинг", @"SMM", @"Аналитика", @"Управление", @"Резонанс", @"Переговоры", @"Управление ассортиментом", @"Продажи", @"Поставщики", @"Выбор ниши", @"Начинающему", @"Бизнесмену"];
        lastSelectIndexPath = [NSIndexPath indexPathForRow:-1 inSection:0];
        
        [self createSubHeadButtons];
        [self createHeadButtons];
    }
    return self;
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
    
    levelButton = [[NVUIGradientButton alloc] initWithFrame:CGRectMake(5, roundf(self.bounds.size.height-41)/2, 90, 41) style:NVUIGradientButtonStyleDefault];
    levelButton.rightAccessoryImage = [UIImage imageNamed:@"dropdown-icon@2x.png"];
    [levelButton addTarget:self action:@selector(onLevelButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    levelButton.tintColor = levelButton.highlightedTintColor = [UIColor clearColor];
    levelButton.borderColor = [UIColor clearColor]; //[UIColor colorWithRed:77.0/255.0 green:112.0/255.0 blue:255.0/255.0 alpha:0.5];
    levelButton.highlightedBorderColor = [UIColor clearColor]; //[UIColor colorWithRed:77.0/255.0 green:112.0/255.0 blue:255.0/255.0 alpha:1.0];
    [levelButton setCornerRadius:4.0f];
    [levelButton setGradientEnabled:NO];
    [levelButton setBorderWidth:2.0];
    levelButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:16];
    levelButton.textColor = [UIColor colorWithRed:77.0/255.0 green:112.0/255.0 blue:255.0/255.0 alpha:1.0];
    levelButton.highlightedTextColor = [UIColor blueColor];
    levelButton.textShadowColor = [UIColor whiteColor];
    levelButton.highlightedTextShadowColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.5];
    levelButton.text = @"Уровень";
    [headButtonsView addSubview:levelButton];
    UIImageView *imgLeftButton = [[UIImageView alloc] initWithImage:dropDownImage];
    imgLeftButton.frame = CGRectMake(levelButton.frame.size.width-dropDownImage.size.width+5, 19, dropDownImage.size.width/2, dropDownImage.size.height/2);
    [levelButton addSubview:imgLeftButton];
    
    categoryButton = [[NVUIGradientButton alloc] initWithFrame:CGRectMake(roundf(self.bounds.size.width-120-5), roundf(self.bounds.size.height-41)/2, 120, 41) style:NVUIGradientButtonStyleDefault];
    categoryButton.rightAccessoryImage = dropDownImage;
    [categoryButton addTarget:self action:@selector(onCategoryButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    categoryButton.tintColor = categoryButton.highlightedTintColor = [UIColor clearColor];
    categoryButton.borderColor = [UIColor clearColor]; //[UIColor colorWithRed:77.0/255.0 green:112.0/255.0 blue:255.0/255.0 alpha:0.5];
    categoryButton.highlightedBorderColor = [UIColor clearColor]; //[UIColor colorWithRed:77.0/255.0 green:112.0/255.0 blue:255.0/255.0 alpha:1.0];
    [categoryButton setCornerRadius:4.0f];
    [categoryButton setGradientEnabled:NO];
    [categoryButton setBorderWidth:2.0];
    categoryButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:16];
    categoryButton.textColor = [UIColor colorWithRed:77.0/255.0 green:112.0/255.0 blue:255.0/255.0 alpha:1.0];
    categoryButton.highlightedTextColor = [UIColor blueColor];
    categoryButton.textShadowColor = [UIColor whiteColor];
    categoryButton.highlightedTextShadowColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.5];
    categoryButton.text = @"Категории";
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
    
    cancelButton = [[NVUIGradientButton alloc] initWithFrame:CGRectMake(5, roundf(self.bounds.size.height-41)/2, 146, 41) style:NVUIGradientButtonStyleDefault];
    [cancelButton addTarget:self action:@selector(onCancelButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    cancelButton.tintColor = cancelButton.highlightedTintColor = [UIColor clearColor];
    cancelButton.borderColor = [UIColor colorWithRed:77.0/255.0 green:112.0/255.0 blue:255.0/255.0 alpha:0.5];
    cancelButton.highlightedBorderColor = [UIColor colorWithRed:77.0/255.0 green:112.0/255.0 blue:255.0/255.0 alpha:1.0];
    [cancelButton setCornerRadius:4.0f];
    [cancelButton setGradientEnabled:NO];
    [cancelButton setBorderWidth:2.0];
    cancelButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:16];
    cancelButton.textColor = cancelButton.highlightedTextColor = [UIColor colorWithRed:77.0/255.0 green:112.0/255.0 blue:255.0/255.0 alpha:1.0];
    cancelButton.textShadowColor = [UIColor whiteColor];
    cancelButton.highlightedTextShadowColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.5];
    cancelButton.text = @"Отмена";
    [subHeadButtonsView addSubview:cancelButton];
    
    successButton = [[NVUIGradientButton alloc] initWithFrame:CGRectMake(roundf(self.bounds.size.width-146-5), roundf(self.bounds.size.height-41)/2, 146, 41) style:NVUIGradientButtonStyleDefault];
    [successButton addTarget:self action:@selector(onSuccessButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    successButton.tintColor = successButton.highlightedTintColor = [UIColor clearColor];
    successButton.borderColor = [UIColor colorWithRed:77.0/255.0 green:112.0/255.0 blue:255.0/255.0 alpha:0.5];
    successButton.highlightedBorderColor = [UIColor colorWithRed:77.0/255.0 green:112.0/255.0 blue:255.0/255.0 alpha:1.0];
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

-(void) createLevelTableView
{
    levelTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.bounds.size.height,
                                                                   self.bounds.size.width,
                                                                   rootController.tableView.bounds.size.height-self.bounds.size.height)];
    levelTableView.alpha = 0;
    levelTableView.delegate = self;
    levelTableView.dataSource = self;
    levelTableView.allowsMultipleSelection = YES;
    
    [rootController.view addSubview: levelTableView];
}

-(void) createCategoryTableView
{
    categoryTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.bounds.size.height,
                                                                   self.bounds.size.width,
                                                                   rootController.tableView.bounds.size.height-self.bounds.size.height)];
    categoryTableView.alpha = 0;
    categoryTableView.delegate = self;
    categoryTableView.dataSource = self;
    
    [rootController.view addSubview: categoryTableView];
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

-(void) showLevelTableView
{
    [self createLevelTableView];
    
    [UIView animateWithDuration:SHOW_TIME animations:^{
        levelTableView.alpha = 1;
    }];
}

-(void) hideLevelTableView
{
    [UIView animateWithDuration:HIDE_TIME animations:^{
        levelTableView.alpha = 0;
    } completion:^(BOOL finished) {
        [levelTableView removeFromSuperview];
        levelTableView = nil;
    }];
}

-(void) showCategoryTableView
{
    [self createCategoryTableView];
    
    [UIView animateWithDuration:SHOW_TIME animations:^{
        categoryTableView.alpha = 1;
    }];
}

-(void) hideCategoryTableView
{
    [UIView animateWithDuration:HIDE_TIME animations:^{
        categoryTableView.alpha = 0;
    } completion:^(BOOL finished) {
        [categoryTableView removeFromSuperview];
        categoryTableView = nil;
    }];
}

-(void) onLevelButtonClick:(NVUIGradientButton*)sender
{
    [self hideRootContent];
    [self showLevelTableView];
}

-(void) onCategoryButtonClick:(NVUIGradientButton*)sender
{
    [self hideRootContent];
    [self showCategoryTableView];
}

-(void) onCancelButtonClick:(NVUIGradientButton*)sender
{
    [self showRootContent];
    
    if(levelTableView != nil)
        [self hideLevelTableView];
    else
        [self hideCategoryTableView];
}

-(void) onSuccessButtonClick:(NVUIGradientButton*)sender
{
    [self showRootContent];
    
    if(levelTableView != nil)
        [self hideLevelTableView];
    else
        [self hideCategoryTableView];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(tableView == levelTableView)
        return (NSInteger)levelStringArray.count;
    else
        return (NSInteger)categoriesStringArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *itemCellIdentifier = @"TRMindFilterCell";
    
    UITableViewCell *cell;
    if(tableView == levelTableView) {
        cell = [tableView dequeueReusableCellWithIdentifier:itemCellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:itemCellIdentifier];
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:18];
            cell.detailTextLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:14];
            cell.detailTextLabel.textColor = [UIColor lightGrayColor];
        }
        
        cell.textLabel.text = [levelStringArray objectAtIndex:indexPath.row];
        cell.detailTextLabel.text = [levelSubStringArray objectAtIndex:indexPath.row];
    }
    else    {
        cell = [tableView dequeueReusableCellWithIdentifier:itemCellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:itemCellIdentifier];
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:18];
        }
        
        if(indexPath.row == lastSelectIndexPath.row)
        {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
        else
            cell.accessoryType = UITableViewCellAccessoryNone;
        
        cell.textLabel.text = [categoriesStringArray objectAtIndex:indexPath.row];
    }
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if(tableView == levelTableView) {
        if(indexPath.row == 0)
        {
            UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            
            if(cell.accessoryType == UITableViewCellAccessoryCheckmark)
                [self uncheckAllItemsIn:tableView];
            else
                [self checkAllItemsIn:tableView];
        }
        else    {        
            UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            if(cell.accessoryType == UITableViewCellAccessoryCheckmark)
                cell.accessoryType = UITableViewCellAccessoryNone;
            else
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
            
            [self scanAllItemsIn:tableView];
        }
    }
    else    {
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:lastSelectIndexPath];
        cell.accessoryType = UITableViewCellAccessoryNone;
        
        cell = [tableView cellForRowAtIndexPath:indexPath];
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        
        lastSelectIndexPath = indexPath;
    }
}

-(void) checkAllItemsIn:(UITableView*)tableView
{
    UITableViewCell *cell;
    NSInteger numRows = [tableView numberOfRowsInSection:0];
    for(int row = 0; row < numRows; row++)
    {
        cell = [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:row inSection:0]];
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
}

-(void) uncheckAllItemsIn:(UITableView*)tableView
{
    UITableViewCell *cell;
    NSInteger numRows = [tableView numberOfRowsInSection:0];
    for(int row = 0; row < numRows; row++)
    {
        cell = [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:row inSection:0]];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
}

-(void) scanAllItemsIn:(UITableView*)tableView
{
    NSInteger count = 0;
    UITableViewCell *cell;
    NSInteger numRows = [tableView numberOfRowsInSection:0];
    for(int row = 1; row < numRows; row++)
    {
        cell = [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:row inSection:0]];
        if(cell.accessoryType == UITableViewCellAccessoryCheckmark)
            count++;
    }
    
    cell = [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    if( count == (numRows-1) )
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    else
        cell.accessoryType = UITableViewCellAccessoryNone;
}

@end
