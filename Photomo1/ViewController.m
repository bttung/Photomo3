//
//  ViewController.m
//  Photomo1
//
//  Created by Vu Minh Thuan on 8/30/12.
//  Copyright (c) 2012 CyberAgent. All rights reserved.
//

#import "ViewController.h"
#import "UIViewController+JTRevealSidebarV2.h"
#import "UINavigationItem+JTRevealSidebarV2.h"
#import "NewViewController.h"
#import "JTRevealSidebarV2Delegate.h"
#import "QuartzCore/CALayer.h"
#import "UIImage+FiltrrCompositions.h"
#import "UIImage+Scale.h"
#import "AppDelegate.h"
#import <FacebookSDK/FacebookSDK.h>


#if EXPERIEMENTAL_ORIENTATION_SUPPORT
#import <QuartzCore/QuartzCore.h>
#endif

#define FONT_SIZE 14.0f
#define CELL_CONTENT_WIDTH 320.0f
#define CELL_CONTENT_MARGIN 10.0f

@interface ViewController (Private) <UITableViewDataSource, UITableViewDelegate, FBLoginViewDelegate>

- (UIImage*)imageByCropping:(UIImage *)myImage toRect:(CGRect)cropToArea;

- (void) CaptureButton;
- (void) CaptureButton2;
@end

@implementation ViewController
@synthesize photos = _photos;
@synthesize mode;
@synthesize items;
@synthesize mytxt;
@synthesize cropped;

@synthesize loggedInUser = _loggedInUser;
@synthesize session = _session;

-(void)setPhotos:(NSArray *)photos {
    if (_photos != photos) {
        _photos = photos;
    }
}

@synthesize leftSidebarView;
@synthesize rightSidebarView;
@synthesize rightBgSidebarView;
@synthesize rightHelpSidebarView;
@synthesize rightItemSidebarView;
@synthesize rightTpSidebarView;
@synthesize leftSelectedIndexPath;
@synthesize label;
@synthesize mytemp;
@synthesize template_points;
@synthesize templates;
@synthesize dates;
@synthesize helps;

+ (ALAssetsLibrary *)defaultAssetsLibrary {
    static dispatch_once_t pred = 0;
    static ALAssetsLibrary *library = nil;
    dispatch_once(&pred, ^{
        library = [[ALAssetsLibrary alloc] init];
    });
    return library;
}

-(void) loadPhotosFromGallery
{
    // collect the photos
    NSMutableArray *collector = [[NSMutableArray alloc] initWithCapacity:0];
    ALAssetsLibrary *al = [ViewController defaultAssetsLibrary];
    
    [al enumerateGroupsWithTypes:ALAssetsGroupSavedPhotos
                      usingBlock:^(ALAssetsGroup *group, BOOL *stop)
     {
         [group enumerateAssetsUsingBlock:^(ALAsset *asset, NSUInteger index, BOOL *stop)
          {
              if (asset) {
                  [collector addObject:asset];
              }
          }];
         
         self.photos = collector;
     }
                    failureBlock:^(NSError *error) { NSLog(@"Boom!!!");}
     ];
    for(ALAsset *as in self.photos){
        
        [self.dates addObject:[as valueForProperty:ALAssetPropertyDate]];
    }
    
}

-(void) updatePhotosGallery
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadPhotosFromGallery) name:ALAssetsLibraryChangedNotification object:nil];
}



