//
//  TRAuthPhotoBox.m
//  TheRiverApp
//
//  Created by DenisDbv on 18.11.13.
//  Copyright (c) 2013 axbx. All rights reserved.
//

#import "TRAuthPhotoBox.h"

@interface TRAuthPhotoBox()
@property (nonatomic, strong) UIImageView *addView;
@end

@implementation TRAuthPhotoBox

- (void)setup
{
    self.margin = UIEdgeInsetsMake(0, 0, 0, 0);
    self.padding = UIEdgeInsetsMake(1, 1, 1, 1);
    self.borderStyle = MGBorderNone;
}

+ (TRAuthPhotoBox *)photoAddBoxWithFileName:(NSString*)fileName andTag:(NSInteger)tag
{
    TRAuthPhotoBox *box = [TRAuthPhotoBox boxWithSize:CGSizeMake(54.0, 58.0)];
    
    box.backgroundColor = [UIColor whiteColor];//colorWithRed:0.74 green:0.74 blue:0.75 alpha:1];
    box.tag = tag;
    box.photoName = fileName;
    
    UIImage *add = [UIImage imageNamed: fileName];
    box.addView = [[UIImageView alloc] initWithImage:add];
    box.addView.frame = box.bounds;
    [box addSubview:box.addView];
    
    box.addView.center = (CGPoint){box.width / 2, box.height / 2};
    box.addView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin
    | UIViewAutoresizingFlexibleRightMargin
    | UIViewAutoresizingFlexibleBottomMargin
    | UIViewAutoresizingFlexibleLeftMargin;

    return box;
}

-(void) changePhotoTo:(NSString*)fileName
{
    [UIView animateWithDuration:0.2 animations:^{
        self.addView.alpha = 0;
    } completion:^(BOOL finished) {
        [self.addView setImage:[UIImage imageNamed:fileName]];
        self.photoName = fileName;
        [UIView animateWithDuration:0.3 animations:^{
            self.addView.alpha = 1;
        }];
    }];
}

@end
