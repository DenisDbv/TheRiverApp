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

@implementation TRBusinessLogoBox

- (void)setup {
    
    self.backgroundColor = [UIColor redColor];
    
    self.leftMargin = self.rightMargin = 10;
    
}

+(TRBusinessLogoBox *)initBox:(CGSize)bounds withMindData:(TRBusinessModel *)businessObject
{
    TRBusinessLogoBox *box = [TRBusinessLogoBox boxWithSize: CGSizeMake(bounds.width, 210)];
    box.businessData = businessObject;
    
    [box showLogo];
    
    return box;
}

-(void) showLogo
{
    __block UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.bounds];
    imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self addSubview:imageView];
    
    if(self.businessData.logo.length != 0) {
        NSString *logoURLString = [SERVER_HOSTNAME stringByAppendingString:self.businessData.logo];
        
        [imageView setImageWithURL:[NSURL URLWithString:logoURLString] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
            if(image != nil)
            {
                UIImage *logoImageTest = [image resizedImageWithContentMode:UIViewContentModeScaleAspectFill bounds:CGSizeMake(self.bounds.size.width, self.bounds.size.height) interpolationQuality:kCGInterpolationHigh];
                logoImageTest = [logoImageTest croppedImage:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
                [imageView setImage:logoImageTest];
                
                [self refreshRootSize];
            }
        } usingActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    }
}

-(void) refreshRootSize
{
    MGScrollView *scroll = (MGScrollView*)self.parentBox;
    [scroll layoutWithSpeed:0.1 completion:nil];
}

@end