- (id)init {
    self = [super init];
    [self loadPhotosFromGallery];
    // ...
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:
                          @"読み取り成功"
                                                    message:
                          @"あなたのギャラリーから、すべての写真を読み取りました。"
                          delegate
                                                           : self cancelButtonTitle:
                          @"了解"
                                          otherButtonTitles: nil];
    
    [alert show];
    items =[NSMutableArray arrayWithObjects:@"mickey", @"スマイル",@"スマイル2",@"ハート",@"ハート2",@"ピン",@"ピン2",@"花",@"花2", nil];
    mode=@"normal";
    self.background=@"pat16.png";
    templates=[[NSMutableArray alloc] init];
    NSMutableArray *theTp=[[NSMutableArray alloc] init];
    UIImageView *imgv=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pat11.png"]];
    imgv.frame = CGRectMake(12, 12, 297, 290);
    [theTp addObject:imgv];
    [templates addObject:theTp];
    
    theTp=[[NSMutableArray alloc] init];
    imgv=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pat11.png"]];
    imgv.frame = CGRectMake(12, 12, 297, 390);
    [theTp addObject:imgv];
    [templates addObject:theTp];
    
    theTp=[[NSMutableArray alloc] init];
    imgv=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pat11.png"]];
    imgv.frame = CGRectMake(12, 12, 297, 290);
    [theTp addObject:imgv];
    imgv=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pat11.png"]];
    imgv.frame = CGRectMake(12, 312, 90, 90);
    [theTp addObject:imgv];
    imgv=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pat11.png"]];
    imgv.frame = CGRectMake(112, 312, 90, 90);
    [theTp addObject:imgv];
    imgv=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pat11.png"]];
    imgv.frame = CGRectMake(212, 312, 90, 90);
    [theTp addObject:imgv];
    [templates addObject:theTp];
    
    theTp=[[NSMutableArray alloc] init];
    imgv=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pat11.png"]];
    imgv.frame = CGRectMake(20, 20, 135, 175);
    [theTp addObject:imgv];
    imgv=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pat11.png"]];
    imgv.frame = CGRectMake(165, 20, 135, 175);
    [theTp addObject:imgv];
    imgv=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pat11.png"]];
    imgv.frame = CGRectMake(20,205, 135, 175);
    [theTp addObject:imgv];
    imgv=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pat11.png"]];
    imgv.frame = CGRectMake(165, 205, 135, 175);
    [theTp addObject:imgv];
    [templates addObject:theTp];
    
    theTp=[[NSMutableArray alloc] init];
    imgv=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pat11.png"]];
    imgv.frame = CGRectMake(20, 10, 135, 120);
    [theTp addObject:imgv];
    imgv=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pat11.png"]];
    imgv.frame = CGRectMake(165, 10, 135, 120);
    [theTp addObject:imgv];
    imgv=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pat11.png"]];
    imgv.frame = CGRectMake(20, 140, 135, 120);
    [theTp addObject:imgv];
    imgv=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pat11.png"]];
    imgv.frame = CGRectMake(165, 140, 135, 120);
    [theTp addObject:imgv];
    imgv=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pat11.png"]];
    imgv.frame = CGRectMake(20, 270, 135, 120);
    [theTp addObject:imgv];
    imgv=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pat11.png"]];
    imgv.frame = CGRectMake(165, 270, 135, 120);
    [theTp addObject:imgv];
    [templates addObject:theTp];
    
    template_points=[[NSMutableArray alloc] init];
    mytemp=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pat11.png"]];
    mytemp.frame = CGRectMake(12, 12, 297, 290);
    [self AddGes:mytemp];
    [template_points addObject:mytemp];
    mytemp.userInteractionEnabled=NO;
    return self;
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    helps = [[NSMutableArray alloc] init];
    

    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    
    CGColorRef darkColor = [[UIColor blackColor] colorWithAlphaComponent:.5f].CGColor;
    CGColorRef lightColor = [UIColor clearColor].CGColor;
    CAGradientLayer *newShadow = [[CAGradientLayer alloc] init];
    newShadow.frame = CGRectMake(0, 45, 320, 10);
    newShadow.colors = [NSArray arrayWithObjects:(__bridge id)darkColor, (__bridge id)lightColor, nil];
    [self.navigationController.navigationBar.layer addSublayer:newShadow];
    
    self.view.backgroundColor =[UIColor colorWithPatternImage:[UIImage imageNamed:self.background]];

    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"bar.png"] forBarMetrics:UIBarMetricsDefault];
    for(NSInteger i=0;i<[template_points count];i++){
        [self.view addSubview:[template_points objectAtIndex:i]];
    }
    UIBarButtonItem *leftbutt1 = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ButtonMenu.png"]  style:UIBarButtonItemStyleBordered target:self action:@selector(revealLeftSidebar:)];
    leftbutt1.tintColor=[UIColor colorWithRed:0 green:0.5 blue:0 alpha:1.0];
    UIBarButtonItem *leftbutt2 = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"facebook.png"]  style:UIBarButtonItemStyleBordered target:self action:@selector(logInOutFacebook)];
    leftbutt2.tintColor=[UIColor colorWithRed:0 green:0.5 blue:0 alpha:1.0];
    self.navigationItem.leftBarButtonItems=[NSArray arrayWithObjects:leftbutt1, nil];
    /*self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ButtonMenu.png"]  style:UIBarButtonItemStyleBordered target:self action:@selector(revealLeftSidebar:)];
    self.navigationItem.leftBarButtonItem.tintColor=[UIColor colorWithRed:0 green:0.5 blue:0 alpha:1.0];*/
    UIBarButtonItem *rightbutt1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemOrganize target:self action:@selector(revealRightSidebar:)];
    rightbutt1.tintColor=[UIColor colorWithRed:0 green:0.5 blue:0 alpha:1.0];
    UIBarButtonItem *rightbutt2 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCamera target:self action:@selector(CaptureButton)];
    rightbutt2.tintColor=[UIColor colorWithRed:0 green:0.5 blue:0 alpha:1.0];
    self.navigationItem.rightBarButtonItems=[NSArray arrayWithObjects:rightbutt1,leftbutt2, nil];
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc]
                                   initWithTitle: @"戻る"
                                   style: UIBarButtonItemStyleBordered
                                   target: nil action: nil];
    
    [self.navigationItem setBackBarButtonItem: backButton];
    self.navigationItem.backBarButtonItem.tintColor=[UIColor colorWithRed:0 green:0.5 blue:0 alpha:1.0];
    for (UIView * view in self.view.subviews) {
        if(!view){
            [self AddGes:view];
            
        }
    }
    
    self.navigationItem.revealSidebarDelegate = self;
    
    
}

