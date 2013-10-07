//
//  TRHeadBox.m
//  TheRiverApp
//
//  Created by DenisDbv on 03.09.13.
//  Copyright (c) 2013 axbx. All rights reserved.
//

#import "TRHeadBox.h"
#import <MGBox2/MGScrollView.h>
#import <QuartzCore/QuartzCore.h>
#import <SSToolkit/SSToolkit.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import <UIActivityIndicator-for-SDWebImage/UIImageView+UIActivityIndicatorForSDWebImage.h>
#import "UIImage+Resize.h"
#import <MIHGradientView/MIHGradientView.h>
#import "UIView+GestureBlocks.h"
#import "TRImageReviewController.h"

@implementation TRHeadBox

+ (Class)layerClass {
    return [CAGradientLayer class];
}

- (void)setup {

    self.backgroundColor = [UIColor whiteColor];
    
}

+(TRHeadBox *)initBox:(CGSize)bounds withUserData:(TRUserInfoModel *)userObject
{
    TRHeadBox *box = [TRHeadBox boxWithSize: CGSizeMake(bounds.width, 200)];    //132   //173
    box.userData = userObject;
    
    [box fillBoxByColorGradient];
    [box fillBoxByBusinessImage];
    [box showUserLogo];
    [box showProfitTitle];
    [box showFirstAndLastName];
    [box showYearsAndCity];
    
    //TRPhotoBox *photoBox = [TRPhotoBox initBox];
    //[box.boxes addObject:photoBox];
    
    return box;
}

-(void) fillBoxByColorGradient
{
    CAGradientLayer *layer = (CAGradientLayer *)self.layer;
    
    /*UIColor *darkColor = [UIColor colorWithRed:24.0/255.0 green:171.0/255.0 blue:110.0/255.0 alpha:1.0f];
    UIColor *lightColor = [UIColor colorWithRed:49.0/255.0 green:245.0/255.0 blue:85.0/255.0 alpha:1.0f];*/
    UIColor *darkColor = [UIColor colorWithRed:36.0/255.0 green:132.0/255.0 blue:232.0/255.0 alpha:1.0];
    UIColor *lightColor = [UIColor colorWithRed:36.0/255.0 green:132.0/255.0 blue:232.0/255.0 alpha:1.0];
    NSMutableArray *mutableColors = [NSMutableArray arrayWithCapacity:2];
    [mutableColors addObject:(id)lightColor.CGColor];
    [mutableColors addObject:(id)darkColor.CGColor];
    
    layer.colors = mutableColors;
}

-(void) fillBoxByBusinessImage
{
    NSString *logoURLString = [SERVER_HOSTNAME stringByAppendingString:self.userData.business.logo];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.bounds];
    [self addSubview:imageView];
    
    [imageView initialiseTapHandler:^(UIGestureRecognizer *sender) {
        if( [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:logoURLString].size.width > 0 )    {
            TRImageReviewController *imageReviewController = [[TRImageReviewController alloc] initWithImage:logoURLString];
            [AppDelegateInstance() presentModalViewController: [[UINavigationController alloc] initWithRootViewController:imageReviewController] ];
        }
    } forTaps:1];
    
    MIHGradientView *gradientView = [[MIHGradientView alloc] initWithColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.0]
                                                                        to:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5]];
    gradientView.frame = CGRectMake(0, 83.0, self.bounds.size.width, self.bounds.size.height-83.0);
    gradientView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [imageView addSubview:gradientView];
    
    if([[SDImageCache sharedImageCache] imageFromDiskCacheForKey:logoURLString] == nil) {
        [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:[NSURL URLWithString:logoURLString]
                                                              options:SDWebImageDownloaderUseNSURLCache progress:^(NSUInteger receivedSize, long long expectedSize) {
                                                                  //NSLog(@"%i from %i", receivedSize, expectedSize);
                                                              } completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished)
        {
            
            if(image != nil)
            {
                NSLog(@"Business LOGO download");
                
                UIImage *logoImageTest = [image resizedImageWithContentMode:UIViewContentModeScaleAspectFill bounds:CGSizeMake(320, 200) interpolationQuality:kCGInterpolationHigh];
                logoImageTest = [logoImageTest croppedImage:CGRectMake(0, 0, 320, 200)];
                
                [[SDImageCache sharedImageCache] storeImage:logoImageTest forKey:logoURLString toDisk:YES];
                
                imageView.alpha = 0;
                imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
                [imageView setImage:logoImageTest];
                
                [UIView animateWithDuration:0.1 animations:^{
                    imageView.alpha = 1;
                }];
            } else
                NSLog(@"Business LOGO = nil");
        }];
    } else  {
        [imageView setImage:[[SDImageCache sharedImageCache] imageFromDiskCacheForKey:logoURLString]];
    }
}

