//
//  AppDelegate.m
//  Photomo1
//
//  Created by Vu Minh Thuan on 8/30/12.
//  Copyright (c) 2012 CyberAgent. All rights reserved.
//

#import "AppDelegate.h"

#import "ViewController.h"
#import <FacebookSDK/FacebookSDK.h>
@implementation AppDelegate


@synthesize window = _window;
@synthesize pass_img;
@synthesize pass_img_id;

// FBSample logic
// If we have a valid session at the time of openURL call, we handle Facebook transitions
// by passing the url argument to handleOpenURL; see the "Just Login" sample application for
// a more detailed discussion of handleOpenURL
- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    // attempt to extract a token from the url
    return [FBSession.activeSession handleOpenURL:url];
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    pass_img =[[UIImage alloc] init];
    pass_img_id=0;
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    
    ViewController *controller = [[ViewController alloc] init];
    controller.title = @"Photomo 2012";
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:controller];
    
#if EXPERIEMENTAL_ORIENTATION_SUPPORT
    UINavigationController *container = [[UINavigationController alloc] init];
    [container setNavigationBarHidden:YES animated:NO];
    [container setViewControllers:[NSArray arrayWithObject:navController] animated:NO];
    self.window.rootViewController = container;
#else
    self.window.rootViewController = navController;
#endif
    
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



@end