- (void) logInOutFacebook
{
    [FBSession openActiveSessionWithPermissions:nil allowLoginUI:YES
                              completionHandler:^(FBSession *session,
                                                  FBSessionState status,
                                                  NSError *error) {
                                  // session might now be open.
                                  if (session.isOpen) {
                                      FBRequest *me = [FBRequest requestForMe];
                                      [me startWithCompletionHandler: ^(FBRequestConnection *connection,
                                                                        NSDictionary<FBGraphUser> *my,
                                                                        NSError *error) {
                                          UIAlertView *alert = [[UIAlertView alloc] initWithTitle:
                                                                @"ログイン成功"
                                                                                          message:
                                                                [NSString stringWithFormat:@"あなたが%@としてFacebookにログインしました。",my.first_name]
                                                                delegate
                                                                                                 : self cancelButtonTitle:
                                                                @"了解"
                                                                                otherButtonTitles: nil];
                                          
                                          [alert show];
                                          [self upload2FB];
                                      }];
                                  }
                              }];
    
}

- (void) upload2FB{

    [self CaptureButton2];
    [FBRequestConnection startForUploadPhoto:cropped
                           completionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
                               UIAlertView *alert = [[UIAlertView alloc] initWithTitle:
                                                     @"アップロード成功"
                                                                               message:
                                                     @"あなたのポスカードをFacebookにアップロードできました。また、ギャラリーにも保存しました。"
                                                     delegate
                                                                                      : self cancelButtonTitle:
                                                     @"了解"
                                                                     otherButtonTitles: nil];
                               
                               [alert show];
                               
                           }];
    
}


- (void)loginViewFetchedUserInfo:(FBLoginView *)loginView
                            user:(id<FBGraphUser>)user {
    // here we use helper properties of FBGraphUser to dot-through to first_name and
    // id properties of the json response from the server; alternatively we could use
    // NSDictionary methods such as objectForKey to get values from the my json object
    // setting the profileID property of the FBProfilePictureView instance
    // causes the control to fetch and display the profile picture for the user
    // self.profilePic.profileID = user.id;
    self.loggedInUser = user;
}

- (void)AddGes:(UIView *)view{
    UIPanGestureRecognizer * recognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    recognizer.delegate = self;
    [view addGestureRecognizer:recognizer];
    UIPinchGestureRecognizer *recognizer1 = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handlePinch:)];
    recognizer1.delegate=self;
    [view addGestureRecognizer:recognizer1];
    
    UIRotationGestureRecognizer *recognizer2 = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(handleRotate:)];
    recognizer2.delegate=self;
    [view addGestureRecognizer:recognizer2];
    
    UILongPressGestureRecognizer *recognizer3 =[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)];
    recognizer3.delegate=self;
    [view addGestureRecognizer:recognizer3];
    
    UITapGestureRecognizer *tapTwice = [[UITapGestureRecognizer alloc] initWithTarget:self  action:@selector(pushNewViewController:)];
    tapTwice.numberOfTapsRequired = 2;
    [view addGestureRecognizer:tapTwice];
    
    view.layer.shadowColor = [[UIColor blackColor] CGColor];
    view.layer.shadowOffset = CGSizeMake(0.0, 3.0);
    view.layer.shadowOpacity = 0.40;
    view.layer.shouldRasterize = YES;
}

- (void)AddGes2:(UIView *)view{
    UIPanGestureRecognizer * recognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    recognizer.delegate = self;
    [view addGestureRecognizer:recognizer];
    UIPinchGestureRecognizer *recognizer1 = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handlePinch:)];
    recognizer1.delegate=self;
    [view addGestureRecognizer:recognizer1];
    
    UIRotationGestureRecognizer *recognizer2 = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(handleRotate:)];
    recognizer2.delegate=self;
    [view addGestureRecognizer:recognizer2];
    
    UILongPressGestureRecognizer *recognizer3 =[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)];
    recognizer3.delegate=self;
    [view addGestureRecognizer:recognizer3];
    
    UITapGestureRecognizer *tapTwice = [[UITapGestureRecognizer alloc] initWithTarget:self  action:@selector(pushNewViewController:)];
    tapTwice.numberOfTapsRequired = 2;
    [view addGestureRecognizer:tapTwice];

}

