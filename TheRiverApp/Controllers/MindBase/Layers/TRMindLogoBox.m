//
//  TRMindLogoBox.m
//  TheRiverApp
//
//  Created by DenisDbv on 09.09.13.
//  Copyright (c) 2013 axbx. All rights reserved.
//

#import "TRMindLogoBox.h"

@implementation TRMindLogoBox

- (void)setup {
    
    self.backgroundColor = [UIColor whiteColor];
    
    self.leftMargin = self.rightMargin = 10;
    
}

+(TRMindLogoBox *)initBox:(CGSize)bounds withMindData:(TRMindModel *)mindObject
{
    TRMindLogoBox *box = [TRMindLogoBox boxWithSize: CGSizeMake(bounds.width, 210)];
    box.mindData = mindObject;
    
    [box showLogo];
    
    return box;
}

-(void) showLogo
{
    UIImage *image = [UIImage imageNamed: self.mindData.mindLogo];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    
    if(image.size.width > self.bounds.size.width)
        imageView.size = self.bounds.size;
    else
        imageView.frame = CGRectMake((self.bounds.size.width-image.size.width)/2,
                                     0,
                                     image.size.width, image.size.height);
    
    imageView.alpha = 0;
    imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self addSubview:imageView];
    
    [UIView animateWithDuration:0.1 animations:^{
        imageView.alpha = 1;
    }];
}

@end
