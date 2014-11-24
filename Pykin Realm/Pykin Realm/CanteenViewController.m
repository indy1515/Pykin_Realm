//
//  CanteenViewController.m
//  Pykin Realms
//
//  Created by IndyZa on 11/24/2557 BE.
//  Copyright (c) 2557 IndyZa. All rights reserved.
//

#import "CanteenViewController.h"
#import <Parse/Parse.h>
#import <ParseFacebookUtils/PFFacebookUtils.h>

@interface CanteenViewController ()

@end

@implementation CanteenViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"Here");
    [self.view endEditing:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)clickSubmit:(id)sender {
    NSString *canteen = _canteenField.text;
    NSString *canteenShort = _canteenshortField.text;
    NSString *lat = _latField.text;
    NSString *lng = _lngField.text;
    
    PFQuery *query = [PFQuery queryWithClassName:@"Canteen"];
    query.cachePolicy = kPFCachePolicyNetworkElseCache;
    [query whereKey:@"name" equalTo:canteen];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            //                NSLog(@"Successfully retrieved %d users.", objects.count);
            
            // Register ID in database for first connection
            // Check if canteen exist or not
            
            if(objects.count <= 0){
                // Not Exist Canteen
                NSLog(@"No Canteen..Create New One");
                // Create New One
                PFObject *canteenInfo = [PFObject objectWithClassName:@"Canteen"];
                
                // Search Not Used
                //                    PFQuery *gameQuery = [PFQuery queryWithClassName:@"Game"];
                //                    [gameQuery whereKey:@"createdBy" equalTo:playerProfile];
                canteenInfo[@"name"] = canteen;
                canteenInfo[@"shortname"] = canteenShort;
                canteenInfo[@"lat"] = @([lat doubleValue]);
                canteenInfo[@"lng"] = @([lng doubleValue]);
                [canteenInfo saveInBackground];
                
            }else{
                // Existing canteen data in database
                // Update
                PFObject *canteenInfo = objects.firstObject;
                canteenInfo[@"lat"] = @([lat doubleValue]);
                canteenInfo[@"lng"] = @([lng doubleValue]);
                [canteenInfo saveInBackground];
                
            }
            // Do something with the found objects
            for (PFObject *object in objects) {
                // Print founded object
                NSLog(@"%@", object.objectId);
            }
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Done Uploading Canteen"
                                                            message:@"You have successfully uploaded"
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
