//
//  TRTagsBox.m
//  TheRiverApp
//
//  Created by DenisDbv on 08.09.13.
//  Copyright (c) 2013 axbx. All rights reserved.
//

#import "TRTagsBox.h"
#import "TRTagsScrollBox.h"

#import "TRUserResolutionModel.h"
#import "TRBusinessScopeModel.h"

@implementation TRTagsBox

- (void)setup {
    
    self.backgroundColor = [UIColor colorWithRed:242.0/255.0 green:242.0/255.0 blue:242.0/255.0 alpha:1.0];
    
    //self.borderStyle = MGBorderEtchedTop;
    //self.topBorderColor = [UIColor colorWithRed:206.0/255.0 green:206.0/255.0 blue:206.0/255.0 alpha:1.0];
    
    self.zIndex = -1;
    
    self.topMargin = 10;
}

+(TRTagsBox *)initBox:(CGSize)bounds withUserData:(TRUserInfoModel *)userObject
{
    TRTagsBox *box = [TRTagsBox boxWithSize: CGSizeMake(bounds.width, 124)];
    box.userData = userObject;
    
    NSMutableArray *hightResolution = [[NSMutableArray alloc] init];
    for(TRUserResolutionModel *userResolution in box.userData.interests)
    {
        [hightResolution addObject:userResolution.name];
    }
    
    if(hightResolution.count > 0)   {
        TRTagsScrollBox *tagsResolution = [TRTagsScrollBox initBoxWithTitle:@"Высокое разрешение:" andTagsArray:hightResolution];
        [box.boxes addObject:tagsResolution];
    }
    
    NSMutableArray *business = [[NSMutableArray alloc] init];
    for(TRBusinessScopeModel *scopes in box.userData.business.scope_work)
    {
        [business addObject:scopes.name];
    }
    
    if(business.count > 0)  {
        TRTagsScrollBox *tagsCurrentBusiness = [TRTagsScrollBox initBoxWithTitle:@"Отрасли:" andTagsArray:business];
        [box.boxes addObject:tagsCurrentBusiness];
    }
    
    return box;
}

@end
