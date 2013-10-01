//
//  TRImageReviewController.h
//  TheRiverApp
//
//  Created by DenisDbv on 01.10.13.
//  Copyright (c) 2013 axbx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZoomView.h"

@interface TRImageReviewController : UIViewController

@property (nonatomic, retain) IBOutlet ZoomView *zoomView;

- (id) initWithImage:(NSString*)imagePath;

@end
