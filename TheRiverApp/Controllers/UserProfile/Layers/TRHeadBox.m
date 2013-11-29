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
#import "UIImage+UIImageFunctions.h"

@interface TRHeadBox()
@property (nonatomic, assign) BOOL isTheGameUser;
@property (nonatomic, strong) UIImageView *theGameImage2;
@end

@implementation TRHeadBox

+ (Class)layerClass {
    return [CAGradientLayer class];
}

- (void)setup
{
    self.backgroundColor = [UIColor whiteColor];
}

+(TRHeadBox *)initBox:(CGSize)bounds withUserData:(TRUserInfoModel *)userObject
{
    TRHeadBox *box = [TRHeadBox boxWithSize: CGSizeMake(bounds.width, 200)];
    box.userData = userObject;
    
    if(box.userData.contact_data.thegame.length == 0)
        box.isTheGameUser = NO;
    else
        box.isTheGameUser = YES;
    
    [box fillBoxByColorGradient];
    [box fillBoxByBusinessImage];
    [box showUserLogo];
    [box showProfitTitle];
    [box showFirstAndLastName];
    [box showYearsAndCity];
    
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
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.bounds];
    imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self addSubview:imageView];
    
    if(!self.isTheGameUser) {
        MIHGradientView *gradientView = [[MIHGradientView alloc] initWithColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.0]
                                                                            to:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5]];
        gradientView.frame = CGRectMake(0, 83.0, self.bounds.size.width, self.bounds.size.height-83.0);
        gradientView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [imageView addSubview:gradientView];
    } else  {
        MIHGradientView *gradientView = [[MIHGradientView alloc] initWithColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5]
                                                                            to:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5]];
        
        NSInteger height = 0;
        if([self getSizeFIOLabel].height > 40)  {
            height = 105;
        } else  {
            height = 87;
        }
        
        gradientView.frame = CGRectMake(0, self.bounds.size.height - height, self.bounds.size.width, height);
        //gradientView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [imageView addSubview:gradientView];
    }
    
    if(self.userData.business.logo_profile.length > 0)   {
        
        NSString *logoURLString = [SERVER_HOSTNAME stringByAppendingString:self.userData.business.logo_profile];
        
        [imageView initialiseTapHandler:^(UIGestureRecognizer *sender) {
            if( [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:logoURLString].size.width > 0 )    {
                NSString *fullLogoURLString = [SERVER_HOSTNAME stringByAppendingString:self.userData.business.logo];
                [AppDelegateInstance() setStatusBarHide:YES];
                TRImageReviewController *imageReviewController = [[TRImageReviewController alloc] initWithImage:fullLogoURLString];
                [AppDelegateInstance() presentModalViewController: imageReviewController];
            }
        } forTaps:1];
        
        UIImage *img = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:logoURLString];
        if(img == nil) {
            [imageView setImageWithURL:[NSURL URLWithString:logoURLString] placeholderImage:[UIImage new]
                             completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
                                 [[SDImageCache sharedImageCache] storeImage:image forKey:logoURLString toDisk:YES];
                             } usingActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        } else  {
            [imageView setImage: img];
        }
    } else  {
        [imageView setImage:[UIImage new]];
    }
}

-(void) showUserLogo
{
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.size = CGSizeMake(117.0, 117.0);
    imageView.frame = CGRectOffset(imageView.frame, 4.0, 117.0);
    imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    imageView.layer.borderWidth = 1;
    imageView.layer.borderColor = [UIColor whiteColor].CGColor;
    imageView.layer.cornerRadius = CGRectGetHeight(imageView.bounds) / 2;
    imageView.clipsToBounds = YES;
    [self addSubview:imageView];
    
    if(self.userData.logo_profile.length > 0)   {
        NSString *logoURLString = [SERVER_HOSTNAME stringByAppendingString:self.userData.logo_profile];
        
        [imageView initialiseTapHandler:^(UIGestureRecognizer *sender) {
            if( [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:logoURLString].size.width > 0 )    {
                NSString *fullLogoURLString = [SERVER_HOSTNAME stringByAppendingString:self.userData.logo];
                [AppDelegateInstance() setStatusBarHide:YES];
                TRImageReviewController *imageReviewController = [[TRImageReviewController alloc] initWithImage:fullLogoURLString];
                [AppDelegateInstance() presentModalViewController: imageReviewController ];
            }
        } forTaps:1];
        
        UIImage *img = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:logoURLString];
        if(img == nil) {
            [imageView setImageWithURL:[NSURL URLWithString:logoURLString] placeholderImage:[UIImage new]
                                  completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
                                      [[SDImageCache sharedImageCache] storeImage:image forKey:logoURLString toDisk:YES];
                                  } usingActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        } else  {
            [imageView setImage: img];
        }
    } else  {
        [imageView setImage:[UIImage new]];
    }
}

