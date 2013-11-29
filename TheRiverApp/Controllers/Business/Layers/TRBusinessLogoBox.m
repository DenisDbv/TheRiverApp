//
//  TRBusinessLogoBox.m
//  TheRiverApp
//
//  Created by DenisDbv on 10.09.13.
//  Copyright (c) 2013 axbx. All rights reserved.
//

#import "TRBusinessLogoBox.h"
#import "UIImage+Resize.h"
#import <MGBox2/MGScrollView.h>
#import <QuartzCore/QuartzCore.h>
#import "UIImage+Resize.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <UIActivityIndicator-for-SDWebImage/UIImageView+UIActivityIndicatorForSDWebImage.h>
#import <SSToolkit/SSToolkit.h>

@implementation TRBusinessLogoBox
{
    SSGradientView *layerView;
}

- (void)setup {
    
    self.backgroundColor = [UIColor whiteColor];
    
    self.leftMargin = self.rightMargin = 10;
    
}

+(TRBusinessLogoBox *)initBox:(CGSize)bounds withMindData:(TRBusinessModel *)businessObject
{
    TRBusinessLogoBox *box = [TRBusinessLogoBox boxWithSize: CGSizeMake(bounds.width, 210)];
    box.businessData = businessObject;
    
    [box showLogo];
    
    return box;
}

/*-(void) layoutSubviews
{
    [super layoutSubviews];
    
    layerView.bottomColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    layerView.topColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    [layerView layoutSubviews];
}*/

-(void) showLogo
{
    /*layerView = [[SSGradientView alloc] initWithFrame:self.bounds];
    layerView.backgroundColor = [UIColor clearColor];
    layerView.hidden = YES;
    [self addSubview:layerView];*/
    
    UIImageView *clearPerson = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"business_logo.png"]];
    clearPerson.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    clearPerson.contentMode = UIViewContentModeCenter;
    clearPerson.center = self.center;
    clearPerson.hidden = YES;
    [self addSubview: clearPerson];
    
    __block UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.bounds];
    imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self addSubview:imageView];
    
    if(self.businessData.logo_desc.length != 0) {
        NSString *logoURLString = [SERVER_HOSTNAME stringByAppendingString:self.businessData.logo_desc];
        
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
