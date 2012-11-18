//
//  AppDelegate.h
//  Photomo1
//
//  Created by Vu Minh Thuan on 8/30/12.
//  Copyright (c) 2012 CyberAgent. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>
@class ViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    UIImage *pass_img;
    NSInteger *pass_img_id;
}

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) ViewController *viewController;
@property (strong,nonatomic) UIImage *pass_img;
@property  NSInteger *pass_img_id;

@end
