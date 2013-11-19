//
//  TRAuthViewController.h
//  TheRiverApp
//
//  Created by DenisDbv on 21.09.13.
//  Copyright (c) 2013 axbx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TRAuthBlockView.h"

@interface TRAuthViewController : UIViewController <TRAuthBlockViewDelegate>

@property (nonatomic, strong) IBOutlet UIScrollView *scrollView;

@end
