//
//  MapViewController.m
//  Pykin Realm
//
//  Created by IndyZa on 9/22/2557 BE.
//  Copyright (c) 2557 IndyZa. All rights reserved.
//

#import "MapViewController.h"
#import "MapScene.h"
#import "ShopDetailViewController.h"
#import <GoogleMaps/GoogleMaps.h>
#import "Shop.h"
#import "CustomInfoWindow.h"
#import "RankViewController.h"
#import "ShopListViewController.h"
#import "DetailViewController.h"
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>
#import <FacebookSDK/FacebookSDK.h>
#import <Parse/Parse.h>
#import <ParseFacebookUtils/PFFacebookUtils.h>
#import "ObjectDecoder.h"

@implementation MapViewController{
    GMSMapView *mapView;
    SKView *skView;
    Boolean openMap;
    NSMutableArray *names;
    NSMutableArray *lat;
    NSMutableArray *lng;
    NSMutableArray *type;
    NSMutableArray *objectId;
    NSMutableArray *isCanteen;
    UIImage *rest_icon;
    UIImage *cafe_icon;
    BOOL firstTime;
}


- (void)viewDidLoad
{
    self.userImg.layer.cornerRadius = self.userImg.frame.size.width / 2;
    self.userImg.clipsToBounds = YES;
    self.userImg.layer.borderWidth = 3.0f;
    self.userImg.layer.borderColor = [UIColor whiteColor].CGColor;

    
    [super viewDidLoad];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    
    //Setup first time called out
    firstTime = YES;
    
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:13.73897
                                                            longitude:100.53108
                                                                 zoom:15];
    if([mapView myLocation] != nil){
        camera = [GMSCameraPosition cameraWithLatitude:[mapView myLocation].coordinate.latitude longitude:[mapView myLocation].coordinate.longitude zoom:15];
//        [mapView animateToCameraPosition:[GMSCameraPosition cameraWithTarget:[mapView myLocation].coordinate zoom:16.5f]];
    }

    mapView = [GMSMapView mapWithFrame:self.view.bounds camera:camera];

    mapView.myLocationEnabled = YES;
    mapView.settings.myLocationButton = YES;
    mapView.settings.compassButton = YES;
    
    [self.view insertSubview:mapView atIndex:0];
    
    
    PFObject *testObject = [PFObject objectWithClassName:@"TestObject"];
    testObject[@"foo"] = @"bar";
    [testObject saveInBackground];
    
    [self.pykion setFont:[UIFont fontWithName:@"UGO-COLOR" size:20]];
    
    self.pykion.text = [defaults objectForKey:@"pykoin"];
