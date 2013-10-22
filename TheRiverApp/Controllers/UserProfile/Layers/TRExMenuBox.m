//
//  TRExMenuBox.m
//  TheRiverApp
//
//  Created by DenisDbv on 08.09.13.
//  Copyright (c) 2013 axbx. All rights reserved.
//

#import "TRExMenuBox.h"
#import "UIView+GestureBlocks.h"
#import "TRAlbumViewController.h"
#import "TRFriendsListVC.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import <RNBlurModalView/RNBlurModalView.h>

@implementation TRExMenuBox
{
    UIScrollView *_scrollBoxes;
}

- (void)setup {
    
    self.backgroundColor = [UIColor whiteColor];
}

+(MGBox *) initBox:(CGSize)bounds withUserData:(TRUserInfoModel*)userObject byTarget:(id)target;
{
    TRExMenuBox *box = [TRExMenuBox boxWithSize: CGSizeMake(bounds.width, 104)];
    box.userData = userObject;
    box.borderStyle = MGBorderEtchedTop | MGBorderEtchedBottom;
    box.topBorderColor = [UIColor colorWithRed:206.0/255.0 green:206.0/255.0 blue:206.0/255.0 alpha:1.0];
    //box.bottomBorderColor = [UIColor colorWithRed:206.0/255.0 green:206.0/255.0 blue:206.0/255.0 alpha:1.0];
    
    [box initScroll];
    
    UIView *photoBox = [box createViewWithImage:[UIImage imageNamed:@"profile-scrollview-photos@2x.png"] withTitle:@"Фотографии"];
    [photoBox initialiseTapHandler:^(UIGestureRecognizer *sender) {
        //TRAlbumViewController *albumVC = [[TRAlbumViewController alloc] init];
        //[((UIViewController*)target).navigationController pushViewController:albumVC animated:YES];
        [box showAlarmMessage:@"Фотографии" :@"В следующей версии вы сможете загрузить больше фотографий и видео, своих и своего бизнеса\n\n"];
    } forTaps:1];
    
    UIView *contactsBox = [box createViewWithImage:[UIImage imageNamed:@"profile-scrollview-contacts@2x.png"] withTitle:@"Контакты"];
    [contactsBox initialiseTapHandler:^(UIGestureRecognizer *sender) {
        //TRFriendsListVC *friendsList = [[TRFriendsListVC alloc] init];
        //[((UIViewController*)target).navigationController pushViewController:friendsList animated:YES];
        [box showAlarmMessage:@"Контакты" :@"В следующей версии, в этом разделе будет список избранных участников.\n\n"];
    } forTaps:1];
    
    UIView *knowBox = [box createViewWithImage:[UIImage imageNamed:@"profile-scrollview-posts@2x.png"] withTitle:@"Знания"];
    [knowBox initialiseTapHandler:^(UIGestureRecognizer *sender) {
        [box showAlarmMessage:@"Знания" :@"В следующей версии, в этом разделе вы сможете просматривать знания и ценные инструменты которые опубликовали другие участники.\n\n"];
    } forTaps:1];
    
    UIView *sbscrBox = [box createViewWithImage:[UIImage imageNamed:@"profile-scrollview-subscribed@2x.png"] withTitle:@"Интересно"];
    [sbscrBox initialiseTapHandler:^(UIGestureRecognizer *sender) {
        [box showAlarmMessage:@"И это еще не всё!" :@"Это приложение сообщества, поэтому смело предлагайте свои идеи и голосуйте за другие.\nСамые интересные из них обязательно будут реализованы. Для этого зайдите на вкладку \"оставить отзыв\" в левом меню.\n\n"];
    } forTaps:1];
    
    // В следующей версии, в этом разделе вы сможете просматривать знания и ценные инструменты которые опубликовали другие участники
    // интересно. Заголовок: И это еще не всё Описание: Это приложение сообщества, поэтому смело предлагайте свои идеи и голосуйте за другие. Самые интересные из них обязательно будут реализованы. Для этого зайдите на вкладку "оставить отзыв" в левом меню.
    
    NSArray *buttonsArray = [NSArray arrayWithObjects:
                             contactsBox,
                             knowBox,
                             photoBox,
                             sbscrBox, nil];
    [box addViewsToScroll:buttonsArray];
    
    return box;
}

-(void) showAlarmMessage:(NSString*)title :(NSString*)message
{
    UIViewController *rootViewController = [UIApplication sharedApplication].delegate.window.rootViewController;
    RNBlurModalView *modal = [[RNBlurModalView alloc] initWithViewController:rootViewController title:title message:message];
    [modal showWithDuration:0.1 delay:0 options:UIViewAnimationOptionCurveLinear completion:nil];
}

-(void) initScroll
{
    _scrollBoxes = [[UIScrollView alloc] initWithFrame:self.bounds];
    _scrollBoxes.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _scrollBoxes.showsHorizontalScrollIndicator = NO;
    _scrollBoxes.contentInset = UIEdgeInsetsMake(0, 10, 0, 10);
    //_scrollBoxes.backgroundColor = [UIColor redColor];
    _scrollBoxes.showsVerticalScrollIndicator = NO;
    [self addSubview: _scrollBoxes];
}

-(UIView*) createViewWithImage:(UIImage*)image withTitle:(NSString*)title
{
    UIView *rootHead = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 90, 80)];
    //rootHead.backgroundColor = [UIColor blueColor];
    
    UIView *preview = [[UIView alloc] initWithFrame:CGRectMake(0, 0,
                                                               rootHead.frame.size.width,
                                                               rootHead.frame.size.height-20)];
    preview.backgroundColor = [UIColor yellowColor];
    if(image != nil)    {
        UIImageView *subImageView = [[UIImageView alloc] initWithImage:image];
        subImageView.frame = preview.frame;
        //[preview addSubview:subImageView];
        preview = subImageView;
    }
    /*preview.layer.shadowColor = [UIColor colorWithWhite:0.12 alpha:1].CGColor;
    preview.layer.shadowOffset = CGSizeMake(0, 0);
    preview.layer.shadowRadius = 1;
    preview.layer.shadowOpacity = 1;
    preview.layer.cornerRadius = 0;*/
    [rootHead addSubview:preview];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:13];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textColor = [UIColor colorWithRed:51.0/255.0 green:51.0/255.0 blue:51.0/255.0 alpha:1.0];
    titleLabel.text = title;
    [titleLabel sizeToFit];
    titleLabel.frame = CGRectOffset(titleLabel.frame,
                                    (rootHead.frame.size.width-titleLabel.frame.size.width)/2,
                                    (rootHead.frame.size.height-titleLabel.frame.size.height));
    [rootHead addSubview:titleLabel];
    
    return rootHead;
}

-(void) addViewsToScroll:(NSArray*)array
{
    int index = 0;
    
    for(UIView *view in array)
    {
        view.frame = CGRectOffset(view.frame, index*(view.bounds.size.width+10), 13);
        
        _scrollBoxes.contentSize = CGSizeMake(view.origin.x+view.frame.size.width, _scrollBoxes.bounds.size.height);
        [_scrollBoxes addSubview:view];
        
        index++;
    }
}

@end
