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

#import "TRPartyUsersListVC.h"
#import "TRSearchPartnersListVC.h"

@implementation TRTagsBox

- (void)setup {
    
    self.backgroundColor = [UIColor colorWithRed:242.0/255.0 green:242.0/255.0 blue:242.0/255.0 alpha:1.0];
    
    //self.borderStyle = MGBorderEtchedTop;
    //self.topBorderColor = [UIColor colorWithRed:206.0/255.0 green:206.0/255.0 blue:206.0/255.0 alpha:1.0];
    
    self.zIndex = -1;
    
    self.topMargin = 0;
}

+(MGBox *) initBox:(CGSize)bounds withUserData:(TRUserInfoModel*)userObject byTarget:(id)target
{
    TRTagsBox *box = [TRTagsBox boxWithSize: CGSizeMake(bounds.width, 124)];
    box.userData = userObject;
    box.rootBox = target;
    
    NSMutableArray *hightResolution = [[NSMutableArray alloc] init];
    for(TRUserResolutionModel *userResolution in box.userData.interests)
    {
        [hightResolution addObject:userResolution.name];
    }
    
    if(hightResolution.count > 0)   {
        TRTagsScrollBox *tagsResolution = [TRTagsScrollBox initBoxWithTitle:@"Высокое разрешение:" andTagsArray:hightResolution byTarget:box];
        tagsResolution.tag = 1;
        [box.boxes addObject:tagsResolution];
    }
    
    NSMutableArray *business = [[NSMutableArray alloc] init];
    for(TRBusinessScopeModel *scopes in box.userData.business.industries)
    {
        [business addObject:scopes.name];
    }
    
    if(business.count > 0)  {
        TRTagsScrollBox *tagsCurrentBusiness = [TRTagsScrollBox initBoxWithTitle:@"Отрасли:" andTagsArray:business byTarget:box];
        tagsCurrentBusiness.tag = 2;
        [box.boxes addObject:tagsCurrentBusiness];
    }
    
    return box;
}

-(void) selectTag:(NSInteger)tag atName:(NSString*)text
{
    if(tag == 1)    {
        TRSearchPartnersListVC *partnersVC = [[TRSearchPartnersListVC alloc] initVCByQuery:text];
        [self.rootBox.navigationController pushViewController:partnersVC animated:YES];
    } else  {
        TRPartyUsersListVC *partyUsersVC = [[TRPartyUsersListVC alloc] initPUSearchByCity:@"" andIndustry:text];
        [self.rootBox.navigationController pushViewController:partyUsersVC animated:YES];
    }
}

@end
