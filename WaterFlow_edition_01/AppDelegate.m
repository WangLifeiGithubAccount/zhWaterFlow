//
//  AppDelegate.m
//  WaterFlow_edition_01
//
//  Created by dev fndsoft on 5/20/13.
//  Copyright (c) 2013 marginChang. All rights reserved.
//

#import "AppDelegate.h"
#import "WaterFlowViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    self.window.backgroundColor = [UIColor whiteColor];
    WaterFlowViewController *waterFlowController = [[WaterFlowViewController alloc] init];
    [self.window setRootViewController:waterFlowController];
    [waterFlowController release];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)dealloc
{
    [_window release];
    [super dealloc];
}

@end
