//
//  TRMindLogoBox.m
//  TheRiverApp
//
//  Created by DenisDbv on 09.09.13.
//  Copyright (c) 2013 axbx. All rights reserved.
//

#import "TRMindLogoBox.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <UIActivityIndicator-for-SDWebImage/UIImageView+UIActivityIndicatorForSDWebImage.h>
#import <SSToolkit/SSToolkit.h>

@implementation TRMindLogoBox

- (void)setup {
    
    self.backgroundColor = [UIColor whiteColor];
    
    self.leftMargin = self.rightMargin = 10;
    
}

+(TRMindLogoBox *)initBox:(CGSize)bounds withMindData:(TRMindItem *)mindObject
{
    TRMindLogoBox *box = [TRMindLogoBox boxWithSize: CGSizeMake(bounds.width, 210)];
    box.mindData = mindObject;
    
    [box showLogo];
    
    return box;
}

-(void) showLogo
{
    UIImageView *clearPerson = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"rightbar_contact_placeholder_transparent.png"]];
    clearPerson.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    clearPerson.contentMode = UIViewContentModeCenter;
    clearPerson.center = self.center;
    clearPerson.hidden = YES;
    [self addSubview: clearPerson];
    
    __block UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.bounds];
    imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self addSubview:imageView];
    
    if(self.mindData.logo.length != 0) {
        NSString *logoURLString = [SERVER_HOSTNAME stringByAppendingString:self.mindData.logo];
        
        [imageView setImageWithURL:[NSURL URLWithString:logoURLString] placeholderImage:[UIImage new] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
            if(image != nil)
            {
                /*UIImage *logoImageTest = [image resizedImageWithContentMode:UIViewContentModeScaleAspectFill bounds:CGSizeMake(self.bounds.size.width, self.bounds.size.height) interpolationQuality:kCGInterpolationHigh];
                 logoImageTest = [logoImageTest croppedImage:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
                 [imageView setImage:logoImageTest];
                 
                 [self refreshRootSize];*/
            } else  {
                clearPerson.hidden = NO;
            }
        } usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    } else  {
        clearPerson.hidden = NO;
    }}

@end
