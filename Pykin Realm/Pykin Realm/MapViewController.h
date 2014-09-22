//
//  MapViewController.h
//  Pykin Realm
//
//  Created by IndyZa on 9/22/2557 BE.
//  Copyright (c) 2557 IndyZa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>
#import <GoogleMaps/GoogleMaps.h>

@interface MapViewController : UIViewController <GMSMapViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *UpperContainer;
@property (weak, nonatomic) IBOutlet UILabel *pykion;
@property (weak, nonatomic) IBOutlet UILabel *pykinite;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UIImageView *userImg;

@end
