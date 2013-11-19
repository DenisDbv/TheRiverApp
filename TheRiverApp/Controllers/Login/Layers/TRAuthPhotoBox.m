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
    
    box.backgroundColor = [UIColor colorWithRed:0.74 green:0.74 blue:0.75 alpha:1];
    box.tag = tag;
    
    UIImage *add = [UIImage imageNamed: fileName];
    box.addView = [[UIImageView alloc] initWithImage:add];
    box.addView.frame = box.bounds;
    [box addSubview:box.addView];
    
    box.addView.center = (CGPoint){box.width / 2, box.height / 2};
    box.addView.alpha = 1.0;
    box.addView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin
    | UIViewAutoresizingFlexibleRightMargin
    | UIViewAutoresizingFlexibleBottomMargin
    | UIViewAutoresizingFlexibleLeftMargin;

    return box;
}

-(void) show
{
    _addView.alpha = 1.0;
}

@end
