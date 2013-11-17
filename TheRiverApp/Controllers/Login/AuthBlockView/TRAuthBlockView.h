//
//  TRAuthBlockView.h
//  TheRiverApp
//
//  Created by DenisDbv on 17.11.13.
//  Copyright (c) 2013 axbx. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TRAuthBlockViewDelegate <NSObject>
-(void) onClickLoginWithEmail:(NSString*)email andPassword:(NSString*)password;
@end

@interface TRAuthBlockView : UIView

@property (nonatomic, strong) id <TRAuthBlockViewDelegate> delegate;

@property (nonatomic, strong) IBOutlet UIView *loginBlockView;
@property (nonatomic, strong) IBOutlet UITextField *emailTextField;
@property (nonatomic, strong) IBOutlet UITextField *passwordTextField;

-(void) startSpinner;
-(void) stopSpinner;
-(void) shakeLoginView;
-(void) resignFromAllFields;

@end