- (void)AddGes3:(UIView *)view{
    UIPanGestureRecognizer * recognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    recognizer.delegate = self;
    [view addGestureRecognizer:recognizer];
    UIPinchGestureRecognizer *recognizer1 = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handlePinch:)];
    recognizer1.delegate=self;
    [view addGestureRecognizer:recognizer1];
    
    UIRotationGestureRecognizer *recognizer2 = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(handleRotate:)];
    recognizer2.delegate=self;
    [view addGestureRecognizer:recognizer2];
    
    UILongPressGestureRecognizer *recognizer3 =[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)];
    recognizer3.delegate=self;
    [view addGestureRecognizer:recognizer3];
    
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    
    self.label = nil;
    self.rightSidebarView = nil;
}

#if EXPERIEMENTAL_ORIENTATION_SUPPORT

// Doesn't support rotating to other orientation at this moment
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return YES;
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    _containerOrigin = self.navigationController.view.frame.origin;
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    self.navigationController.view.layer.bounds       = (CGRect){-_containerOrigin.x, _containerOrigin.y, self.navigationController.view.frame.size};
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    self.navigationController.view.layer.bounds       = (CGRect){CGPointZero, self.navigationController.view.frame.size};
    self.navigationController.view.frame              = (CGRect){_containerOrigin, self.navigationController.view.frame.size};
    
    NSLog(@"%@", self);
}

- (NSString *)description {
    NSString *logMessage = [NSString stringWithFormat:@"ViewController {"];
    logMessage = [logMessage stringByAppendingFormat:@"\n\t%@", self.view];
    logMessage = [logMessage stringByAppendingFormat:@"\n\t%@", self.navigationController.view];
    //logMessage = [logMessage stringByAppendingFormat:@"\n\t%@", self.leftSidebarViewController.view];
    logMessage = [logMessage stringByAppendingFormat:@"\n\t%@", self.rightSidebarView];
    logMessage = [logMessage stringByAppendingFormat:@"\n\t%@", self.navigationController.navigationBar];
    logMessage = [logMessage stringByAppendingFormat:@"\n\t <statusBarFrame> %@", NSStringFromCGRect([[UIApplication sharedApplication] statusBarFrame])];
    logMessage = [logMessage stringByAppendingFormat:@"\n\t <applicationFrame> %@", NSStringFromCGRect([[UIScreen mainScreen] applicationFrame])];
    logMessage = [logMessage stringByAppendingFormat:@"\n\t <preferredViewFrame> %@", NSStringFromCGRect(self.navigationController.applicationViewFrame)];
    logMessage = [logMessage stringByAppendingFormat:@"\n}"];
    return logMessage;
}

#endif

#pragma mark Action

- (void)revealLeftSidebar:(id)sender {
    [self.navigationController toggleRevealState:JTRevealedStateLeft];
}

- (void)revealRightSidebar:(id)sender {
    [self.navigationController toggleRevealState:JTRevealedStateRight];
}

- (void)pushNewViewController:(UIGestureRecognizer *)recognizer {
    NewViewController *controller = [[NewViewController alloc] initWithNibName:@"NewViewController" bundle:nil];
    controller.view.backgroundColor = [UIColor whiteColor];
    controller.title = @"効果";
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.pass_img=((UIImageView *)recognizer.view).image;
    [self.navigationController pushViewController:controller animated:YES];
    [controller setImage:((UIImageView *)recognizer.view).image];
    
}

#pragma mark JTRevealSidebarDelegate

// This is an examle to configure your sidebar view through a custom UIViewController
- (UIView *)viewForLeftSidebar {
    // Use applicationViewFrame to get the correctly calculated view's frame
    // for use as a reference to our sidebar's view
    CGRect viewFrame = self.navigationController.applicationViewFrame;
    UITableView *view = self.leftSidebarView;
    if ( ! view) {
        view = self.leftSidebarView = [[UITableView alloc] initWithFrame:CGRectZero];
        view.dataSource = self;
        view.delegate   = self;
    }
    view.frame = CGRectMake(0, viewFrame.origin.y, 200, viewFrame.size.height);
    view.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleHeight;
    //view.sectionHeaderHeight=45;
    return view;
}

