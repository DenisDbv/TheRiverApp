//
//  TRPhotoBox.m
//  TheRiverApp
//
//  Created by DenisDbv on 03.09.13.
//  Copyright (c) 2013 axbx. All rights reserved.
//

#import "TRPhotoBox.h"

@implementation TRPhotoBox

- (void)setup {
    
    self.topMargin = 134;
    self.leftMargin = 10;
    // background
    self.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.95 alpha:1];
    
    // shadow
    self.layer.shadowColor = [UIColor colorWithWhite:0.12 alpha:1].CGColor;
    self.layer.shadowOffset = CGSizeMake(0, 0.5);
    self.layer.shadowRadius = 1;
    self.layer.shadowOpacity = 1;
    //self.layer.rasterizationScale = 1.0;
    //self.layer.shouldRasterize = YES;
}

+(TRPhotoBox *)initBox
{
    TRPhotoBox *box = [TRPhotoBox boxWithSize: CGSizeMake(106, 106)];
    
    [box loadPhoto];
    
    return box; 
}

-(void) loadPhoto
{
    UIImage *image = [UIImage imageNamed:@"IamAppleDev.jpg"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    [self addSubview:imageView];
    
    imageView.frame = CGRectMake(3, 3, 100, 100);
    imageView.alpha = 0;
    imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth
    | UIViewAutoresizingFlexibleHeight;
    
    // fade the image in
    [UIView animateWithDuration:0.1 animations:^{
        imageView.alpha = 1;
    }];
}

@end
