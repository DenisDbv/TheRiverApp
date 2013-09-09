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
    
    imageView.size = self.bounds.size;
    imageView.alpha = 0;
    imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self addSubview:imageView];
    
    [UIView animateWithDuration:0.1 animations:^{
        imageView.alpha = 1;
    }];
}

@end
