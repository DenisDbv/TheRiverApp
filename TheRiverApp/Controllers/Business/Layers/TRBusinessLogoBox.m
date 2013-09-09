//
//  TRBusinessLogoBox.m
//  TheRiverApp
//
//  Created by DenisDbv on 10.09.13.
//  Copyright (c) 2013 axbx. All rights reserved.
//

#import "TRBusinessLogoBox.h"

@implementation TRBusinessLogoBox

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

-(void) showLogo
{
    UIImage *image = [UIImage imageNamed: self.businessData.businessLogo];
    
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