// This is an examle to configure your sidebar view without a UIViewController
- (UIView *)viewForRightSidebar {
    if(self.mode ==@"normal"){
        [self loadPhotosFromGallery];
        CGRect viewFrame = self.navigationController.applicationViewFrame;
        UITableView *view = self.rightSidebarView;
        if ( ! view) {
            view = self.rightSidebarView = [[UITableView alloc] initWithFrame:CGRectZero];
            view.dataSource = self;
            view.delegate   = self;
        }
        view.frame = CGRectMake(self.navigationController.view.frame.size.width - 230, viewFrame.origin.y, 230, viewFrame.size.height);
        view.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleHeight;
        return view;
    }else if(self.mode==@"background"){
        CGRect viewFrame = self.navigationController.applicationViewFrame;
        UITableView *view = self.rightBgSidebarView;
        if ( ! view) {
            view = self.rightBgSidebarView = [[UITableView alloc] initWithFrame:CGRectZero];
            view.dataSource = self;
            view.delegate   = self;
        }
        view.frame = CGRectMake(self.navigationController.view.frame.size.width - 120, viewFrame.origin.y, 160, viewFrame.size.height);
        view.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleHeight;
        return view;
    }else if(self.mode==@"template"){
        CGRect viewFrame = self.navigationController.applicationViewFrame;
        UITableView *view = self.rightTpSidebarView;
        if ( ! view) {
            view = self.rightTpSidebarView = [[UITableView alloc] initWithFrame:CGRectZero];
            view.dataSource = self;
            view.delegate   = self;
        }
        view.frame = CGRectMake(self.navigationController.view.frame.size.width - 200, viewFrame.origin.y, 200, viewFrame.size.height);
        view.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleHeight;
        return view;
    }else if(self.mode==@"item"){
        CGRect viewFrame = self.navigationController.applicationViewFrame;
        UITableView *view = self.rightItemSidebarView;
        if ( ! view) {
            view = self.rightItemSidebarView = [[UITableView alloc] initWithFrame:CGRectZero];
            view.dataSource = self;
            view.delegate   = self;
        }
        view.frame = CGRectMake(self.navigationController.view.frame.size.width - 120, viewFrame.origin.y, 160, viewFrame.size.height);
        view.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleHeight;
        return view;
    }else if(self.mode==@"help"){
        CGRect viewFrame = self.navigationController.applicationViewFrame;
        UITableView *view = self.rightHelpSidebarView;
        if ( ! view) {
            view = self.rightHelpSidebarView = [[UITableView alloc] initWithFrame:CGRectZero];
            view.dataSource = self;
            view.delegate   = self;
        }
        view.frame = CGRectMake(self.navigationController.view.frame.size.width - 290, viewFrame.origin.y, 290, viewFrame.size.height);
        view.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleHeight;
        return view;
    }
}

// Optional delegate methods for additional configuration after reveal state changed
- (void)didChangeRevealedStateForViewController:(UIViewController *)viewController {
    // Example to disable userInteraction on content view while sidebar is revealing
    if (viewController.revealedState == JTRevealedStateNo) {
        self.view.userInteractionEnabled = YES;
    } else {
        self.view.userInteractionEnabled = NO;
    }
}

@end


@implementation ViewController (Private)

