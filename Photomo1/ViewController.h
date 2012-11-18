//
//  ViewController.h
//  Photomo1
//
//  Created by Vu Minh Thuan on 8/30/12.
//  Copyright (c) 2012 CyberAgent. All rights reserved.
//


#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "JTRevealSidebarV2Delegate.h"
#import "TickleGestureRecognizer.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <FacebookSDK/FacebookSDK.h>

// Orientation changing is not an officially completed feature,
// The main thing to fix is the rotation animation and the
// necessarity of the container created in AppDelegate. Please let
// me know if you've got any elegant solution and send me a pull request!
// You can change EXPERIEMENTAL_ORIENTATION_SUPPORT to 1 for testing purpose
#define EXPERIEMENTAL_ORIENTATION_SUPPORT 1

@class SidebarViewController;

@interface ViewController : UIViewController <JTRevealSidebarV2Delegate, UITableViewDelegate, FBLoginViewDelegate> {
#if EXPERIEMENTAL_ORIENTATION_SUPPORT
    CGPoint _containerOrigin;
#endif
    NSString *mode;
    NSMutableArray *helps;
}

//@property (nonatomic, strong) NSMutableArray *seleted_ids;
@property (nonatomic, strong) UITableView *leftSidebarView;
@property (nonatomic, strong) UITableView *rightSidebarView;
@property (nonatomic, strong) UITableView *rightBgSidebarView;
@property (nonatomic, strong) UITableView *rightTpSidebarView;
@property (nonatomic, strong) UITableView *rightItemSidebarView;
@property (nonatomic, strong) UITableView *rightHelpSidebarView;
@property (nonatomic, strong) NSIndexPath *leftSelectedIndexPath;
@property (nonatomic, strong) UILabel     *label;
@property (nonatomic, strong) UITextField     *mytxt;
@property (nonatomic, strong) NSMutableArray *template_points;
@property (nonatomic, strong) NSMutableArray *templates;
@property (nonatomic, strong) NSMutableArray *items;
@property (nonatomic, strong) NSMutableArray *helps;
@property (nonatomic, strong) NSString *background;
@property (nonatomic, strong) __block NSArray *photos;
@property (nonatomic, strong) __block NSMutableArray *dates;
@property (nonatomic, strong) NSString *mode;
@property (nonatomic, strong) UIImageView *mytemp;
@property (strong, nonatomic) FBSession *session;
@property (strong, nonatomic) id<FBGraphUser> loggedInUser;
@property (nonatomic, strong) UIImage * cropped;

- (void)AddGes:(UIView *)view;
- (void) loadPhotosFromGallery;
- (void) updatePhotosGallery;
- (void) openPopup:(id)sender;

+ (ALAssetsLibrary *)defaultAssetsLibrary;

@end
