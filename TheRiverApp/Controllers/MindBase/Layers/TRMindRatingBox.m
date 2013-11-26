//
//  TRMindRatingBox.m
//  TheRiverApp
//
//  Created by DenisDbv on 09.09.13.
//  Copyright (c) 2013 axbx. All rights reserved.
//

#import "TRMindRatingBox.h"
#import <MGBox2/MGScrollView.h>
#import <MGBox2/MGLineStyled.h>

@interface TRMindRatingBox()
@property (nonatomic, retain) UIView *ratingView;
@end

@implementation TRMindRatingBox

- (void)setup {
    
    self.backgroundColor = [UIColor whiteColor];
    
    self.leftMargin = self.rightMargin = 0;
}

+(TRMindRatingBox *)initBox:(CGSize)bounds withMindData:(TRMindModel *)mindObject
{
    TRMindRatingBox *box = [TRMindRatingBox boxWithSize:CGSizeMake(bounds.width, 40)];
    box.mindData = mindObject;
    box.leftPadding = box.rightPadding = 10;
    
    [box addSubview:[box showRatingView]];
    
    //box.height = box.ratingView.frame.size.height;
    [box refreshRootSize];
    
    return box;
}

-(void) refreshRootSize
{
    MGScrollView *scroll = (MGScrollView*)self.parentBox;
    [scroll layoutWithSpeed:0.3 completion:nil];
}

-(UIView*) showRatingView
{
    _ratingView = [[UIView alloc] init];
    
    /*UIImage *imageStar = [UIImage imageNamed:@"star-icon.png"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:imageStar];
    [_ratingView addSubview:imageView];
    
    UILabel *countRating = [[UILabel alloc] initWithFrame:CGRectZero];
    countRating.text = [NSString stringWithFormat:@"%i", self.mindData.mindRating];
    countRating.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:14];
    countRating.textColor = [UIColor lightGrayColor];
    countRating.backgroundColor = [UIColor clearColor];
    [countRating sizeToFit];
    [_ratingView addSubview: countRating];
    
    countRating.frame = CGRectOffset(countRating.frame, imageView.frame.size.width+4,
                                     (imageView.frame.size.height-countRating.frame.size.height)/2);
    _ratingView.frame = CGRectMake(12, 10, MAX(imageView.frame.size.width, countRating.frame.size.width),
                                  MAX(imageView.frame.size.height, countRating.frame.size.height));*/
    
    return _ratingView;
}

@end
