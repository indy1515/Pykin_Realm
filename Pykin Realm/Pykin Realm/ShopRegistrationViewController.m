//
//  ShopRegistrationViewController.m
//  Pykin Realms
//
//  Created by IndyZa on 11/24/2557 BE.
//  Copyright (c) 2557 IndyZa. All rights reserved.
//

#import "ShopRegistrationViewController.h"
#import <Parse/Parse.h>
#import <ParseFacebookUtils/PFFacebookUtils.h>

@interface ShopRegistrationViewController (){
    NSArray *_pickerData;
    NSData *imageData ;
}


@end

@implementation ShopRegistrationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
 
    _pickerData = @[@"REST", @"CAFE"];
    // Connect data
    self.pickerType.dataSource = self;
    self.pickerType.delegate = self;
    [self.view endEditing:YES];
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
    NSString *shopname = _shopnameField.text;
    NSString *lat = _latField.text;
    NSString *lng = _lngField.text;
    NSString *type = [self pickerView:_pickerType titleForRow:[_pickerType selectedRowInComponent:0] forComponent:0];
    NSLog(@"Type: %@",type);
    NSString *recommend1 = _recFoodField1.text;
    NSString *recommend2 = _recFoodField2.text;
    NSString *priceMin = _priceMinField.text;
    NSString *priceMax = _priceMaxField.text;
    if([shopname isEqual:@""]||[lat isEqual:@""]||[lng isEqual:@""]||[type isEqual:@""]||[recommend1 isEqual:@""]||[priceMin isEqual:@""]||[priceMax isEqual:@""]||imageData == nil){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Please Fill in the Value"
                                                        message:@"Some Value are missing!"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    if(![canteen  isEqual: @""]){
        NSLog(@"Canteen: %@",canteen);
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
                    NSLog(@"No Canteen");
                }else{
                    // Existing canteen data in database
                    PFObject *canteenInfo = objects.firstObject;
                    NSLog(@"First Object: %@",canteenInfo[@"name"]);
                    //link with gamedata
                    PFObject *shopData= [PFObject objectWithClassName:@"ShopData"];
                    
                    
                    // Search Not Used
//                    PFQuery *gameQuery = [PFQuery queryWithClassName:@"Game"];
//                    [gameQuery whereKey:@"canteen" equalTo:canteenInfo];
                    shopData[@"name"] = shopname;
                    shopData[@"lat"] = @([lat doubleValue]);
                    shopData[@"lng"] = @([lng doubleValue]);
                    shopData[@"type"] = type;
                    shopData[@"recommend1"]=recommend1;
                    shopData[@"recommend2"]=recommend2;
                    shopData[@"priceMin"]= @([priceMin intValue]);
                    shopData[@"priceMax"]= @([priceMax intValue]);
                    [shopData setObject:canteenInfo forKey:@"canteen"];
                    [shopData setObject:imageData forKey:@"image"];
                    
                    [shopData saveInBackground];
                    
                    for (PFObject *object in objects) {
                              // Print founded object
                              NSLog(@"%@", object.objectId);
                    }
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Done Uploading Shop"
                                                                    message:@"You have successfully uploaded"
                                                                   delegate:nil
                                                          cancelButtonTitle:@"OK"
                                                          otherButtonTitles:nil];
                    [alert show];
                    //                    NSString *user_pykoin = [NSString stringWithFormat:@"%d",[playerProfile[@"pykoin"] intValue] ];
                    //                    NSString *user_pykinite = [NSString stringWithFormat:@"%d",[playerProfile [@"pykinite"] intValue]];
                    //                    self.pykion.text = user_pykoin;
                    //                    self.pykinite.text = user_pykinite;
                }
                // Do something with the found objects
                
            } else {
                // Log details of the failure
                NSLog(@"Error: %@ %@", error, [error userInfo]);
            }
        }];

    }else{
        // No Canteen
        PFQuery *query = [PFQuery queryWithClassName:@"ShopData"];
        query.cachePolicy = kPFCachePolicyNetworkElseCache;
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error){
            PFObject *shopData= [PFObject objectWithClassName:@"ShopData"];
            
            // Search Not Used
            //                    PFQuery *gameQuery = [PFQuery queryWithClassName:@"Game"];
            //                    [gameQuery whereKey:@"createdBy" equalTo:playerProfile];
            shopData[@"name"] = shopname;
            shopData[@"lat"] = @([lat doubleValue]);
            shopData[@"lng"] = @([lng doubleValue]);
            shopData[@"type"] = type;
            shopData[@"recommend1"]=recommend1;
            shopData[@"recommend2"]=recommend2;
            shopData[@"priceMin"]= @([priceMin intValue]);
            shopData[@"priceMax"]= @([priceMax intValue]);
            [shopData setObject:imageData forKey:@"image"];
            [shopData saveInBackground];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Done Uploading Shop"
                                                            message:@"You have successfully uploaded"
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
        }];
    }
   
//    [alert release];
    
    
    
}
- (IBAction)clickUpload:(id)sender {
    // Check for camera
    UIImagePickerController * picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    
    

    [self presentModalViewController:picker animated:YES];
}
- (IBAction)clickCamera:(id)sender {
    UIImagePickerController * picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
     picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    [self presentModalViewController:picker animated:YES];
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissModalViewControllerAnimated:YES];
    UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];;
    // Resize image
    UIGraphicsBeginImageContext(CGSizeMake(640, 960));
    [image drawInRect: CGRectMake(0, 0, 640, 960)];
    UIImage *smallImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    imageData = UIImageJPEGRepresentation(smallImage, 0.05f);
}

// The number of columns of data
- (int)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// The number of rows of data
- (int)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return _pickerData.count;
}

// The data to return for the row and component (column) that's being passed in
- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return _pickerData[row];
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