#pragma mark UITableViewDatasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(tableView==self.leftSidebarView){
        return 6;
    }else if(tableView==self.rightTpSidebarView){
        return 5;
    }else if(tableView==self.rightHelpSidebarView){
        return 10;
    }else if(tableView==self.rightItemSidebarView){
        return 9;
    }else if(tableView==self.rightBgSidebarView){
        return 29;
    }else{
        return [self.photos count];
    
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if(tableView==self.leftSidebarView){
        return 1;
    }else{
        return 1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    if(tableView==self.rightHelpSidebarView){
        //return 400;
        NSString *text = [helps objectAtIndex:[indexPath row]];
        
        CGSize constraint = CGSizeMake(CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN * 2), 20000.0f);
        
        CGSize size = [text sizeWithFont:[UIFont systemFontOfSize:FONT_SIZE] constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
        
        CGFloat height = MAX(size.height, 44.0f);
        
        return height + (CELL_CONTENT_MARGIN * 2);
    }else{
        return 40;
    }
}

- (CGFloat)tableView:(UITableView *)tableView widthForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    return 270;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"CellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(tableView==self.rightSidebarView){
        if ( ! cell) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        /*NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy"];
        cell.textLabel.text = [NSString stringWithFormat:@"%@",[formatter stringFromDate:[self.dates objectAtIndex:indexPath.row]]];*/
        cell.textLabel.text = [NSString stringWithFormat:@"%d",indexPath.row];
        ALAsset *asset = [self.photos objectAtIndex:([self.photos count]-indexPath.row-1)];
        NSDate *date = [asset valueForProperty:ALAssetPropertyDate];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"]];
        //[dateFormatter setDateFormat:@"EEE, d MMM yyyy HH:mm:ss z"];
        [dateFormatter setDateFormat:@"yyyy年MM月dd日"];
        [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
        //NSDate *date = [NSDate date];
        NSString *dateString = [dateFormatter stringFromDate:date];
        
        //cell.textLabel.text = [NSString stringWithFormat:@"%d", indexPath.row];
        cell.textLabel.text = dateString;
        cell.imageView.image = [UIImage imageWithCGImage:[asset thumbnail]];
        
        
    }else if(tableView == self.rightBgSidebarView){
        if ( ! cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        cell.textLabel.text = [NSString stringWithFormat:@"pat%d.png", indexPath.row+1];
        
        cell.imageView.image = [UIImage imageNamed:cell.textLabel.text];
    }else if(tableView == self.rightTpSidebarView){
        if ( ! cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        cell.textLabel.text = [NSString stringWithFormat:@"テンプレート%d", indexPath.row+1];
        
        cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"temp%d.png", indexPath.row+1]];
    }else if(tableView == self.rightItemSidebarView){
        if ( ! cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        cell.textLabel.text = [NSString stringWithFormat:@"%@", [items objectAtIndex:indexPath.row]];
        
        cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png", [items objectAtIndex:indexPath.row]]];
    }else if(tableView == self.rightHelpSidebarView){
        UILabel *label =nil;
        if ( ! cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
            label = [[UILabel alloc] initWithFrame:CGRectZero];
            [label setLineBreakMode:UILineBreakModeWordWrap];
            [label setMinimumFontSize:FONT_SIZE];
            [label setNumberOfLines:0];
            [label setFont:[UIFont systemFontOfSize:FONT_SIZE]];
            [label setTag:1];
            
            [[cell contentView] addSubview:label];
        }
        
        NSString *text = [helps objectAtIndex:[indexPath row]];
        
        CGSize constraint = CGSizeMake(CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN * 2), 20000.0f);
        
        CGSize size = [text sizeWithFont:[UIFont systemFontOfSize:FONT_SIZE] constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
        
        if (!label)
            label = (UILabel*)[cell viewWithTag:1];
        
        [label setText:text];
        [label setFrame:CGRectMake(CELL_CONTENT_MARGIN, CELL_CONTENT_MARGIN, CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN * 2), MAX(size.height, 44.0f))];
        
        
        //cell.imageView.image = [UIImage imageNamed:cell.textLabel.text];
    }else{
        if ( ! cell) {
            cell =[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        NSString *name = [[self itemName] objectAtIndex:indexPath.row];
        cell.textLabel.text = name;
        cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"menu%d.png", indexPath.row+1]];
    }
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
	NSString *title = nil;
    // Return a title or nil as appropriate for the section.
    
	if (tableView == self.rightSidebarView) {
        title =  @"ギャラリー";
    }else if(tableView == self.rightBgSidebarView) {
        title = @"背景";
    }else if(tableView == self.rightTpSidebarView) {
        title = @"テンプレート";
    }else if(tableView == self.rightItemSidebarView) {
        title = @"アイテム";
    }else if(tableView == self.rightHelpSidebarView) {
        title = @"使い方";
    }else{
        title =  @"メニュー";
    }

	UIView *headerView = nil;
	if (title != nil) {
		headerView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, [UIScreen mainScreen].bounds.size.height, 21.0f)];
		CAGradientLayer *gradient = [CAGradientLayer layer];
		gradient.frame = headerView.bounds;
		gradient.colors = @[
        (id)[UIColor colorWithRed:(0.0f/255.0f) green:(124.0f/255.0f) blue:(54.0f/255.0f) alpha:1.0f].CGColor,
        (id)[UIColor colorWithRed:(0.0f/255.0f) green:(104.0f/255.0f) blue:(82.0f/255.0f) alpha:1.0f].CGColor,
		];
		[headerView.layer insertSublayer:gradient atIndex:0];
		
		UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectInset(headerView.bounds, 12.0f, 5.0f)];
		textLabel.text = title;
		textLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:([UIFont systemFontSize] * 0.8f)];
		textLabel.shadowOffset = CGSizeMake(0.0f, 1.0f);
		textLabel.shadowColor = [UIColor colorWithWhite:0.0f alpha:0.25f];
		textLabel.textColor = [UIColor whiteColor];
		textLabel.backgroundColor = [UIColor clearColor];
		[headerView addSubview:textLabel];
		
		UIView *topLine = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, [UIScreen mainScreen].bounds.size.height, 1.0f)];
		topLine.backgroundColor = [UIColor colorWithRed:(0.0f/255.0f) green:(124.0f/255.0f) blue:(54.0f/255.0f) alpha:1.0f];
		[headerView addSubview:topLine];
		
		UIView *bottomLine = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 21.0f, [UIScreen mainScreen].bounds.size.height, 1.0f)];
		bottomLine.backgroundColor = [UIColor colorWithRed:(0.0f/255.0f) green:(84.0f/255.0f) blue:(65.0f/255.0f) alpha:1.0f];
		[headerView addSubview:bottomLine];
	}
	return headerView;
}

