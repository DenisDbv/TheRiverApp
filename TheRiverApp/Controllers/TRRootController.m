//
//  TRRootController.m
//  TheRiverApp
//
//  Created by DenisDbv on 02.09.13.
//  Copyright (c) 2013 axbx. All rights reserved.
//

#import "TRRootController.h"
#import "MFSideMenu.h"

#define MENU_BAR_FULL_WIDTH  320.0
#define MENU_BAR_SHORT_WIDTH  270.0

@interface TRRootController ()

@end

@implementation TRRootController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = YES;
    
    //[self toShortWidth];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(menuStateEventOccurred:)
                                                 name:MFSideMenuStateNotificationEvent
                                               object:nil];
}

- (void)menuStateEventOccurred:(NSNotification *)notification {
    MFSideMenuStateEvent event = [[[notification userInfo] objectForKey:@"eventType"] intValue];
    //MFSideMenuContainerViewController *containerViewController = notification.object;
 
    NSLog(@"=>%i", event);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void) changeControllerWidth:(NSInteger)width
{
    [self.menuContainerViewController setMenuWidth: width];
}

-(void) toFullWidth
{
    [self.menuContainerViewController setMenuWidth: MENU_BAR_FULL_WIDTH];
}

-(void) toShortWidth
{
    [self.menuContainerViewController setMenuWidth: MENU_BAR_SHORT_WIDTH];
}

@end