-(void) showProfitTitle
{
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.backgroundColor = [UIColor clearColor];
    nameLabel.textColor = [UIColor colorWithRed:112.0/255.0 green:112.0/255.0 blue:112.0/255.0 alpha:1.0];
    nameLabel.font = [UIFont fontWithName:@"HypatiaSansPro-Regular" size:13];
    nameLabel.numberOfLines = 1;
    nameLabel.text = [NSString stringWithFormat:@"Доход в месяц: %@ р", self.userData.profit];
    
    CGSize size = [nameLabel.text sizeWithFont:[UIFont fontWithName:@"HypatiaSansPro-Regular" size:13] constrainedToSize:CGSizeMake(200.0, FLT_MAX) lineBreakMode:nameLabel.lineBreakMode ];
    nameLabel.frame = CGRectMake(4.0+117.0+15.0, 200.0 + 7.0, size.width, size.height);
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
    nameLabel.frame = CGRectMake(4.0+117.0+15.0, 200.0 - (size.height), size.width, size.height);
    //nameLabel.backgroundColor = [UIColor redColor];
    //NSLog(@"%@", NSStringFromCGSize(size));
    [self addSubview: nameLabel];
    
    if(self.isTheGameUser)  {
        UIImageView *theGameImage = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"thegame_1.png"] scaleProportionalToRetina] ];
        [self addSubview:theGameImage];
        
        theGameImage.frame = CGRectMake(nameLabel.frame.origin.x - 9,
                                        nameLabel.frame.origin.y - 8 - theGameImage.frame.size.height,
                                        theGameImage.frame.size.width, theGameImage.frame.size.height);
        
        self.theGameImage2 = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"thegame_2.png"] scaleProportionalToRetina] ];
        [self addSubview:self.theGameImage2];
        self.theGameImage2.frame = CGRectMake(theGameImage.frame.origin.x+88,
                                             theGameImage.frame.origin.y + 7.5,
                                              self.theGameImage2.frame.size.width, self.theGameImage2.frame.size.height);
        
        [theGameImage initialiseTapHandler:^(UIGestureRecognizer *sender) {
            [self openTheGameURL];
        } forTaps:1];
        
        [nameLabel initialiseTapHandler:^(UIGestureRecognizer *sender) {
            [self openTheGameURL];
        } forTaps:1];
    }
}

-(void) animateTheGameIcon
{
    [UIView animateWithDuration:0.3
                          delay:0.2
                        options:UIViewAnimationOptionBeginFromCurrentState
                     animations:(void (^)(void)) ^{
                         self.theGameImage2.transform=CGAffineTransformMakeScale(1.3, 1.3);
                     }
                     completion:^(BOOL finished){
                         [UIView animateWithDuration:0.1
                                               delay:0
                                             options:UIViewAnimationOptionBeginFromCurrentState
                                          animations:(void (^)(void)) ^{
                                              self.theGameImage2.transform=CGAffineTransformMakeScale(1.0, 1.0);
                                          }
                                          completion:^(BOOL finished){
                                              [UIView animateWithDuration:0.3
                                                                    delay:0
                                                                  options:UIViewAnimationOptionBeginFromCurrentState
                                                               animations:(void (^)(void)) ^{
                                                                   self.theGameImage2.transform=CGAffineTransformMakeScale(1.3, 1.3);
                                                               }
                                                               completion:^(BOOL finished){
                                                                   self.theGameImage2.transform=CGAffineTransformIdentity;
                                                               }];
                                          }];
                     }];
}

-(void) openTheGameURL
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.userData.contact_data.thegame]];
}

-(CGSize) getSizeFIOLabel
{
    return [[NSString stringWithFormat:@"%@ %@", self.userData.first_name, self.userData.last_name] sizeWithFont:[UIFont fontWithName:@"HypatiaSansPro-Bold" size:26]
                             constrainedToSize:CGSizeMake(175.0, FLT_MAX)
                                 lineBreakMode:NSLineBreakByWordWrapping ];
}

-(void) showYearsAndCity
{
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.backgroundColor = [UIColor clearColor];
    nameLabel.textColor = [UIColor colorWithRed:112.0/255.0 green:112.0/255.0 blue:112.0/255.0 alpha:1.0]; //[UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1.0];
    nameLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:13];
    nameLabel.numberOfLines = 1;
    nameLabel.text = [NSString stringWithFormat:@"%@ %@, %@", self.userData.age, [self getStringYearByAge:[self.userData.age integerValue]], self.userData.city];
    
    CGSize size = [nameLabel.text sizeWithFont:nameLabel.font constrainedToSize:CGSizeMake(175.0, FLT_MAX) lineBreakMode:nameLabel.lineBreakMode ];
    nameLabel.frame = CGRectMake(4.0+117.0+15.0, 200.0+24.0, size.width, size.height);
    
    [self addSubview: nameLabel];
}

-(NSString*) getStringYearByAge:(NSInteger)age
{
    NSInteger lastDigit = age % 10;
    
    //NSLog(@"==>%i", lastDigit);
    
    if( lastDigit == 1 )
        return @"год";
    else if( lastDigit > 1 && lastDigit <= 4 )
        return @"года";
    else if( (lastDigit >= 5 && lastDigit <= 9) || lastDigit == 0 )
        return @"лет";

    return @"";
}

@end
