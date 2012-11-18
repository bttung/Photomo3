//
//  NewViewController.h
//  Photomo1
//
//  Created by Vu Minh Thuan on 8/30/12.
//  Copyright (c) 2012 CyberAgent. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewViewController :  UIViewController<UITableViewDataSource, UITableViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate> {
    NSString *filename;
    NSMutableArray *arrEffects;
    
    UIImagePickerController * imagePicker;
    UIImage *selectedImage, *thumbImage;
    UIImage *minithumbImage;
}

@property (nonatomic, strong) UILabel     *label;
@property (nonatomic, strong) UITableView *rightSidebarView;
@property (nonatomic, retain) IBOutlet UITableView *tblEffects;

-(void) showCam;
-(void) setImage:(UIImage *)img;

@end
