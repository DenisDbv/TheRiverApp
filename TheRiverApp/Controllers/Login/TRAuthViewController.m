//
//  TRAuthViewController.m
//  TheRiverApp
//
//  Created by DenisDbv on 21.09.13.
//  Copyright (c) 2013 axbx. All rights reserved.
//

#import "TRAuthViewController.h"
#import <QuartzCore/QuartzCore.h>
#import <NVUIGradientButton/NVUIGradientButton.h>
#import "UIView+GestureBlocks.h"

#import <MGBox2/MGBox.h>
#import <MGBox2/MGScrollView.h>
#import <MGBox2/MGTableBoxStyled.h>
#import <MGBox2/MGLineStyled.h>
#import "TRAuthPhotoBox.h"

@interface TRAuthViewController ()
@property (nonatomic, retain) TRAuthBlockView *authBlockView;

@property (nonatomic, retain) MGScrollView *backScrollView;
@end

@implementation TRAuthViewController
{
    MGBox *photosBox;
    NSTimer *refreshPhotoTimer;
    NSArray *photosBoxArray;
}
@synthesize scrollView;
@synthesize authBlockView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        //
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    scrollView.frame = CGRectMake(0, 0, self.view.bounds.size.width, ([UIScreen mainScreen].bounds.size.height));
    [scrollView setContentSize:scrollView.frame.size];
    scrollView.bounces = NO;
    
    authBlockView = [[TRAuthBlockView alloc] init];
    authBlockView.delegate = self;
    [self.scrollView addSubview:authBlockView];
    
    CGRect rectLoginContainer = authBlockView.frame;
    rectLoginContainer.origin.x = ([UIScreen mainScreen].bounds.size.width - rectLoginContainer.size.width)/2;
    rectLoginContainer.origin.y = [UIScreen mainScreen].bounds.size.height - rectLoginContainer.size.height - 23.0f - ((IS_IPHONE5)?30:0);
    //(([UIScreen mainScreen].bounds.size.height) - rectLoginContainer.size.height)/2 + ((IS_IPHONE5)?50:110);
    authBlockView.frame = rectLoginContainer;
    
    [self createRootScrollView];
    
    [scrollView initialiseSwipeUpHandler:^(UIGestureRecognizer *sender) {
        [self resignFromAllFields];
    }];
    
    [scrollView initialiseSwipeDownHandler:^(UIGestureRecognizer *sender) {
        [self resignFromAllFields];
    }];
    
    [self createTimer];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShown:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHidden:) name:UIKeyboardWillHideNotification object:nil];
}

-(void) viewWillDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:UIKeyboardDidShowNotification];
    [[NSNotificationCenter defaultCenter] removeObserver:UIKeyboardWillHideNotification];
    
    [self removeTimer];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void) createTimer
{
    refreshPhotoTimer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(refreshPhotoEvent) userInfo:nil repeats:YES];
}

-(void) removeTimer
{
    [refreshPhotoTimer invalidate];
    refreshPhotoTimer = nil;
}

-(void) refreshPhotoEvent
{
    int firstItem = [self randomMissingPhoto];
    int secondItem = [self randomMissingPhoto];
    
    TRAuthPhotoBox *photoBoxFirst = [photosBox.boxes objectAtIndex:firstItem];
    TRAuthPhotoBox *photoBoxSecond = [photosBox.boxes objectAtIndex:secondItem];
    
    NSString *firstImageName = photoBoxFirst.photoName;
    NSString *secondImageName = photoBoxSecond.photoName;
    
    [photoBoxFirst changePhotoTo: secondImageName];
    [photoBoxSecond changePhotoTo: firstImageName];
    
    //NSLog(@"%i to %i", firstItem, secondItem);
}

