//
//  NewViewController.m
//  Photomo1
//
//  Created by Vu Minh Thuan on 8/30/12.
//  Copyright (c) 2012 CyberAgent. All rights reserved.
//

#import "NewViewController.h"
#import "UINavigationItem+JTRevealSidebarV2.h"
#import "UIViewController+JTRevealSidebarV2.h"
#import "JTRevealSidebarV2Delegate.h"
#import "ImageViewController.h"
#import "UIImage+FiltrrCompositions.h"
#import "UIImage+Scale.h"
#import "AppDelegate.h"

@interface NewViewController () <JTRevealSidebarV2Delegate, UITableViewDataSource, UITableViewDelegate>
@end

@implementation NewViewController
@synthesize label;
@synthesize rightSidebarView;
@synthesize tblEffects = _tblEffects;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

-(id) init{
    self = [super init];
    //selectedImage=[[UIImage alloc] init];
    return self;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    selectedImage = appDelegate.pass_img;
    thumbImage = [selectedImage scaleToSize:CGSizeMake((appDelegate.pass_img.size.width/appDelegate.pass_img.size.height)*320, 320)];
    minithumbImage = [thumbImage scaleToSize:CGSizeMake((appDelegate.pass_img.size.width/appDelegate.pass_img.size.height)*40, 40)];
    arrEffects = [[NSMutableArray alloc] initWithObjects:
                  [NSDictionary dictionaryWithObjectsAndKeys:@"現画像",@"title",@"",@"method", nil],
                  [NSDictionary dictionaryWithObjectsAndKeys:@"効果1",@"title",@"e1",@"method", nil],
                  [NSDictionary dictionaryWithObjectsAndKeys:@"効果2",@"title",@"e2",@"method", nil],
                  [NSDictionary dictionaryWithObjectsAndKeys:@"効果3",@"title",@"e3",@"method", nil],
                  [NSDictionary dictionaryWithObjectsAndKeys:@"効果4",@"title",@"e4",@"method", nil],
                  [NSDictionary dictionaryWithObjectsAndKeys:@"効果5",@"title",@"e5",@"method", nil],
                  [NSDictionary dictionaryWithObjectsAndKeys:@"効果6",@"title",@"e6",@"method", nil],
                  [NSDictionary dictionaryWithObjectsAndKeys:@"効果7",@"title",@"e7",@"method", nil],
                  [NSDictionary dictionaryWithObjectsAndKeys:@"効果8",@"title",@"e8",@"method", nil],
                  [NSDictionary dictionaryWithObjectsAndKeys:@"効果9",@"title",@"e9",@"method", nil],
                  [NSDictionary dictionaryWithObjectsAndKeys:@"効果10",@"title",@"e10",@"method", nil],
                  [NSDictionary dictionaryWithObjectsAndKeys:@"効果11",@"title",@"e11",@"method", nil],
                  nil];
    
    /*UIBarButtonItem *cam = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCamera target:self action:@selector(showCam)];
    self.navigationItem.rightBarButtonItem = cam;
    self.navigationItem.rightBarButtonItem.tintColor=[UIColor colorWithRed:0 green:0.5 blue:0 alpha:1.0];
    self.navigationItem.leftBarButtonItem.tintColor=[UIColor colorWithRed:0 green:0.5 blue:0 alpha:1.0];*/
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc]
                                   initWithTitle: @"戻る"
                                   style: UIBarButtonItemStyleBordered
                                   target: nil action: nil];
    
    [self.navigationItem setBackBarButtonItem: backButton];
    self.navigationItem.backBarButtonItem.tintColor=[UIColor colorWithRed:0 green:0.5 blue:0 alpha:1.0];

    self.title = @"効果";
    //self.view.
    

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

-(void) showCam {
    NSLog(@"...");
    imagePicker = [[UIImagePickerController alloc] init];
    // Set source to the camera
#if (TARGET_IPHONE_SIMULATOR)
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
#else
    imagePicker.sourceType =  UIImagePickerControllerSourceTypeCamera;
#endif
    // Delegate is self
    imagePicker.delegate = self;
    // Allow editing of image ?
    [imagePicker setAllowsEditing:YES];
    // Show image picker
    [self presentModalViewController:imagePicker animated:YES];
}

-(int) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return arrEffects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"EffectCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    if(((NSString *)[[arrEffects objectAtIndex:indexPath.row] valueForKey:@"method"]).length > 0) {
        SEL _selector = NSSelectorFromString([[arrEffects objectAtIndex:indexPath.row] valueForKey:@"method"]);
        cell.imageView.image = [minithumbImage performSelector:_selector];
    } else
        cell.imageView.image = minithumbImage;
    
    cell.textLabel.text = [(NSDictionary *)[arrEffects objectAtIndex:indexPath.row] valueForKey:@"title"];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ImageViewController *nextViewController = [[ImageViewController alloc] initWithNibName:@"ImageViewController" bundle:nil];
    nextViewController.title = [[arrEffects objectAtIndex:indexPath.row] valueForKey:@"title"];
    
    [self.navigationController pushViewController:nextViewController animated:YES];
    
    if(((NSString *)[[arrEffects objectAtIndex:indexPath.row] valueForKey:@"method"]).length > 0) {
        
#ifndef TRACKTIME
        
        SEL _selector = NSSelectorFromString([[arrEffects objectAtIndex:indexPath.row] valueForKey:@"method"]);
        [nextViewController setImage:[thumbImage performSelector:_selector]];
        
#else
        
        SEL _track = NSSelectorFromString(@"trackTime:");
        [nextViewController setImage:[thumbImage performSelector:_track withObject:[[arrEffects objectAtIndex:indexPath.row] valueForKey:@"method"]]];
        
#endif
        
    } else {
        [nextViewController setImage:thumbImage];
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    // Access the uncropped image from info dictionary
    selectedImage =  [info objectForKey:UIImagePickerControllerEditedImage];//[info objectForKey:@"UIImagePickerControllerOriginalImage"];
    thumbImage = [selectedImage scaleToSize:CGSizeMake(320, 320)];
    minithumbImage = [thumbImage scaleToSize:CGSizeMake(40, 40)];
    
    [_tblEffects reloadData];
    
    [picker dismissModalViewControllerAnimated:YES];
    
    // Save image
    //    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}

-(void) setImage:(UIImage *)img {
    selectedImage = img;
}

@end
