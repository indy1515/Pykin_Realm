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

@implementation MyAppViewController{
    GMSMapView *mapView;
    SKView *skView;
    Boolean openMap;
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];

    // Configure the view.
    
    skView = (SKView *)self.mapUIView;
    skView.showsFPS = YES;
    skView.showsNodeCount = YES;
    
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(updateMapViewController:)
                                                 name:@"toMapSceneNotification"
                                               object:nil];
    // Create and configure the scene.
    SKScene * scene = [MyAppMyScene sceneWithSize:CGSizeMake(skView.bounds.size.width*2,skView.bounds.size.height*2)];
    scene.scaleMode = SKSceneScaleModeAspectFill;
    
    
    [skView presentScene:scene];
//    [self.view addSubview:skView];
//    skView.layer.zPosition = MAXFLOAT;
//        mapView.alpha = 1;
    
    
    
}




- (BOOL)shouldAutorotate
{
    return YES;
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
    // Present the scene.
    // Create a GMSCameraPosition that tells the map to display the
    // coordinate -33.86,151.20 at zoom level 6.
//    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:-33.86
//                                                            longitude:151.20
//                                                                 zoom:6];
//    mapView = [GMSMapView mapWithFrame:CGRectZero camera:camera];
//    mapView.myLocationEnabled = YES;
//    self.view = mapView;
//    
//    // Creates a marker in the center of the map.
//    GMSMarker *marker = [[GMSMarker alloc] init];
//    marker.position = CLLocationCoordinate2DMake(-33.86, 151.20);
//    marker.title = @"Sydney";
//    marker.snippet = @"Australia";
//    marker.map = mapView;
//    [self.navigationController pushViewController:vc2]
    MapViewController *viewController = [[MapViewController alloc] init];
    UIViewController *vc = self.view.window.rootViewController;
    [vc presentViewController:viewController animated:YES completion:nil];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

@end
