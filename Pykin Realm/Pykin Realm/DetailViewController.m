//
//  ViewController.m
//  Checkin
//
//  Created by F1RSTst on 9/22/57 BE.
//  Copyright (c) 2557 ___FULLUSERNAME___. All rights reserved.
//

#import "MyAppViewController.h"
#import "DetailViewController.h"
#import "MapViewController.h"
#import <Parse/Parse.h>

@interface DetailViewController (){

}

@end

@implementation DetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.checkin setEnabled:YES];
    
    [self.pykion setFont:[UIFont fontWithName:@"UGO-COLOR" size:20]];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    self.pykion.text = [defaults objectForKey:@"currentMoney"];
    PFQuery *query = [PFQuery queryWithClassName:@"PlayerInfo"];
    query.cachePolicy = kPFCachePolicyNetworkElseCache;
    NSString *facebookId = [defaults objectForKey:@"facebookId"];
    [query whereKey:@"facebookId" equalTo:facebookId];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            NSLog(@"Successfully retrieved %d users.", objects.count);
            
            // Register ID in database for first connection
            // Check if facebookId exist or not
            
            if(objects.count <= 0){
                MyAppViewController *VC2 = [self.storyboard instantiateViewControllerWithIdentifier:@"MyAppViewController"];
                VC2.delegate = self;
                //    pushViewController
                [self presentViewController:VC2 animated:YES completion:^{
                    //  [loadingView startAnimating];
                    NSLog(@"completion fired");
                }];
            }else{
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
    [self.pykinite setFont:[UIFont fontWithName:@"UGO-COLOR" size:20]];
//    self.pykinite.text = @"20";
    
    [self.name setFont:[UIFont fontWithName:@"UGO-COLOR" size:20]];
    self.name.text = @"VAREE";
    NSLog(@"Setup");
    
    self.userImg.layer.cornerRadius = self.userImg.frame.size.width / 2;
    self.userImg.clipsToBounds = YES;
    self.userImg.layer.borderWidth = 3.0f;
    self.userImg.layer.borderColor = [UIColor whiteColor].CGColor;
    
    
    ///
    NSString *title =[defaults objectForKey:@"currentTitle"];
    self.shopTitle.text = title.uppercaseString;
    [self.shopTitle setFont:[UIFont fontWithName:@"UGO-COLOR" size:20]];
    [self.recommend setFont:[UIFont fontWithName:@"UGO-COLOR" size:17]];
    [self.list setFont:[UIFont fontWithName:@"UGO-COLOR" size:17]];
    [self.list2 setFont:[UIFont fontWithName:@"UGO-COLOR" size:17]];
    [self.priceDetail setFont:[UIFont fontWithName:@"UGO-COLOR" size:17]];
    [self.priceTitle setFont:[UIFont fontWithName:@"UGO-COLOR" size:17]];
    
    
    
	// Do any additional setup after loading the view, typically from a nib.
}

- (BOOL)shouldAutorotate
{
    return NO;
}

- (IBAction)backButtonPressed:(id)sender {

    [self dismissViewControllerAnimated:true completion:^{
        //  [loadingView startAnimating];
        NSLog(@"completion fired");
    }];


}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)checkIn:(id)sender {
    // Set send update to pykoin and pykinite
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    // Update Database
    // Update UI
    
    NSString *facebookId = [defaults objectForKey:@"facebookId"];
    PFQuery *query = [PFQuery queryWithClassName:@"PlayerInfo"];
    [query whereKey:@"facebookId" equalTo:facebookId];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            NSLog(@"Successfully retrieved %d users.", objects.count);
            
            // Register ID in database for first connection
            // Check if facebookId exist or not
            if(objects.count <= 0){
                MyAppViewController *VC2 = [self.storyboard instantiateViewControllerWithIdentifier:@"MyAppViewController"];
                VC2.delegate = self;
                //    pushViewController
                [self presentViewController:VC2 animated:YES completion:^{
                    //  [loadingView startAnimating];
                    NSLog(@"completion fired");
                }];
            }else{
                // Set Pykinite and Pykoin to Mobile
                [objects.firstObject incrementKey:@"pykoin" byAmount:[NSNumber numberWithInt:5]];
                [objects.firstObject saveInBackground];
                NSString *user_pykoin = [NSString stringWithFormat:@"%d",[objects.firstObject[@"pykoin"] intValue]];
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

    
    
    [self.checkin setImage:[UIImage imageNamed:@"checkedin_bar.png"] forState:UIControlStateNormal];
    [self.star1 setImage:[UIImage imageNamed:@"icon_star1.png"] ];
    [self.checkin setEnabled:NO];
    
}

@end
