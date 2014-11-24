//
//  ShopListViewController.m
//  Pykin Realms
//
//  Created by IndyZa on 11/24/2557 BE.
//  Copyright (c) 2557 IndyZa. All rights reserved.
//

#import "ShopListViewController.h"
#import "CustomShopViewCell.h"
#import <Parse/Parse.h>
#import "ImageCrop.h"
#import "math.h"
@interface ShopListViewController ()

@end

@implementation ShopListViewController
{
    NSMutableArray *restaurant;
    NSMutableArray *star;
    NSMutableArray *background;
    NSMutableArray *objectId;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    

    
    // Initialize table data
    restaurant = [[NSMutableArray alloc] initWithCapacity:0];
    star = [[NSMutableArray alloc] initWithCapacity:0];
    background = [[NSMutableArray alloc] initWithCapacity:0];
    objectId = [[NSMutableArray alloc] initWithCapacity:0];
    self.tableView.separatorColor = [UIColor clearColor];
    
//    restaurant = [NSMu arrayWithObjects:@"Destruction Ham",@"Ham of WTF",nil];
//    star = [NSArray arrayWithObjects:@2,@4,nil];
//    background = [NSArray arrayWithObjects:[UIImage imageNamed:@"mahit.png"],[UIImage imageNamed:@"mahit.png"],nil];
    
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *objectIdCanteen = [defaults objectForKey:@"currentCanteen"];
    
//    _tableView.separatorColor = [UIColor clearColor];
    //Load Shop data
    PFQuery *query = [PFQuery queryWithClassName:@"ShopData"];
    query.cachePolicy = kPFCachePolicyNetworkElseCache;
    PFQuery *queryCanteen = [PFQuery queryWithClassName:@"Canteen"];
    [queryCanteen getObjectInBackgroundWithId:objectIdCanteen block:^(PFObject *canteen, NSError *error) {
        // Do something with the returned PFObject in the gameScore variable.
        CABasicAnimation *fullRotation;
        fullRotation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
        fullRotation.fromValue = [NSNumber numberWithFloat:0];
        fullRotation.toValue = [NSNumber numberWithFloat:((360*M_PI)/180)];
        fullRotation.duration = 6;
        fullRotation.repeatCount = 1e100f;
        [_loadingImg.layer addAnimation:fullRotation forKey:@"360"];
        NSLog(@"%@", canteen);
        //Query Ception for better life
        [query whereKey:@"canteen" equalTo:canteen];
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            
            if (!error) {
                
                // The find succeeded.
                NSLog(@"Successfully retrieved %d users.", objects.count);
                
                // Register ID in database for first connection
                // Check if facebookId exist or not
                
                if(objects.count <= 0){
                    NSLog(@"No Canteen Found");
                }else{
                    // Set ShopList
                    NSLog(@"Canteen Found!");
                    for (PFObject *object in objects) {
//                         NSLog(@"%@", object);
                        // Print founded object
                        NSLog(@"%@", object.objectId);
                        [restaurant addObject:object[@"name"]];
                        NSLog(@"Name: %@",object[@"name"]);
                        [star addObject:@0 ];
                        NSLog(@"Star: %@",@0);
                        [background addObject:[[UIImage alloc] initWithData:object[@"image"]]];
                        NSLog(@"Done Image Setup");
                        [objectId addObject:object.objectId];
                        
                        
                    }
                }
                [self.loadingImg.layer removeAnimationForKey:@"rotation"];
                [self.tableView reloadData];
                self.loadingImg.alpha = 0.0;
                [self.loadingImg removeFromSuperview];
                [self.loadViewBG removeFromSuperview];
            } else {
                // Log details of the failure
                NSLog(@"Error: %@ %@", error, [error userInfo]);
            }
        }];

    }];
    
    
    
    
    // Load Player Data

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 138;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [restaurant count];
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"CustomShopViewCell";
    tableView.separatorColor = [UIColor clearColor];
    CustomShopViewCell *cell = (CustomShopViewCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CustomShopViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    cell.nameLabel.text = [[restaurant objectAtIndex:indexPath.row] uppercaseString];;
    NSLog(@"Name");
    UIImage* image = [background objectAtIndex:indexPath.row];
    int width = 320;
    int height = 128;

    if(image.size.width >= 2*width && image.size.height >= 2*height){
        image = [self imageWithImage:image scaledToSize:CGSizeMake(image.size.width/2, image.size.height/2)];
    }

    cell.background.image =
    [ImageCrop imageWithImage:image cropInRect:CGRectMake((image.size.width-width)/2, (image.size.height-height)/2, width, height) ];
//    [self imageWithImage:[background objectAtIndex:indexPath.row] scaledToSize:CGSizeMake(320, 138)];
    NSLog(@"Background");
    int starNo = [[star objectAtIndex:indexPath.row] intValue];
    NSLog(@"Star %d",starNo);
    if(starNo >= 5){
        cell.star5.image = [UIImage imageNamed:@"icon_star1.png"];
    }
    if(starNo >= 4){
        cell.star4.image = [UIImage imageNamed:@"icon_star1.png"];
    }
    if(starNo >= 3){
        cell.star3.image = [UIImage imageNamed:@"icon_star1.png"];
    }
    if(starNo >= 2){
        cell.star2.image = [UIImage imageNamed:@"icon_star1.png"];
    }
    if(starNo >= 1){
        cell.star1.image = [UIImage imageNamed:@"icon_star1.png"];
    }
    cell.objectId = [objectId objectAtIndex:indexPath.row];
    cell.nextBtn.tag = indexPath.row;
    [cell.nextBtn addTarget:self action:@selector(nextButtonClicked::) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

-(void)nextButtonClicked:(UIButton*)sender
{
    NSInteger index = sender.tag;
    NSString *objectIdSelect = [objectId objectAtIndex:index];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setValue:objectIdSelect forKey:@"currentShop"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIImage*) resizeImage:(UIImage*) image{
    
    UIGraphicsBeginImageContext(CGSizeMake(320, 138));
    [image drawInRect: CGRectMake(0, 0, 320, 138)];
    UIImage *smallImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    
    
    
    return smallImage;
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
- (IBAction)pressBackButton:(id)sender {
    [self dismissViewControllerAnimated:true completion:^{
        //  [loadingView startAnimating];
        NSLog(@"completion fired");
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