//    NSArray *check = [UIFont familyNames];
//    NSLog(@"%@",check);
    mapView.delegate = self;
    [self.pykinite setFont:[UIFont fontWithName:@"UGO-COLOR" size:20]];
    self.pykinite.text = [defaults objectForKey:@"pykinite"];
    
    //Check Facebook Session
    if (FBSession.activeSession.isOpen) {
        
        [[FBRequest requestForMe] startWithCompletionHandler:
         ^(FBRequestConnection *connection,
           NSDictionary<FBGraphUser> *user,
           NSError *error) {
             if (!error) {
                 NSString *firstName = user.first_name;
                 NSString *lastName = user.last_name;
                 NSString *facebookId = user.id;
                 NSString *email = [user objectForKey:@"email"];
                 NSString *imageUrl = [[NSString alloc] initWithFormat: @"http://graph.facebook.com/%@/picture?type=large", facebookId];
                 NSLog(@"%@",firstName);
                 self.name.text = [firstName uppercaseString];
                 self.userImg.image = [UIImage imageWithData:
                                       [NSData dataWithContentsOfURL:
                                        [NSURL URLWithString: imageUrl]]];

                 
                 
                 [defaults setObject:facebookId forKey:@"facebookId"];
                 PFQuery *query = [PFQuery queryWithClassName:@"PlayerInfoTest"];
                 query.cachePolicy = kPFCachePolicyNetworkElseCache;
                 [query whereKey:@"facebookId" equalTo:facebookId];
                 [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
                     if (!error) {
                         // The find succeeded.
                         NSLog(@"Successfully retrieved %d users.", objects.count);
                         
                         // Register ID in database for first connection
                         // Check if facebookId exist or not
                         
                         if(objects.count <= 0){
                             // if no create new data (facebookID, firstName,email)
                             // Save facebookId to database and initailize Pykoin
                             PFObject *playerProfile = [PFObject objectWithClassName:@"PlayerInfoTest"];
                             // Default pykoin & pykinite value
                             playerProfile[@"facebookId"] = facebookId;
                             playerProfile[@"user_type"] = @"user";
                             playerProfile[@"email"] = email;
                             playerProfile[@"firstName"] = firstName;
                             [playerProfile saveInBackground];
                             
                             //link with gamedata
                             PFObject *game= [PFObject objectWithClassName:@"PlayerDataTest"];
                             [game setObject:playerProfile forKey:@"createdBy"];
                             
                             //Search
                             PFQuery *gameQuery = [PFQuery queryWithClassName:@"Game"];
                             [gameQuery whereKey:@"createdBy" equalTo:playerProfile];
                             game[@"pykoin"] = @100;
                             game[@"pykinite"] = @20;
                             [game saveInBackground];
                             
                             
                             
                             NSString *user_pykoin = [NSString stringWithFormat:@"%d",[playerProfile[@"pykoin"] intValue] ];
                             NSString *user_pykinite = [NSString stringWithFormat:@"%d",[playerProfile [@"pykinite"] intValue]];
                             self.pykion.text = user_pykoin;
                             self.pykinite.text = user_pykinite;
                             
                         }else{
                             // if yes update name,email and load data
                             // Load Pykinite and Pykoin from server
                             objects.firstObject[@"firstName"] = firstName;
                             [objects.firstObject saveInBackground];
                             
                             // Set Pykinite and Pykoin to Mobile
                             NSString *user_pykoin = [NSString stringWithFormat:@"%d",[objects.firstObject[@"pykoin"] intValue] ];
                             NSString *user_pykinite = [NSString stringWithFormat:@"%d",[objects.firstObject[@"pykinite"] intValue]];
                             self.pykion.text = user_pykoin;
                             self.pykinite.text = user_pykinite;
                             [defaults setObject:user_pykoin forKey:@"pykoin"];
                             [defaults setObject:user_pykinite forKey:@"pykinite"];
                             NSLog(@"Pykoin: %@ Pykinite: %@",user_pykoin,user_pykinite);
                         }
                         // Do something with the found objects
                         for (PFObject *object in objects) {
                             // Print founded object
                             NSLog(@"%@", object.objectId);
                         }
                     } else {
                         // Log details of the failure
                         NSLog(@"Error: %@ %@", error, [error userInfo]);
                     }
                 }];
                 
             }
         }];
    }
    
    
    [self.name setFont:[UIFont fontWithName:@"UGO-COLOR" size:20]];
    
    NSLog(@"Setup");
    
    self.userImg.layer.cornerRadius = self.userImg.frame.size.width / 2;
    self.userImg.clipsToBounds = YES;
    self.userImg.layer.borderWidth = 3.0f;
    self.userImg.layer.borderColor = [UIColor whiteColor].CGColor;
    
    // Creates a marker in the center of the map.
    [self initializeImage];
    [self initializeArrayAndPutMarker];
    
    
    
    
    

    
    
}




- (void)viewDidAppear:(BOOL)animated {
    // This padding will be observed by the mapView
    mapView.padding = UIEdgeInsetsMake(64, 0, 0, 0);
    
    // Invoke when create for first time
    if(firstTime){
        firstTime = NO;
        // Navigate Animation
        if([mapView myLocation] != nil){
            [mapView animateToCameraPosition:[GMSCameraPosition cameraWithTarget:[mapView myLocation].coordinate zoom:16.5f]];
            NSLog(@"Location :%f",[mapView myLocation].coordinate.latitude);
        }else{
            [mapView animateToCameraPosition:[GMSCameraPosition cameraWithTarget:CLLocationCoordinate2DMake(13.73897, 100.53108) zoom:16.5f]];
        }
    }else{
    
    // Invoke update when resume App
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    // Load Pykinite and Pykoin Stats
    self.pykion.text = [defaults objectForKey:@"pykoin"];
    self.pykinite.text = [defaults objectForKey:@"pykinite"];
    PFQuery *query = [PFQuery queryWithClassName:@"PlayerInfo"];
    NSString *facebookId = [defaults objectForKey:@"facebookId"];
    query.cachePolicy = kPFCachePolicyNetworkElseCache;
    [query whereKey:@"facebookId" equalTo:facebookId];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        
        self.pykion.text = [NSString stringWithFormat:@"%d",[objects.firstObject[@"pykoin"] intValue] ];
        self.pykinite.text = [NSString stringWithFormat:@"%d",[objects.firstObject[@"pykinite"] intValue] ];
    }];
    }
    
    
    
    // Load New Star
   
}

