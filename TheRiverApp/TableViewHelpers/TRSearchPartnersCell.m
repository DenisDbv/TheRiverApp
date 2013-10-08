//
//  TRSearchPartnersCell.m
//  TheRiverApp
//
//  Created by DenisDbv on 28.09.13.
//  Copyright (c) 2013 axbx. All rights reserved.
//

#import "TRSearchPartnersCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <UIActivityIndicator-for-SDWebImage/UIImageView+UIActivityIndicatorForSDWebImage.h>
#import "UIImage+Resize.h"

@implementation TRSearchPartnersCell
{
    NSInteger centerY;
}
@synthesize avatarImageView, fioLabel, subTextLabel, typeSubTextLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initialized];
    }
    return self;
}

-(void)awakeFromNib
{
    [self initialized];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void) initialized
{
    fioLabel.font = [UIFont fontWithName:@"HypatiaSansPro-Regular" size:17];
    subTextLabel.font = [UIFont fontWithName:@"HypatiaSansPro-Regular" size:15];
    typeSubTextLabel.font = [UIFont fontWithName:@"HypatiaSansPro-Regular" size:15];
    typeSubTextLabel.textColor = [UIColor grayColor];
    
    centerY = (self.frame.size.height - 17)/2;
}

-(void) layoutSubviews
{
    [super layoutSubviews];
    
    NSInteger xOffset = 0;
    
    if(IS_OS_7_OR_LATER)
        xOffset = -20;
    
    self.imageView.frame = CGRectMake(self.imageView.frame.origin.x+xOffset,
                                      self.imageView.frame.origin.y,
                                      self.imageView.frame.size.width,
                                      self.imageView.frame.size.height);
}

-(void) reloadWithData:(NSString*)image
               fioText:(NSString*)fioText
               subText:(NSString*)subText
           typeSubText:(PartnersFilterType)filterType
             withQuery:(NSString*)query
{
    [self.imageView setImage:[UIImage imageNamed:@"avatar_placeholder.png"]];
    
    [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:[NSURL URLWithString:image]
                                                          options:SDWebImageDownloaderUseNSURLCache progress:nil
                                                        completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished)
     {
         
         if(image != nil)
         {
             UIImage *logoImageTest = [image resizedImageWithContentMode:UIViewContentModeScaleAspectFill bounds:CGSizeMake(59, 59) interpolationQuality:kCGInterpolationHigh];
             logoImageTest = [logoImageTest croppedImage:CGRectMake(0, 0, 59, 59)];
             [self.imageView setImage:logoImageTest];
         }
     }];
    
    fioLabel.frame = CGRectMake(72.0, 3.0, fioLabel.frame.size.width, fioLabel.frame.size.height);
    fioLabel.text = fioText;
    subTextLabel.text = @"";
    
    switch (filterType) {
        case textFio:
        {
            fioLabel.frame = CGRectMake(72.0, centerY, fioLabel.frame.size.width, fioLabel.frame.size.height);
            typeSubTextLabel.text = @"";
            [self setSubtextToBoldForText:fioText subText:query forLabel:fioLabel fontSize:17];
        }
            break;
        case textCity:
        {
            typeSubTextLabel.text = @"город";
            [self setSubtextToBoldForText:subText subText:query forLabel:subTextLabel fontSize:15];
        }
            break;
        case textScopeWork:
        {
            typeSubTextLabel.text = @"отрасль";
            [self setSubtextToBoldForText:subText subText:query forLabel:subTextLabel fontSize:15];
        }
            break;
        case textInterests:
        {
            typeSubTextLabel.text = @"знания";
            [self setSubtextToBoldForText:subText subText:query forLabel:subTextLabel fontSize:15];
        }
            break;
            
        default:
            break;
    }
}

-(void) setSubtextToBoldForText:(NSString*)text
                        subText:(NSString*)subText
                forLabel:(TTTAttributedLabel*)label
                       fontSize:(NSInteger)fontSize
{
    [label setText:text afterInheritingLabelAttributesAndConfiguringWithBlock:^ NSMutableAttributedString *(NSMutableAttributedString *mutableAttributedString) {
        NSRange boldRange = [[mutableAttributedString string] rangeOfString:subText options:NSCaseInsensitiveSearch];
        
        UIFont *boldSystemFont = [UIFont fontWithName:@"HypatiaSansPro-Bold" size:fontSize];
        CTFontRef font = CTFontCreateWithName((__bridge CFStringRef)boldSystemFont.fontName, boldSystemFont.pointSize, NULL);
        if (font) {
            [mutableAttributedString addAttribute:(NSString *)kCTFontAttributeName value:(__bridge id)font range:boldRange];
            CFRelease(font);
        }
        
        return mutableAttributedString;
    }];
}

@end
