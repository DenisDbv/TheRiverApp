//
//  ZoomView.h
//  PictureZoom
//
//  Created by Aliaksandr Andrashuk on 31.07.11.
//  Copyright 2011 Aliaksandr Andrashuk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZoomView : UIScrollView<UIScrollViewDelegate> {
    UIImageView* m_imageView;
    UIImage* m_image;
}

@property (nonatomic, readonly) UIImageView* imageView;
@property (nonatomic, copy) UIImage* image;

-(id) initWithImage:(UIImage*)image frame:(CGRect)frame;

@end