- (UIView *) mapView:(GMSMapView *)mapView markerInfoWindow:(GMSMarker *)marker{
    CustomInfoWindow *infoWindow = [[[NSBundle mainBundle] loadNibNamed:@"InfoWindow" owner:self options:nil] objectAtIndex:0 ];
    infoWindow.name.text = marker.title.uppercaseString;
    [infoWindow.name setFont:[UIFont fontWithName:@"UGO-COLOR" size:20]];
//    marker.userData = infoWindow.next;
    return infoWindow;
}

- (void)mapView:(GMSMapView *)mapView didTapInfoWindowOfMarker:(GMSMarker *)marker {
    // your code
    NSLog(@"Press Info Window");
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    ObjectDecoder* stat = [ObjectDecoder decodeData:marker.snippet];
    NSLog(@"id:%@ isCanteen: %@",stat.objectId,stat.isCanteen);
    if([stat.isCanteen isEqual:@"1"]){
        [defaults setObject:stat.objectId forKey:@"currentCanteen"];
        [defaults setObject:self.pykion.text forKey:@"currentMoney"];
        
        [defaults synchronize];
        ShopListViewController *VC2 = [self.storyboard instantiateViewControllerWithIdentifier:@"ShopListViewController"];
        VC2.delegate = self;
        //    VC2.shopTitle.text = marker.title;
        //    pushViewController
        [self presentViewController:VC2 animated:YES completion:^{
            //  [loadingView startAnimating];
            NSLog(@"completion fired");
        }];
    }else{
        [defaults setObject:stat.objectId forKey:@"currentShop"];
        ShopDetailViewController *VC2 = [self.storyboard instantiateViewControllerWithIdentifier:@"ShopDetailViewController"];
        VC2.delegate = self;
        //    VC2.shopTitle.text = marker.title;
        //    pushViewController
        [self presentViewController:VC2 animated:YES completion:^{
            //  [loadingView startAnimating];
            NSLog(@"completion fired");
        }];
        [defaults synchronize];
    }
    
    
    
//    DetailViewController *viewController = [[DetailViewController alloc] init];
//    [self.navigationController pushViewController:viewController animated:YES];
    
    
    
    NSLog(@"%@",marker.userData);
}
- (void) createMarker{
    NSMutableDictionary* shops = [[NSMutableDictionary alloc] init];
    NSLog(@"Initiate Value");
    for(int i = 0;i<[names count];i++){
        [shops setObject:[[Shop alloc] initWithCLLocationCoordinate:CLLocationCoordinate2DMake([lat[i] doubleValue], [lng[i] doubleValue]) name:names[i] type:type[i] objectId:objectId[i] isCanteen:isCanteen[i]] forKey:names[i]];
        Shop *s = shops[names[i]];
        GMSMarker *marker = [[GMSMarker alloc] init];
        NSLog(@"Create Marker: %@",s.isCanteen);
        if([s.type isEqualToString:REST]){
            marker.icon = rest_icon;
        }else{
            marker.icon = cafe_icon;
        }
        marker.appearAnimation = kGMSMarkerAnimationPop;
        marker.position = s.latLng;
        marker.title = s.name;
         marker.snippet = [ObjectDecoder codeData:s.objectId isCanteen:s.isCanteen];
        marker.infoWindowAnchor = CGPointMake(0.44f, 0.45f);
        //        marker.snippet = @"Australia";
        marker.map = mapView;
        [self mapView:mapView markerInfoWindow:marker];
        
    }
}