-(void) createRootScrollView
{
    _backScrollView = [[MGScrollView alloc] initWithFrame:CGRectMake(0, 0, 324, self.view.bounds.size.height)];
    _backScrollView.backgroundColor = [UIColor whiteColor];
    //_backScrollView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    _backScrollView.padding = UIEdgeInsetsMake(0, 0, 0, 0);
    _backScrollView.margin = UIEdgeInsetsMake(0, 0, 0, 0);
    _backScrollView.contentLayoutMode = MGLayoutGridStyle;
    _backScrollView.scrollEnabled = NO;
    //_backScrollView.backgroundColor = [UIColor redColor];
    _backScrollView.contentSize = _backScrollView.bounds.size;
    [self.view insertSubview:_backScrollView belowSubview:scrollView];
    
    photosBox = [MGBox boxWithSize:_backScrollView.bounds.size];
    photosBox.contentLayoutMode = MGLayoutGridStyle;
    [_backScrollView.boxes addObject:photosBox];
    
    photosBoxArray = [self arrangePhotoPaths];
    for(NSString *path in photosBoxArray)
    {
        TRAuthPhotoBox *photoBox = [TRAuthPhotoBox photoAddBoxWithFileName:path andTag:1];
        [photosBox.boxes addObject:photoBox];
    }
    
    //[photosBox layoutWithSpeed:0.5 completion:nil];
    [_backScrollView layoutWithSpeed:0.1 completion:nil];
}

#pragma mark - Photo Box helpers

- (int)randomMissingPhoto {
    int photo;
    
    photo = arc4random_uniform(170) + 1;
    
    return photo;
}

- (MGBox *)photoBoxWithTag:(int)tag {
    for (MGBox *box in photosBox.boxes) {
        if (box.tag == tag) {
            return box;
        }
    }
    return nil;
}

-(NSArray*) arrangePhotoPaths
{
    NSMutableArray *photosArray = [[NSMutableArray alloc] init];
    for(int index = 1; index <= 171; index++)
    {
        [photosArray addObject:[NSString stringWithFormat:@"%i.jpg", index]];
    }
    
    int count = photosArray.count;
    for (NSUInteger i = 0; i < count; ++i) {
        int nElements = count - i;
        int n = (arc4random() % nElements) + i;
        [photosArray exchangeObjectAtIndex:i withObjectAtIndex:n];
    }
    
    return photosArray;
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self resignFromAllFields];
}

-(void) resignFromAllFields
{
    [authBlockView resignFromAllFields];
}

- (void) keyboardShown:(NSNotification *)note{
    
    CGRect keyboardFrame;
    UIViewAnimationCurve *keyboardCurve;
    double keyboardDuration;
    
    [[[note userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] getValue:&keyboardFrame];
    [[[note userInfo] objectForKey:UIKeyboardAnimationCurveUserInfoKey] getValue:&keyboardCurve];
    [[[note userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] getValue:&keyboardDuration];
    
    NSInteger yOffset = abs((keyboardFrame.origin.y - authBlockView.frame.size.height)/2 - authBlockView.frame.origin.y + ((IS_IPHONE5)?9:9));
    [scrollView setContentOffset:CGPointMake(0, yOffset) animated:YES];
    
    [scrollView setScrollEnabled:NO];
}

- (void) keyboardHidden:(NSNotification *)note{
    
    CGRect keyboardFrame;
    UIViewAnimationCurve *keyboardCurve;
    double keyboardDuration;
    
    [[[note userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] getValue:&keyboardFrame];
    [[[note userInfo] objectForKey:UIKeyboardAnimationCurveUserInfoKey] getValue:&keyboardCurve];
    [[[note userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] getValue:&keyboardDuration];
    
    [scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    
    [scrollView setScrollEnabled:YES];
}

-(void) onClickLoginWithEmail:(NSString*)email andPassword:(NSString*)password
{
    if(email.length == 0 || password.length == 0)   {
        [authBlockView shakeLoginView];
        return;
    }
    
    [authBlockView startSpinner];
    
    [[TRAuthManager client] authByLogin:email
                            andPassword:password
                   withSuccessOperation:^(LRRestyResponse *response) {
                       NSLog(@"User token: %@", [TRAuthManager client].iamData.token);
                       
                       if([[TRAuthManager client] isAuth] == YES)   {
                           [AppDelegateInstance() registerUserForFeedBack];
                           
                           [AppDelegateInstance() presentTheRiverControllers];
                           
                           [AppDelegateInstance() checkBusinessURL];
                       } else   {
                           [authBlockView stopSpinner];
                           
                           [authBlockView shakeLoginView];
                           
                           authBlockView.passwordTextField.text = @"";
                       }
                   } andFailedOperation:^(LRRestyResponse *response) {
                       [authBlockView shakeLoginView];
                   }];
}

@end
