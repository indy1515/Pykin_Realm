//
//  MyAppViewController.h
//  Pykin Realm
//

//  Copyright (c) 2557 IndyZa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>
#import <GoogleMaps/GoogleMaps.h>
#import "MapViewController.h"
#import <FacebookSDK/FacebookSDK.h>


@interface MyAppViewController : UIViewController <ViewController2Delegate,FBLoginViewDelegate>

@property (strong, nonatomic) IBOutlet UIView *mapUIView;
@property (nonatomic, strong) IBOutlet UIActivityIndicatorView *activityIndicator;

@property (strong, nonatomic) IBOutlet SKView *mapOverlay;
@property (nonatomic, weak) id<ViewController2Delegate>delegate;
//@property (weak) id <ViewController2Delegate> delegate;
@end
