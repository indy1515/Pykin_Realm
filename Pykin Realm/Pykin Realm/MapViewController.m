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
#import "CustomInfoWindow.h"

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
    mapView = [GMSMapView mapWithFrame:self.view.bounds camera:camera];
    
    mapView.myLocationEnabled = YES;
    mapView.settings.myLocationButton = YES;
    mapView.settings.compassButton = YES;
    
    [self.view insertSubview:mapView atIndex:0];
    [self.pykion setFont:[UIFont fontWithName:@"UGO-COLOR" size:20]];
    self.pykion.text = @"100";  
//    NSArray *check = [UIFont familyNames];
//    NSLog(@"%@",check);
    mapView.delegate = self;
    [self.pykinite setFont:[UIFont fontWithName:@"UGO-COLOR" size:20]];
    self.pykinite.text = @"20";
    
    [self.name setFont:[UIFont fontWithName:@"UGO-COLOR" size:20]];
    self.name.text = @"VAREE";
    NSLog(@"Setup");
    
    self.userImg.layer.cornerRadius = self.userImg.frame.size.width / 2;
    self.userImg.clipsToBounds = YES;
    self.userImg.layer.borderWidth = 3.0f;
    self.userImg.layer.borderColor = [UIColor whiteColor].CGColor;
    
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
        marker.infoWindowAnchor = CGPointMake(0.44f, 0.45f);
//        marker.snippet = @"Australia";
        marker.map = mapView;
        [self mapView:mapView markerInfoWindow:marker];
        
    }
    
    
    
    
    
}


- (void)viewDidAppear:(BOOL)animated {
    // This padding will be observed by the mapView
    mapView.padding = UIEdgeInsetsMake(64, 0, 0, 0);
}

- (UIView *) mapView:(GMSMapView *)mapView markerInfoWindow:(GMSMarker *)marker{
    CustomInfoWindow *infoWindow = [[[NSBundle mainBundle] loadNibNamed:@"InfoWindow" owner:self options:nil] objectAtIndex:0 ];
    infoWindow.name.text = marker.title.uppercaseString;
    [infoWindow.name setFont:[UIFont fontWithName:@"UGO-COLOR" size:20]];
    
    return infoWindow;
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

    [names addObject:@"Rujisri"];
    [lat addObject:[NSNumber numberWithDouble:13.736867]];
    [lng addObject:[NSNumber numberWithDouble:100.524193]];
    [type addObject:REST];
    
    [names addObject:@"Today Steak"];
    [lat addObject:[NSNumber numberWithDouble:13.736838]];
    [lng addObject:[NSNumber numberWithDouble:100.534175]];
    [type addObject:REST];
    
    [names addObject:@"Parabola"];
    [lat addObject:[NSNumber numberWithDouble:13.736744]];
    [lng addObject:[NSNumber numberWithDouble:100.534117]];
    [type addObject:CAFE];
    
    [names addObject:@"Tam-Sung"];
    [lat addObject:[NSNumber numberWithDouble:13.733704]];
    [lng addObject:[NSNumber numberWithDouble:100.531844]];
    [type addObject:REST];
    
    [names addObject:@"Nam-Pun"];
    [lat addObject:[NSNumber numberWithDouble:13.733619]];
    [lng addObject:[NSNumber numberWithDouble:100.531835]];
    [type addObject:CAFE];
    
    [names addObject:@"Noodle Tomyum"];
    [lat addObject:[NSNumber numberWithDouble:13.733759]];
    [lng addObject:[NSNumber numberWithDouble:100.531856]];
    [type addObject:REST];
    
    [names addObject:@"Som-Tum"];
    [lat addObject:[NSNumber numberWithDouble:13.733758]];
    [lng addObject:[NSNumber numberWithDouble:100.531856]];
    [type addObject:REST];
    
    [names addObject:@"Snack Bar"];
    [lat addObject:[NSNumber numberWithDouble:13.739169]];
    [lng addObject:[NSNumber numberWithDouble:100.534590]];
    [type addObject:CAFE];
    
    [names addObject:@"Drinks no.1"];
    [lat addObject:[NSNumber numberWithDouble:13.739096]];
    [lng addObject:[NSNumber numberWithDouble:100.534581]];
    [type addObject:CAFE];
    
    [names addObject:@"Noodle Tomyum"];
    [lat addObject:[NSNumber numberWithDouble:13.739093]];
    [lng addObject:[NSNumber numberWithDouble:100.534588]];
    [type addObject:REST];
    
    [names addObject:@"Rice & Curry"];
    [lat addObject:[NSNumber numberWithDouble:13.739049]];
    [lng addObject:[NSNumber numberWithDouble:100.534584]];
    [type addObject:REST];
    
    [names addObject:@"Aksorn Fried Chicken 1"];
    [lat addObject:[NSNumber numberWithDouble:13.739002]];
    [lng addObject:[NSNumber numberWithDouble:100.534578]];
    [type addObject:REST];
    
    [names addObject:@"Rice & Curry 2"];
    [lat addObject:[NSNumber numberWithDouble:13.738997]];
    [lng addObject:[NSNumber numberWithDouble:100.534572]];
    [type addObject:REST];
    
    [names addObject:@"Islamic a lar carte"];
    [lat addObject:[NSNumber numberWithDouble:13.738979]];
    [lng addObject:[NSNumber numberWithDouble:100.534563]];
    [type addObject:REST];
    
    [names addObject:@"Drinks no.2"];
    [lat addObject:[NSNumber numberWithDouble:13.738939]];
    [lng addObject:[NSNumber numberWithDouble:100.534553]];
    [type addObject:CAFE];
    
    [names addObject:@"Cafe"];
    [lat addObject:[NSNumber numberWithDouble:13.739917]];
    [lng addObject:[NSNumber numberWithDouble:100.531084]];
    [type addObject:CAFE];
    
    [names addObject:@"Noodles"];
    [lat addObject:[NSNumber numberWithDouble:13.739912]];
    [lng addObject:[NSNumber numberWithDouble:100.531109]];
    [type addObject:REST];
    
    [names addObject:@"Up to you 1"];
    [lat addObject:[NSNumber numberWithDouble:13.739903]];
    [lng addObject:[NSNumber numberWithDouble:100.531163]];
    [type addObject:REST];
    
    [names addObject:@"Up 2 you 2"];
    [lat addObject:[NSNumber numberWithDouble:13.739906]];
    [lng addObject:[NSNumber numberWithDouble:100.531169]];
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