-(void) showUserLogo
{
    //UIImage *image = [UIImage imageNamed: self.userData.logo];
    NSString *logoURLString = [SERVER_HOSTNAME stringByAppendingString:self.userData.logo];
    
    /*UIImageView *imageView = [[UIImageView alloc] init];
    
    imageView.size = CGSizeMake(117.0, 117.0);
    imageView.frame = CGRectOffset(imageView.frame, 4.0, 49.0);
    imageView.alpha = 0;
    imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    imageView.layer.borderWidth = 1;
    imageView.layer.borderColor = [UIColor whiteColor].CGColor;
    imageView.layer.cornerRadius = CGRectGetHeight(imageView.bounds) / 2;
    imageView.clipsToBounds = YES;
    [imageView setImageWithURL:[NSURL URLWithString:logoURLString] usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [self addSubview:imageView];
    
    [UIView animateWithDuration:0.1 animations:^{
        imageView.alpha = 1;
    }];*/
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.size = CGSizeMake(117.0, 117.0);
    imageView.frame = CGRectOffset(imageView.frame, 4.0, 117.0);
    imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    imageView.layer.borderWidth = 1;
    imageView.layer.borderColor = [UIColor whiteColor].CGColor;
    imageView.layer.cornerRadius = CGRectGetHeight(imageView.bounds) / 2;
    imageView.clipsToBounds = YES;
    [self addSubview:imageView];
    
    [imageView initialiseTapHandler:^(UIGestureRecognizer *sender) {
        if( [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:logoURLString].size.width > 0 )    {
            TRImageReviewController *imageReviewController = [[TRImageReviewController alloc] initWithImage:logoURLString];
            [AppDelegateInstance() presentModalViewController: [[UINavigationController alloc] initWithRootViewController:imageReviewController] ];
        }
    } forTaps:1];
    
    if([[SDImageCache sharedImageCache] imageFromDiskCacheForKey:logoURLString] == nil) {
        [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:[NSURL URLWithString:logoURLString]
                                                              options:SDWebImageDownloaderUseNSURLCache progress:nil
                                                            completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished)
         {
             
             if(image != nil)
             {
                 NSLog(@"User LOGO download");
                 
                 UIImage *logoImageTest = [image resizedImageWithContentMode:UIViewContentModeScaleAspectFill bounds:CGSizeMake(117, 117) interpolationQuality:kCGInterpolationHigh];
                 logoImageTest = [logoImageTest croppedImage:CGRectMake(0, 0, 117, 117)];
                 
                 [[SDImageCache sharedImageCache] storeImage:logoImageTest forKey:logoURLString toDisk:YES];
                 
                 imageView.alpha = 0;
                 //imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
                 [imageView setImage:logoImageTest];
                 
                 [UIView animateWithDuration:0.1 animations:^{
                     imageView.alpha = 1;
                 }];
             } else
                 NSLog(@"User LOGO = nil");
         }];
    } else  {
        [imageView setImage:[[SDImageCache sharedImageCache] imageFromDiskCacheForKey:logoURLString]];
    }
}

-(void) showProfitTitle
{
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.backgroundColor = [UIColor clearColor];
    nameLabel.textColor = [UIColor whiteColor];
    nameLabel.font = [UIFont fontWithName:@"HypatiaSansPro-Regular" size:13];
    nameLabel.numberOfLines = 1;
    nameLabel.lineBreakMode = NSLineBreakByWordWrapping;
    nameLabel.text = [NSString stringWithFormat:@"Доход в месяц: %@ р", self.userData.profit];
    
    nameLabel.layer.shadowColor = [UIColor blackColor].CGColor;
    nameLabel.layer.shadowOffset = CGSizeMake(0, 1);
    nameLabel.layer.shadowRadius = 1;
    nameLabel.layer.shadowOpacity = 0.2f;
    
    CGSize size = [nameLabel.text sizeWithFont:nameLabel.font constrainedToSize:CGSizeMake(175.0, FLT_MAX) lineBreakMode:nameLabel.lineBreakMode ];
    nameLabel.frame = CGRectMake(4.0+117.0+15.0, 200.0 - (0.0+size.height), size.width, size.height);
    //nameLabel.backgroundColor = [UIColor redColor];
    
    [self addSubview: nameLabel];
}

-(void) showFirstAndLastName
{
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.backgroundColor = [UIColor clearColor];
    nameLabel.textColor = [UIColor whiteColor];
    nameLabel.font = [UIFont fontWithName:@"HypatiaSansPro-Bold" size:26];
    nameLabel.numberOfLines = 2;
    nameLabel.lineBreakMode = NSLineBreakByWordWrapping;
    nameLabel.text = [NSString stringWithFormat:@"%@ %@", self.userData.first_name, self.userData.last_name];
    
    nameLabel.layer.shadowColor = [UIColor blackColor].CGColor;
    nameLabel.layer.shadowOffset = CGSizeMake(0, 1);
    nameLabel.layer.shadowRadius = 1;
    nameLabel.layer.shadowOpacity = 0.2f;
    
    CGSize size = [nameLabel.text sizeWithFont:nameLabel.font constrainedToSize:CGSizeMake(175.0, FLT_MAX) lineBreakMode:nameLabel.lineBreakMode ];
    nameLabel.frame = CGRectMake(4.0+117.0+15.0, 200.0 - (18.0+size.height), size.width, size.height);
    //nameLabel.backgroundColor = [UIColor redColor];
    
    [self addSubview: nameLabel];
}

-(void) showYearsAndCity
{
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.backgroundColor = [UIColor clearColor];
    nameLabel.textColor = [UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1.0];
    nameLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:13];
    nameLabel.numberOfLines = 1;
    nameLabel.text = [NSString stringWithFormat:@"%@, %@", self.userData.age, self.userData.city];
    
    CGSize size = [nameLabel.text sizeWithFont:nameLabel.font constrainedToSize:CGSizeMake(175.0, FLT_MAX) lineBreakMode:nameLabel.lineBreakMode ];
    nameLabel.frame = CGRectMake(4.0+117.0+15.0, 200.0+6.0, size.width, size.height);
    
    [self addSubview: nameLabel];
}

@end
