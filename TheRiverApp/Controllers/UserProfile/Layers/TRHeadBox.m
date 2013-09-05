//
//  TRHeadBox.m
//  TheRiverApp
//
//  Created by DenisDbv on 03.09.13.
//  Copyright (c) 2013 axbx. All rights reserved.
//

#import "TRHeadBox.h"
#import "TRPhotoBox.h"
#import <MGBox2/MGScrollView.h>

@implementation TRHeadBox

- (void)setup {

    // background
    self.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.95 alpha:1];
    
    // shadow
    /*self.layer.shadowColor = [UIColor colorWithWhite:0.12 alpha:1].CGColor;
    self.layer.shadowOffset = CGSizeMake(0, 0.5);
    self.layer.shadowRadius = 1;
    self.layer.shadowOpacity = 1;
    self.layer.rasterizationScale = 1.0;
    self.layer.shouldRasterize = YES;*/
}

+(TRHeadBox *)initBox:(CGSize)bounds
{
    TRHeadBox *box = [TRHeadBox boxWithSize: CGSizeMake(bounds.width, 250)];
    
    [box loadPhoto];
    /*__weak id wbox = box;
    box.asyncLayoutOnce = ^{
        [wbox loadPhoto];
    };*/
    
    TRPhotoBox *photoBox = [TRPhotoBox initBox];
    [box.boxes addObject:photoBox];
    
    return box;
}

-(void) loadPhoto
{
    UIImage *image = [UIImage imageNamed:@"green.png"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    [self addSubview:imageView];
    
    imageView.size = self.size;
    imageView.alpha = 0;
    imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth
    | UIViewAutoresizingFlexibleHeight;
    
    // fade the image in
    [UIView animateWithDuration:0.1 animations:^{
        imageView.alpha = 1;
    }];
}

@end
