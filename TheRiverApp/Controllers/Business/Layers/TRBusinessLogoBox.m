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
#import <SDWebImage/UIImageView+WebCache.h>
#import <UIActivityIndicator-for-SDWebImage/UIImageView+UIActivityIndicatorForSDWebImage.h>

@implementation TRBusinessLogoBox

- (void)setup {
    
    self.backgroundColor = [UIColor clearColor];
    
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
    //UIImage *image = nil;//[[UIImage imageNamed: self.businessData.businessLogo] resizedImageWithContentMode:UIViewContentModeScaleAspectFit bounds:self.bounds.size interpolationQuality:kCGInterpolationHigh];

    UIImageView *imageView = [[UIImageView alloc] init];
    
    if(self.businessData.logo.length != 0) {
        NSString *logoURLString = [SERVER_HOSTNAME stringByAppendingString:self.businessData.logo];
        [imageView setImageWithURL:[NSURL URLWithString:logoURLString] placeholderImage:[UIImage imageNamed:@"avatar_placeholder.png"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
            imageView.size = self.bounds.size;
            imageView.alpha = 0;
            imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
            [self addSubview:imageView];
            
            [UIView animateWithDuration:0.1 animations:^{
                imageView.alpha = 1;
            }];
            
            NSLog(@"%@", NSStringFromCGSize(image.size));
            
            self.height = image.size.height;
            [self refreshRootSize];
        } usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    }
}

-(void) refreshRootSize
{
    MGScrollView *scroll = (MGScrollView*)self.parentBox;
    [scroll layoutWithSpeed:0.1 completion:nil];
}

@end
