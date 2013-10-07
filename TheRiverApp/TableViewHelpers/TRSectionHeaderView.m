//
//  TRSectionHeaderView.m
//  TheRiverApp
//
//  Created by DenisDbv on 02.09.13.
//  Copyright (c) 2013 axbx. All rights reserved.
//

#import "TRSectionHeaderView.h"
#import <QuartzCore/QuartzCore.h>

#import "UIView+GestureBlocks.h"

@interface TRSectionHeaderView ()
@property (nonatomic, strong) UILabel * label;
@property (nonatomic, strong) UILabel * buttonLabel;
@end

@implementation TRSectionHeaderView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initialize];
    }
    return self;
}

-(id) initWithFrame:(CGRect)frame
          withTitle:(NSString*)title
    withButtonTitle:(NSString*)btnTitle
            byBlock:(void (^)(void))onClick
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initialize];
        
        [self setTitle:title];
        
        self.buttonLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [self.buttonLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:12]];
        [self.buttonLabel setBackgroundColor:[UIColor clearColor]];
        [self.buttonLabel setTextColor:[UIColor colorWithRed:203.0/255.0
                                                 green:206.0/255.0
                                                  blue:209.0/255.0
                                                 alpha:1.0]];
        [self.buttonLabel setShadowOffset:CGSizeMake(0, 1)];
        [self.buttonLabel setShadowColor:[[UIColor blackColor] colorWithAlphaComponent:.5]];
        [self.buttonLabel setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
        [self.buttonLabel setText:btnTitle];
        [self.buttonLabel sizeToFit];
        self.buttonLabel.frame = CGRectMake(self.bounds.size.width-self.buttonLabel.frame.size.width-10.0, 0, self.buttonLabel.frame.size.width, self.bounds.size.height);
        [self.buttonLabel initialiseTapHandler:^(UIGestureRecognizer *sender) {
            onClick();
        } forTaps:1];
        [self addSubview:self.buttonLabel];
        [self setClipsToBounds:NO];
    }
    return self;
}

-(void) initialize
{
    [self setBackgroundColor:[UIColor colorWithRed:230.0/255.0
                                             green:230.0/255.0
                                              blue:230.0/255.0
                                             alpha:1.0]];
    /*[self setBackgroundColor:[UIColor colorWithRed:77.0/255.0
                                             green:79.0/255.0
                                              blue:80.0/255.0
                                             alpha:1.0]];*/
    
    _label = [[UILabel alloc] initWithFrame:CGRectInset(self.bounds, 10.0, 2.0)];
    [self.label setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:12]];
    [self.label setBackgroundColor:[UIColor clearColor]];
    [self.label setTextColor:[UIColor colorWithRed:102.0/255.0
                                             green:102.0/255.0
                                              blue:102.0/255.0
                                             alpha:1.0]];
    //[self.label setShadowOffset:CGSizeMake(0, 1)];
    //[self.label setShadowColor:[[UIColor blackColor] colorWithAlphaComponent:.5]];
    [self.label setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    [self addSubview:self.label];
    [self setClipsToBounds:NO];
}

-(void)setTitle:(NSString *)title{
    _title = title;
    [self.label setText:self.title];
}

/*-(void)drawRect:(CGRect)rect{
    //// General Declarations
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //// Color Declarations
    UIColor* color = [UIColor colorWithRed: 0.373 green: 0.388 blue: 0.404 alpha: 1];
    UIColor* color2 = [UIColor colorWithRed: 0.216 green: 0.231 blue: 0.243 alpha: 1];
    UIColor* color3 = [UIColor colorWithRed: 0.451 green: 0.463 blue: 0.475 alpha: 1];
    UIColor* color4 = [UIColor colorWithRed: 0.184 green: 0.2 blue: 0.212 alpha: 1];
    UIColor* fillColor2 = [UIColor colorWithRed: 0.373 green: 0.388 blue: 0.404 alpha: 0];
    
    //// Gradient Declarations
    NSArray* gradient2Colors = [NSArray arrayWithObjects:
                                (id)color.CGColor,
                                (id)fillColor2.CGColor, nil];
    CGFloat gradient2Locations[] = {0, 1};
    CGGradientRef gradient2 = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)gradient2Colors, gradient2Locations);
    
    //// Frames
    CGRect frame = CGRectMake(0, -1, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds)+1);
    
    
    //// Fill Drawing
    CGRect fillRect = CGRectMake(CGRectGetMinX(frame), CGRectGetMinY(frame), CGRectGetWidth(frame), CGRectGetHeight(frame) - 1);
    UIBezierPath* fillPath = [UIBezierPath bezierPathWithRect: fillRect];
    CGContextSaveGState(context);
    [fillPath addClip];
    CGContextDrawLinearGradient(context, gradient2,
                                CGPointMake(CGRectGetMidX(fillRect), CGRectGetMinY(fillRect)),
                                CGPointMake(CGRectGetMidX(fillRect), CGRectGetMaxY(fillRect)),
                                0);
    CGContextRestoreGState(context);
    
    
    //// TopStroke Drawing
    UIBezierPath* topStrokePath = [UIBezierPath bezierPathWithRect: CGRectMake(CGRectGetMinX(frame), CGRectGetMinY(frame), CGRectGetWidth(frame), 1)];
    [color4 setFill];
    [topStrokePath fill];
    
    
    //// Highlight Drawing
    UIBezierPath* highlightPath = [UIBezierPath bezierPathWithRect: CGRectMake(CGRectGetMinX(frame), CGRectGetMinY(frame) + 1, CGRectGetWidth(frame), 1)];
    [color3 setFill];
    [highlightPath fill];
    
    
    //// BottomStroke Drawing
    UIBezierPath* bottomStrokePath = [UIBezierPath bezierPathWithRect: CGRectMake(CGRectGetMinX(frame), CGRectGetMinY(frame) + CGRectGetHeight(frame) - 1, CGRectGetWidth(frame), 1)];
    [color2 setFill];
    [bottomStrokePath fill];
    
    
    //// Cleanup
    CGGradientRelease(gradient2);
    CGColorSpaceRelease(colorSpace);
}*/

@end