#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.navigationController setRevealedState:JTRevealedStateNo];
    if (tableView == self.rightSidebarView) {
        UIImage *img =[[UIImage alloc] init];
        ALAsset *asset = [self.photos objectAtIndex:([self.photos count]-indexPath.row-1)];
        ALAssetRepresentation *rep = [asset defaultRepresentation];
        CGImageRef iref = [rep fullResolutionImage];
        if (iref) {
            img = [UIImage imageWithCGImage:iref];
            NSData *data=UIImageJPEGRepresentation(img, 0.7);
            img = [UIImage imageWithData:data];
        }
        UIImageView *imgv=[[UIImageView alloc] initWithImage:img];
        imgv.frame=CGRectMake(20,20, 280, (img.size.height/img.size.width)*280);
        [self.view addSubview:imgv];
        imgv.userInteractionEnabled=YES;
        [self AddGes:imgv];
        NSLog(@"%@", NSStringFromCGRect(imgv.frame));
    }else if(tableView == self.rightBgSidebarView) {
        UITableViewCell *cell=[tableView cellForRowAtIndexPath:indexPath];
        self.view.backgroundColor =[UIColor colorWithPatternImage:[UIImage imageNamed:cell.textLabel.text]];
    }else if(tableView == self.rightTpSidebarView) {
        UITableViewCell *cell=[tableView cellForRowAtIndexPath:indexPath];
        for(UIImageView *view in template_points){
            [view removeFromSuperview];
        }
        template_points=[templates objectAtIndex:indexPath.row];
        for(NSInteger i=0;i<[template_points count];i++){
            [self AddGes:[template_points objectAtIndex:i]];
            [self.view addSubview:[template_points objectAtIndex:i]];
        }
    }else if(tableView == self.rightItemSidebarView) {
        UIImage *img =[[UIImage alloc] init];
        img = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png", [items objectAtIndex:indexPath.row]]];
        UITableViewCell *cell=[tableView cellForRowAtIndexPath:indexPath];
        UIImageView *imgv=[[UIImageView alloc] initWithImage:img];
        imgv.frame=CGRectMake(20,20, img.size.width/2, img.size.height/2);
        [self.view addSubview:imgv];
        imgv.userInteractionEnabled=YES;
        [self AddGes2:imgv];
        NSLog(@"%@", NSStringFromCGRect(imgv.frame));
        
    }else if(tableView == self.rightHelpSidebarView) {
        UITableViewCell *cell=[tableView cellForRowAtIndexPath:indexPath];
        
    }else{
        UITableViewCell *cell=[tableView cellForRowAtIndexPath:indexPath];
        if(cell.textLabel.text ==@"背景"){
            self.mode=@"background";
            [self revealRightSidebar:cell];
        }else if (cell.textLabel.text ==@"ギャラリー"){
            self.mode=@"normal";
            [self revealRightSidebar:cell];
        }else if (cell.textLabel.text ==@"テンプレート"){
            self.mode=@"template";
            [self revealRightSidebar:cell];            
        }else if (cell.textLabel.text ==@"アイテム"){
            self.mode=@"item";
            [self revealRightSidebar:cell];
        }else if (cell.textLabel.text ==@"テキスト"){
            UITextField *textf=[[UITextField alloc] init];
            [textf setAutoresizesSubviews:YES];
            
            [textf setBorderStyle:UITextBorderStyleRoundedRect];
            textf.backgroundColor=[UIColor whiteColor];
            textf.background=[UIImage imageNamed:@"txt.gif"];
            textf.font=[UIFont fontWithName:@"Helvetica-Bold" size:([UIFont systemFontSize] * 2.0f)];
            textf.textColor=[UIColor colorWithRed:(0.0f/255.0f) green:(124.0f/255.0f) blue:(54.0f/255.0f) alpha:1.0f];
            textf.frame=CGRectMake(30, 30, 200, 40);
            mytxt=textf;
            [self AddGes3:mytxt];
            [self.view addSubview:mytxt];
            UITapGestureRecognizer * recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backgroundTap:)];
            recognizer.delegate = self;
            [self.view addGestureRecognizer:recognizer];
        }else{
            self.mode=@"help";
            [self revealRightSidebar:cell];
        }
    }
}

