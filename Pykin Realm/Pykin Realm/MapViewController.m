//
//  MapViewController.m
//  Pykin Realm
//
//  Created by IndyZa on 9/22/2557 BE.
//  Copyright (c) 2557 IndyZa. All rights reserved.
//

#import "MapViewController.h"
#import "MapScene.h"
#import <GoogleMaps/GoogleMaps.h>
#import "Shop.h"


@implementation MapViewController{
    GMSMapView *mapView;
    SKView *skView;
    Boolean openMap;
    NSMutableArray *names;
    NSMutableArray *lat;
    NSMutableArray *lng;
    NSMutableArray *type;
    UIImage *rest_icon;
    UIImage *cafe_icon;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initializeArray];
    [self initializeImage];
    // Configure the view.
    
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:13.734875
                                                            longitude:100.532628
                                                                 zoom:16.5];
    mapView = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    mapView.myLocationEnabled = YES;
    mapView.settings.myLocationButton = YES;
    self.view = mapView;
    
    
    // Creates a marker in the center of the map.
//    for(int i = 0; i < );
    NSMutableDictionary* shops = [[NSMutableDictionary alloc] init];
    for(int i = 0;i<[names count];i++){
        [shops setObject:[[Shop alloc] initWithCLLocationCoordinate:CLLocationCoordinate2DMake([lat[i] doubleValue], [lng[i] doubleValue]) name:names[i] type:type[i]] forKey:names[i]];
        Shop *s = shops[names[i]];
        GMSMarker *marker = [[GMSMarker alloc] init];
        NSLog(@"%@",s.type);
        if([s.type isEqualToString:REST]){
            marker.icon = rest_icon;
        }else{
            marker.icon = cafe_icon;
        }
        marker.appearAnimation = kGMSMarkerAnimationPop;
        marker.position = s.latLng;
        marker.title = s.name;
//        marker.snippet = @"Australia";
        marker.map = mapView;
        
    }
    
    
    
    
    
}

- (void) initializeImage{
    
    rest_icon = [UIImage imageNamed:@"icon_resto.png"];
    rest_icon = [self imageWithImage:rest_icon scaledToSize:CGSizeMake(35, 35)];
    cafe_icon = [UIImage imageNamed:@"icon_cafe.png"];
    cafe_icon = [self imageWithImage:cafe_icon scaledToSize:CGSizeMake(35, 35)];
}

- (void) initializeArray{
    
    
    names = [[NSMutableArray alloc] initWithCapacity:0];
    lat = [[NSMutableArray alloc] initWithCapacity:0];
    lng = [[NSMutableArray alloc] initWithCapacity:0];
    type = [[NSMutableArray alloc] initWithCapacity:0];
    
    [names addObject:@"Aksorn Fried Chicken 2"];
    
    [lat addObject:[NSNumber numberWithDouble:13.736928]];
    [lng addObject:[NSNumber numberWithDouble:100.534207]];
    [type addObject:REST];
    
    
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


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

- (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
    //UIGraphicsBeginImageContext(newSize);
    // In next line, pass 0.0 to use the current device's pixel scaling factor (and thus account for Retina resolution).
    // Pass 1.0 to force exact pixel size.
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}
@end
