//
//  VDAppDelegate.m
//  Vdemo
//
//  Created by Vic Zhou on 2/5/13.
//  Copyright (c) 2013 Vic Zhou. All rights reserved.
//

#import "VDAppDelegate.h"

#import "VDViewController.h"
//#import "SHKConfiguration.h"
#import "VDShareKitConfigurator.h"

@implementation VDAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //custom controls
//    [self applyStylesheet];
    
    //for sharekit
//    DefaultSHKConfigurator *configurator = [[VDShareKitConfigurator alloc] init];
//    [SHKConfiguration sharedInstanceWithConfigurator:configurator];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.viewController = [[VDViewController alloc] initWithNibName:@"VDViewController" bundle:nil];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:self.viewController];
    self.window.rootViewController = nav;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - Stylesheet

- (void)applyStylesheet
{
    // Navigation bar
    UINavigationBar *navigationBar = [UINavigationBar appearance];
    
    [navigationBar setBackgroundImage:[UIImage imageNamed:@"nav_bg.png"] forBarMetrics:UIBarMetricsDefault];
    [navigationBar setTitleVerticalPositionAdjustment:-1.0f forBarMetrics:UIBarMetricsDefault];
    [navigationBar setTitleTextAttributes:[[NSDictionary alloc] initWithObjectsAndKeys:
                                           [UIFont systemFontOfSize:20.0f], UITextAttributeFont,
                                           [UIColor colorWithWhite:0.0f alpha:0.2f], UITextAttributeTextShadowColor,
                                           [NSValue valueWithUIOffset:UIOffsetMake(0.0f, 1.0f)], UITextAttributeTextShadowOffset,
                                           [UIColor whiteColor], UITextAttributeTextColor,
                                           nil]];
    
    // Navigation bar mini
    [navigationBar setTitleVerticalPositionAdjustment:-2.0f forBarMetrics:UIBarMetricsLandscapePhone];
    [navigationBar setBackgroundImage:[UIImage imageNamed:@"nav-background-mini"] forBarMetrics:UIBarMetricsLandscapePhone];
    
    // Navigation button
    NSDictionary *barButtonTitleTextAttributes = [[NSDictionary alloc] initWithObjectsAndKeys:
                                                  [UIFont systemFontOfSize:14.0f], UITextAttributeFont,
                                                  [UIColor colorWithWhite:0.0f alpha:0.2f], UITextAttributeTextShadowColor,
                                                  [NSValue valueWithUIOffset:UIOffsetMake(0.0f, 1.0f)], UITextAttributeTextShadowOffset,
                                                  nil];
    
    // Navigation Bar Title
    UIBarButtonItem *barButton = [UIBarButtonItem appearanceWhenContainedIn:[UINavigationBar class], nil];
    barButton.tintColor  = [UIColor darkGrayColor];
    
    [barButton setTitlePositionAdjustment:UIOffsetMake(0.0f, 1.0f) forBarMetrics:UIBarMetricsDefault];
    [barButton setTitleTextAttributes:barButtonTitleTextAttributes forState:UIControlStateNormal];
    [barButton setTitleTextAttributes:barButtonTitleTextAttributes forState:UIControlStateHighlighted];
    
    
    // Navigation back button
    [barButton setBackButtonTitlePositionAdjustment:UIOffsetMake(2.0f, -2.0f) forBarMetrics:UIBarMetricsDefault];
    
    // Navigation button mini
    [barButton setTitlePositionAdjustment:UIOffsetMake(0.0f, 1.0f) forBarMetrics:UIBarMetricsLandscapePhone];
    
    // Navigation back button mini
    [barButton setBackButtonTitlePositionAdjustment:UIOffsetMake(2.0f, -2.0f) forBarMetrics:UIBarMetricsLandscapePhone];
    
    // Toolbar
    UIToolbar *toolbar = [UIToolbar appearance];
    [toolbar setBackgroundImage:[UIImage imageNamed:@"navigation-background"] forToolbarPosition:UIToolbarPositionTop barMetrics:UIBarMetricsDefault];
    [toolbar setBackgroundImage:[UIImage imageNamed:@"toolbar-background"] forToolbarPosition:UIToolbarPositionBottom barMetrics:UIBarMetricsDefault];
    
    // Toolbar mini
    [toolbar setBackgroundImage:[UIImage imageNamed:@"navigation-background-mini"] forToolbarPosition:UIToolbarPositionTop barMetrics:UIBarMetricsLandscapePhone];
    [toolbar setBackgroundImage:[UIImage imageNamed:@"toolbar-background-mini"] forToolbarPosition:UIToolbarPositionBottom barMetrics:UIBarMetricsLandscapePhone];
    
    // tab bar custom appearance.
    UITabBar *tabBar = [UITabBar appearance];
    tabBar.tintColor = [UIColor darkGrayColor];
    tabBar.backgroundColor = [UIColor clearColor];
    tabBar.selectionIndicatorImage = [UIImage imageNamed:@"tabbar_selection"];
    tabBar.selectedImageTintColor = [UIColor redColor];
    // Remove the shadow gradient line at top tabbar
    //    tabBar.shadowImage = [UIImage imageNamed:@"tabbar_transparent_shadow.png"];
    
    // Custom the color and font in tab bar
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                       [UIColor whiteColor],
                                                       UITextAttributeTextColor,
                                                       [UIFont fontWithName:@"ProximaNova-Semibold" size:0.0],
                                                       UITextAttributeFont, nil]
                                             forState:UIControlStateHighlighted];
    
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                       [UIColor whiteColor], UITextAttributeTextColor,
                                                       // [UIColor grayColor], UITextAttributeTextShadowColor,
                                                       [UIFont fontWithName:@"ProximaNova-Semibold" size:0.0], UITextAttributeFont,
                                                       nil]
                                             forState:UIControlStateNormal];
    
    // Customizing the switch control
    [[UISwitch appearance] setOnTintColor:[UIColor darkGrayColor]];
    //    [[UISwitch appearance] setTintColor:[UIColor MCYellowColor]];
    //    [[UISwitch appearance] setThumbTintColor:[UIColor MCTextBlueColor]];
    //
    //    // Customizing the switch text
    //    [[UISwitch appearance] setOnImage:[UIImage imageNamed:@"yesSwitch"]];
    //    [[UISwitch appearance] setOffImage:[UIImage imageNamed:@"noSwitch"]];
}


@end
