//
//  TRImageReviewController.m
//  TheRiverApp
//
//  Created by DenisDbv on 01.10.13.
//  Copyright (c) 2013 axbx. All rights reserved.
//

#import "TRImageReviewController.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <UIActivityIndicator-for-SDWebImage/UIImageView+UIActivityIndicatorForSDWebImage.h>
#import "UIBarButtonItem+BarButtonItemExtended.h"
#import "UIView+GestureBlocks.h"

@interface TRImageReviewController ()

@end

@implementation TRImageReviewController
{
    NSString *_imagePath;
    BOOL isShow;
}
@synthesize zoomView;

- (id) initWithImage:(NSString*)imagePath
{
    self = [super initWithNibName:@"TRImageReviewController" bundle:nil];
    if (self) {
        _imagePath = imagePath;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.navigationController.navigationBar setTintColor:[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.9]];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    
    UIBarButtonItem *onCancelButton = [UIBarButtonItem barItemWithImage:[UIImage imageNamed:@"toolbar-back-button@2x.png"] target:self action:@selector(onBack)];
    [onCancelButton setBackgroundImage:[UIImage new] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [self.navigationItem setLeftBarButtonItem:onCancelButton animated:YES];
    
    self.view.backgroundColor = [UIColor blackColor];
    zoomView.backgroundColor = [UIColor clearColor];
}

-(void) viewWillAppear:(BOOL)animated
{
    /*[[SDWebImageDownloader sharedDownloader] downloadImageWithURL:[NSURL URLWithString: _imagePath]
                                                          options:SDWebImageDownloaderUseNSURLCache progress:nil
                                                        completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished)
     {
         if(image != nil)
         {
             [zoomView setImage:image];
         }
     }];*/
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
    zoomView.frame = CGRectMake(0, 0, screenWidth, screenHeight-44-20);
    
    [zoomView setImage:[[SDImageCache sharedImageCache] imageFromDiskCacheForKey:_imagePath]];
    
    [self performSelector:@selector(hideNavBar) withObject:nil afterDelay:0.5];
    
    [zoomView initialiseTapHandler:^(UIGestureRecognizer *sender) {
        (isShow) ? [self hideNavBar] : [self showNavBar];
    } forTaps:1];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void) onBack
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void) hideNavBar
{
    [UIView animateWithDuration:0.5 animations:^{
        self.navigationController.navigationBar.alpha = 0;
    } completion:^(BOOL finished) {
        isShow = NO;
    }];
}

-(void) showNavBar
{
    [UIView animateWithDuration:0.2 animations:^{
        self.navigationController.navigationBar.alpha = 1;
    } completion:^(BOOL finished) {
        isShow = YES;
    }];
}


@end
