//
//  ImageViewController.h
//  Photomo1
//
//  Created by Vu Minh Thuan on 8/30/12.
//  Copyright (c) 2012 CyberAgent. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageViewController : UIViewController

@property (nonatomic, retain) IBOutlet UIImageView *ivPic;


-(void) setImage:(UIImage *)img;
-(void) save;

@end