- (NSMutableArray *)itemName {
    NSMutableArray * item=[[NSMutableArray alloc] init];
        [item addObject:@"ギャラリー"];
    [item addObject:@"背景"];
    [item addObject:@"テンプレート"];
    [item addObject:@"アイテム"];
    [item addObject:@"テキスト"];
        //[item addObject:@"Facebookに投稿"];
    [item addObject:@"使い方"];
    return item;
}

#pragma mark SidebarViewControllerDelegate

- (void)viewWillAppear:(BOOL)animated
{
    [self loadPhotosFromGallery];
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (IBAction)backgroundTap:(UITapGestureRecognizer *)sender{
    [mytxt resignFirstResponder];
}
- (IBAction)handlePan:(UIPanGestureRecognizer *)recognizer {
    
    // Comment for panning
    // Uncomment for tickling
    //return;
    
    CGPoint translation = [recognizer translationInView:self.view];
    recognizer.view.center = CGPointMake(recognizer.view.center.x + translation.x,
                                         recognizer.view.center.y + translation.y);
    [recognizer setTranslation:CGPointMake(0, 0) inView:self.view];
    
    if (recognizer.state == UIGestureRecognizerStateEnded) {
        
        CGPoint velocity = [recognizer velocityInView:self.view];
        CGFloat magnitude = sqrtf((velocity.x * velocity.x) + (velocity.y * velocity.y));
        CGFloat slideMult = magnitude / 200;
        NSLog(@"magnitude: %f, slideMult: %f", magnitude, slideMult);
        
        float slideFactor = 0.1 * slideMult; // Increase for more of a slide
        CGPoint finalPoint = CGPointMake(recognizer.view.center.x + (velocity.x * slideFactor),
                                         recognizer.view.center.y + (velocity.y * slideFactor));
        finalPoint.x = MIN(MAX(finalPoint.x, 0), self.view.bounds.size.width);
        finalPoint.y = MIN(MAX(finalPoint.y, 0), self.view.bounds.size.height);
                    
            [UIView animateWithDuration:slideFactor*2 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                recognizer.view.center = finalPoint;
            } completion:nil];
    }
    
}

- (IBAction)handlePinch:(UIPinchGestureRecognizer *)recognizer {
    
    recognizer.view.transform = CGAffineTransformScale(recognizer.view.transform, recognizer.scale, recognizer.scale);
    recognizer.scale = 1;
    
}

- (IBAction)handleRotate:(UIRotationGestureRecognizer *)recognizer {
    
    recognizer.view.transform = CGAffineTransformRotate(recognizer.view.transform, recognizer.rotation);
    recognizer.rotation = 0;
}



- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}


- (void)handleLongPress:(UILongPressGestureRecognizer*)sender {
    NSLog(@"...");
    [sender.view removeFromSuperview];
}


- (UIImage*)imageByCropping:(UIImage *)myImage toRect:(CGRect)cropToArea{
    CGImageRef cropImageRef = CGImageCreateWithImageInRect(myImage.CGImage, cropToArea);
    UIImage* cropped = [UIImage imageWithCGImage:cropImageRef];
    
    CGImageRelease(cropImageRef);
    return cropped;
}

- (void)CaptureButton {
    
    NSLog(@"画面キャプチャー開始");
    
    CGImageRef imgRef = UIGetScreenImage();
    UIImage *img = [UIImage imageWithCGImage:imgRef];
    CGImageRelease(imgRef);
    //figure out the dimensions of numberOfLights on bulbs
    CGSize croppedSize = CGSizeMake(640, 870);
    CGRect clippedRect = CGRectMake(0, 130, croppedSize.width, croppedSize.height);
    
    //get the "on" bulbs by cropping the image
    cropped = [self imageByCropping:img toRect:clippedRect];
    UIImageWriteToSavedPhotosAlbum(cropped, nil, nil, nil);
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:
                          @"保存"
                                                    message:
                          @"あなたが作ったポスカードはギャラリーに保存されました。"
                          delegate
                                                           : self cancelButtonTitle:
                          @"了解"
                                          otherButtonTitles: nil];
    
    [alert show];

    
}

- (void)CaptureButton2 {
    
    NSLog(@"画面キャプチャー開始");
    
    CGImageRef imgRef = UIGetScreenImage();
    UIImage *img = [UIImage imageWithCGImage:imgRef];
    CGImageRelease(imgRef);
    //figure out the dimensions of numberOfLights on bulbs
    CGSize croppedSize = CGSizeMake(640, 870);
    CGRect clippedRect = CGRectMake(0, 130, croppedSize.width, croppedSize.height);
    
    //get the "on" bulbs by cropping the image
    cropped = [self imageByCropping:img toRect:clippedRect];
    UIImageWriteToSavedPhotosAlbum(cropped, nil, nil, nil);

}
@end