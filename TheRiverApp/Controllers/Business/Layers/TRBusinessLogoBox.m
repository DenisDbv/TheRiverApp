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
    UIImage *image = [[UIImage imageNamed: self.businessData.businessLogo] resizedImageWithContentMode:UIViewContentModeScaleAspectFit bounds:self.bounds.size interpolationQuality:kCGInterpolationHigh];

    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    
    //imageView.size = self.bounds.size;
    imageView.alpha = 0;
    //imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self addSubview:imageView];
    
    [UIView animateWithDuration:0.1 animations:^{
        imageView.alpha = 1;
    }];
    
    self.height = image.size.height;
    [self refreshRootSize];
}

-(void) refreshRootSize
{
    MGScrollView *scroll = (MGScrollView*)self.parentBox;
    [scroll layoutWithSpeed:0.1 completion:nil];
}

@end
