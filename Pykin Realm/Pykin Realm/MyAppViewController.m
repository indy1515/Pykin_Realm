//
//  MyAppViewController.m
//  Pykin Realm
//
//  Created by IndyZa on 9/21/2557 BE.
//  Copyright (c) 2557 IndyZa. All rights reserved.
//

#import "MyAppViewController.h"
#import "MyAppMyScene.h"
#import "MapViewController.h"
#import <GoogleMaps/GoogleMaps.h>
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>
#import <FacebookSDK/FacebookSDK.h>

@implementation MyAppViewController{
    GMSMapView *mapView;
    SKView *skView;
    Boolean openMap;
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    NSLog(@"Session open: %s",FBSession.activeSession.isOpen?"true":"false");
    // Configure the view.
    
    skView = (SKView *)self.mapUIView;
//    skView.showsFPS = YES;
//    skView.showsNodeCount = YES;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setObject:@"100" forKey:@"currentMoney"];
    [defaults synchronize];
    
    NSLog(@"Session open2: %s",FBSession.activeSession.isOpen?"true":"false");
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(updateMapViewController:)
                                                 name:@"toMapSceneNotification"
                                               object:nil];
    // Create and configure the scene.
    SKScene * scene = [MyAppMyScene sceneWithSize:CGSizeMake(skView.bounds.size.width*2,skView.bounds.size.height*2)];
    scene.scaleMode = SKSceneScaleModeAspectFill;
    FBLoginView *loginView = [[FBLoginView alloc] init];
    // In your viewDidLoad method:
    loginView.readPermissions = @[@"public_profile", @"email", @"user_friends"];
    loginView.center = CGPointMake(CGRectGetMidX(skView.frame), CGRectGetMidY(skView.frame)*7/4);
    loginView.delegate = self;
    NSLog(@"Session open3: %s",FBSession.activeSession.isOpen?"true":"false");
    if (FBSession.activeSession.isOpen) {
        [self toMapViewController];
    }else{
    NSLog(@"%f",CGRectGetMidY(skView.frame));
    [self.view addSubview:loginView];
    }
    [skView presentScene:scene];
//    [self.view addSubview:skView];
//    skView.layer.zPosition = MAXFLOAT;
//        mapView.alpha = 1;
    
    
    
}

- (void)loginViewFetchedUserInfo:(FBLoginView *)loginView
                            user:(id<FBGraphUser>)user {
    // user variable = user data contain id, name
    [self toMapViewController];
}


// Handle possible errors that can occur during login
- (void)loginView:(FBLoginView *)loginView handleError:(NSError *)error {
    NSString *alertMessage, *alertTitle;
    
    // If the user should perform an action outside of you app to recover,
    // the SDK will provide a message for the user, you just need to surface it.
    // This conveniently handles cases like Facebook password change or unverified Facebook accounts.
    if ([FBErrorUtility shouldNotifyUserForError:error]) {
        alertTitle = @"Facebook error";
        alertMessage = [FBErrorUtility userMessageForError:error];
        
        // This code will handle session closures that happen outside of the app
        // You can take a look at our error handling guide to know more about it
        // https://developers.facebook.com/docs/ios/errors
    } else if ([FBErrorUtility errorCategoryForError:error] == FBErrorCategoryAuthenticationReopenSession) {
        alertTitle = @"Session Error";
        alertMessage = @"Your current session is no longer valid. Please log in again.";
        
        // If the user has cancelled a login, we will do nothing.
        // You can also choose to show the user a message if cancelling login will result in
        // the user not being able to complete a task they had initiated in your app
        // (like accessing FB-stored information or posting to Facebook)
    } else if ([FBErrorUtility errorCategoryForError:error] == FBErrorCategoryUserCancelled) {
        NSLog(@"user cancelled login");
        
        // For simplicity, this sample handles other errors with a generic message
        // You can checkout our error handling guide for more detailed information
        // https://developers.facebook.com/docs/ios/errors
    } else {
        alertTitle  = @"Something went wrong";
        alertMessage = @"Please try again later.";
        NSLog(@"Unexpected error:%@", error);
    }
    
    if (alertMessage) {
        [[[UIAlertView alloc] initWithTitle:alertTitle
                                    message:alertMessage
                                   delegate:nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil] show];
    }
}

- (BOOL)shouldAutorotate
{
    return NO;
}

- (NSUInteger)supportedInterfaceOrientations
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    } else {
        return UIInterfaceOrientationMaskAll;
    }
}


- (void) updateMapViewController:(NSNotification *)note {
    NSDictionary * info = note.userInfo;
    BOOL shouldHide = [info[@"shouldHide"]boolValue];
    
    if (shouldHide) {
        NSLog(@"shouldHide");
//        [self hideBannerView];
    }
    else {
        NSLog(@"shouldShow");
        openMap = true;
        [self toMapViewController];
    }
}
- (void)toMapViewController{


    MapViewController *VC2 = [self.storyboard instantiateViewControllerWithIdentifier:@"MapController"];
    VC2.delegate = self;
//    [self.navigationController pushViewController:viewController animated:YES];
    [self presentViewController:VC2 animated:YES completion:^{
        //  [loadingView startAnimating];
        // Configure the view.
        
        NSLog(@"completion fired");
    }];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

@end
