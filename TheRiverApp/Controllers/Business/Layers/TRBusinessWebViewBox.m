//
//  TRBusinessWebViewBox.m
//  TheRiverApp
//
//  Created by DenisDbv on 10.09.13.
//  Copyright (c) 2013 axbx. All rights reserved.
//

#import "TRBusinessWebViewBox.h"

#import <SSToolkit/SSToolkit.h>
#import <MGBox2/MGScrollView.h>
#import "TRMindRatingBox.h"

#import "WDActivityIndicator.h"

@interface TRBusinessWebViewBox()
@property (nonatomic, retain) SSWebView *webView;
@property (nonatomic, retain) WDActivityIndicator *activityIndicator;
@end

@implementation TRBusinessWebViewBox

- (void)setup {
    
    self.backgroundColor = [UIColor whiteColor];
    
    self.leftMargin = self.rightMargin = 0;
    
    //self.topBorderColor = [UIColor colorWithRed:206.0/255.0 green:206.0/255.0 blue:206.0/255.0 alpha:1.0];
}

+(TRBusinessWebViewBox *)initBox:(CGSize)bounds withMindData:(TRBusinessModel *)businessObject
{
    TRBusinessWebViewBox *box = [TRBusinessWebViewBox boxWithSize: CGSizeMake(bounds.width, 100)];
    box.businessData = businessObject;
    //box.backgroundColor = [UIColor redColor];
    
    box.webView = [[SSWebView alloc] initWithFrame:CGRectMake(0, 0, bounds.width, 1)];
    [box addSubview: box.webView];
    
    box.webView.alpha = 0.0f;
    box.webView.scrollView.scrollEnabled = NO;
    box.webView.delegate = box;
    box.webView.scalesPageToFit = NO;
    box.webView.backgroundColor = [UIColor clearColor];
    box.webView.scrollView.backgroundColor = [UIColor clearColor];
    //[box.webView loadURLString:box.businessData.businessURL];
    
    box.activityIndicator = [[WDActivityIndicator alloc] initWithFrame:CGRectMake(box.bounds.size.width/2-21/2, box.bounds.size.height/2-21/2, 0, 0)];
    [box.activityIndicator setIndicatorStyle:WDActivityIndicatorStyleGradient];
    [box.activityIndicator startAnimating];
    [box addSubview:box.activityIndicator];
    
    return box;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    if(self.webView.loading == NO)  {
        [self.activityIndicator stopAnimating];
        
        NSInteger webContentHeight = self.webView.scrollView.contentSize.height;
        
        self.height = webContentHeight;
        self.webView.size = CGSizeMake(self.webView.bounds.size.width, self.height-1);
        [self refreshRootSize];
        
        [UIView animateWithDuration:0.3 animations:^{
            self.webView.alpha = 1.0f;
        } completion:^(BOOL finished) {
            //self.borderStyle = MGBorderEtchedBottom;
            //[self showMindRating];
        }];
    }
}

-(void) refreshRootSize
{
    MGScrollView *scroll = (MGScrollView*)self.parentBox;
    [scroll layoutWithSpeed:0.3 completion:nil];
}

-(void) showMindRating
{
    MGScrollView *scroll = (MGScrollView*)self.parentBox;
    TRMindRatingBox *ratingBox = (TRMindRatingBox*)[TRMindRatingBox initBox: CGSizeMake(320, 0)
                                                               withMindData: self.businessData];
    [scroll.boxes addObject: ratingBox];
    [scroll layoutWithSpeed:0.3 completion:nil];
}
@end
