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


    MapViewController *VC2 = [self.storyboard instantiateViewControllerWithIdentifier:@"MapController"];
    VC2.delegate = self;
//    [self.navigationController pushViewController:viewController animated:YES];
    [self presentViewController:VC2 animated:YES completion:^{
        //  [loadingView startAnimating];
        NSLog(@"completion fired");
    }];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

@end
