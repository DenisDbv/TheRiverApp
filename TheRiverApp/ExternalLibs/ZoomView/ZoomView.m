//
//  ZoomView.m
//  PictureZoom
//
//  Created by Aliaksandr Andrashuk on 31.07.11.
//  Copyright 2011 Aliaksandr Andrashuk. All rights reserved.
//

#import "ZoomView.h"

@implementation ZoomView
@synthesize imageView;

// создает imageView
-(void) createImageViewWithImage:(UIImage*)image {
    m_imageView = [[UIImageView alloc] initWithImage:image];
    // назначить всю доступную область
    m_imageView.frame = self.bounds;
    // режим отображения картинки
    m_imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    // максимальный и минимальный зум
    [self setMinimumZoomScale:1.0];
    [self setMaximumZoomScale:2.0];
    
    [self addSubview:m_imageView];
}

// меняет картинку в UIImageView
-(void) changeImageTo:(UIImage*)image {
    m_imageView.image = image;
}

// позволяет установить картинку из-вне
-(void) setImage:(UIImage *)image {
    [m_image release];
    m_image = nil;
    
    if ( image != nil ) {
        m_image = [image copy];
        
        // если imageView еще не создано - создать
        if ( m_imageView == nil ) {
            [self createImageViewWithImage:m_image];
        }
        
        [self changeImageTo:m_image];
    }
}

-(UIImage*) image {
    return [[m_image copy] autorelease];
}

// конструторы и деструктор
-(id) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    self.delegate = self;
    self.autoresizesSubviews = YES;
    return self;
}
-(id) init {
    return [self initWithFrame:CGRectZero];
}
-(id) initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    self.delegate = self;
    return self;
}
-(id) initWithImage:(UIImage*)image frame:(CGRect)frame {
    self = [self initWithFrame:frame];
    m_image = [image copy];
    [self createImageViewWithImage:m_image];
    return self;
}
-(void) dealloc {
    self.delegate = nil;
    [m_imageView release];
    [m_image release];
    [super dealloc];
}
// делегат UIScrollView, должен возвращать то что надо зумить
-(UIView*) viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return m_imageView;
}
@end
