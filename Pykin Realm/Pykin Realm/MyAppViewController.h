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

@interface MyAppViewController : UIViewController <ViewController2Delegate>

@property (strong, nonatomic) IBOutlet UIView *mapUIView;
@property (strong, nonatomic) IBOutlet SKView *mapOverlay;
//@property (weak) id <ViewController2Delegate> delegate;
@end
