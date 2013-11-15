//
//  TRBusinessLogoBox.m
//  TheRiverApp
//
//  Created by DenisDbv on 10.09.13.
//  Copyright (c) 2013 axbx. All rights reserved.
//

#import "TRNewsLogoBox.h"

#import "UIImage+Resize.h"
#import <MGBox2/MGScrollView.h>
#import <QuartzCore/QuartzCore.h>
#import "UIImage+Resize.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <UIActivityIndicator-for-SDWebImage/UIImageView+UIActivityIndicatorForSDWebImage.h>
#import <SSToolkit/SSToolkit.h>

@implementation TRNewsLogoBox
{
    SSGradientView *layerView;
}

- (void)setup {
    
    self.backgroundColor = [UIColor whiteColor];
    
    self.leftMargin = self.rightMargin = 10;
    
}

+(TRNewsLogoBox *)initBox:(CGSize)bounds withNewsData:(TRNewsItem *)newsItem
{
    TRNewsLogoBox *box = [TRNewsLogoBox boxWithSize: CGSizeMake(bounds.width, 210)];
    box.newsItem = newsItem;
    
    [box showLogo];
    
    return box;
}

-(void) showLogo
{
    UIImageView *clearPerson = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"rightbar_contact_placeholder_transparent.png"]];
    clearPerson.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    clearPerson.contentMode = UIViewContentModeCenter;
    clearPerson.center = self.center;
    clearPerson.hidden = YES;
    [self addSubview: clearPerson];
    
    __block UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.bounds];
    imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self addSubview:imageView];
    
    if(self.newsItem.logo.length != 0) {
        NSString *logoURLString = [SERVER_HOSTNAME stringByAppendingString:self.newsItem.logo];
        
        [imageView setImageWithURL:[NSURL URLWithString:logoURLString] placeholderImage:[UIImage new] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
            if(image != nil)
            {
                /*UIImage *logoImageTest = [image resizedImageWithContentMode:UIViewContentModeScaleAspectFill bounds:CGSizeMake(self.bounds.size.width, self.bounds.size.height) interpolationQuality:kCGInterpolationHigh];
                logoImageTest = [logoImageTest croppedImage:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
                [imageView setImage:logoImageTest];
                
                [self refreshRootSize];*/
            } else  {
                clearPerson.hidden = NO;
            }
        } usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    } else  {
        clearPerson.hidden = NO;
    }
}

-(void) refreshRootSize
{
    MGScrollView *scroll = (MGScrollView*)self.parentBox;
    [scroll layoutWithSpeed:0.1 completion:nil];
}

@end