- (void) initializeImage{
    
    rest_icon = [UIImage imageNamed:@"icon_resto.png"];
    rest_icon = [self imageWithImage:rest_icon scaledToSize:CGSizeMake(35, 35)];
    cafe_icon = [UIImage imageNamed:@"icon_cafe.png"];
    cafe_icon = [self imageWithImage:cafe_icon scaledToSize:CGSizeMake(35, 35)];
}

- (void) initializeArrayAndPutMarker{
    names = [[NSMutableArray alloc] initWithCapacity:0];
    lat = [[NSMutableArray alloc] initWithCapacity:0];
    lng = [[NSMutableArray alloc] initWithCapacity:0];
    type = [[NSMutableArray alloc] initWithCapacity:0];
    objectId = [[NSMutableArray alloc] initWithCapacity:0];
    isCanteen = [[NSMutableArray alloc] initWithCapacity:0];
    PFQuery *query = [PFQuery queryWithClassName:@"Canteen"];
    query.cachePolicy = kPFCachePolicyNetworkElseCache;
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            
            if(objects.count <= 0){
                // Not Exist Canteen
                NSLog(@"No Canteen");
            }else{
                // Canteen Found!
                NSLog(@"Canteen Found!");
                for (PFObject *object in objects) {
                    // Print founded object
                    NSLog(@"%@", object.objectId);
                    [names addObject:object[@"name"]];
                    NSLog(@"Name: %@",object[@"name"]);
                    [lat addObject:[NSNumber numberWithDouble:[object[@"lat"] doubleValue]] ];
                    NSLog(@"Lat: %@",[NSNumber numberWithDouble:[object[@"lat"] doubleValue]]);
                    [lng addObject:[NSNumber numberWithDouble:[object[@"lng"] doubleValue]]];
                    NSLog(@"Lng: %@",[NSNumber numberWithDouble:[object[@"lng"] doubleValue]]);
                    [objectId addObject:object.objectId];
                    [type addObject:REST];
                    [isCanteen addObject:@"1"];

                }
                
                //                    NSString *user_pykoin = [NSString stringWithFormat:@"%d",[playerProfile[@"pykoin"] intValue] ];
                //                    NSString *user_pykinite = [NSString stringWithFormat:@"%d",[playerProfile [@"pykinite"] intValue]];
                //                    self.pykion.text = user_pykoin;
                //                    self.pykinite.text = user_pykinite;
            }
            
            //Create Shop Marker with no pointer
            PFQuery *queryShop = [PFQuery queryWithClassName:@"ShopData"];
            queryShop.cachePolicy = kPFCachePolicyNetworkElseCache;
            [queryShop whereKeyDoesNotExist:@"canteen"];
            [queryShop findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
                if (!error) {
                    
                    if(objects.count <= 0){
                        // Not Exist Canteen
                        NSLog(@"No Shop");
                    }else{
                        // Shops Found!
                        NSLog(@"Shops Found!");
                        for (PFObject *object in objects) {
                            // Print founded object
                            NSLog(@"%@", object.objectId);
                            [names addObject:object[@"name"]];
                            NSLog(@"Name: %@",object[@"name"]);
                            [lat addObject:[NSNumber numberWithDouble:[object[@"lat"] doubleValue]] ];
                            NSLog(@"Lat: %@",[NSNumber numberWithDouble:[object[@"lat"] doubleValue]]);
                            [lng addObject:[NSNumber numberWithDouble:[object[@"lng"] doubleValue]]];
                            NSLog(@"Lng: %@",[NSNumber numberWithDouble:[object[@"lng"] doubleValue]]);
                            [objectId addObject:object.objectId];
                            [type addObject:REST];
                            [isCanteen addObject:@"0"];
                            
                        }
                        
                    }
                    [self createMarker];
                }
            }];
            
            // Do something with the found objects
            
            
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];

    
//    names = [[NSMutableArray alloc] initWithCapacity:0];
//    lat = [[NSMutableArray alloc] initWithCapacity:0];
//    lng = [[NSMutableArray alloc] initWithCapacity:0];
//    type = [[NSMutableArray alloc] initWithCapacity:0];
//    
//    [names addObject:@"Aksorn Fried Chicken 2"];
//    [lat addObject:[NSNumber numberWithDouble:13.736928]];
//    [lng addObject:[NSNumber numberWithDouble:100.534207]];
//    [type addObject:REST];

    
    
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
