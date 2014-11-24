//
//  ShopDetailViewController.h
//  Pykin Realms
//
//  Created by IndyZa on 11/24/2557 BE.
//  Copyright (c) 2557 IndyZa. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ViewController2Delegate <NSObject>
@end
@interface ShopDetailViewController : UIViewController <ViewController2Delegate>

@property (nonatomic, weak) id<ViewController2Delegate>delegate;
@property (weak, nonatomic) IBOutlet UITextField *shopName;
@property (weak, nonatomic) IBOutlet UIImageView *star1;
@property (weak, nonatomic) IBOutlet UIImageView *star2;
@property (weak, nonatomic) IBOutlet UIImageView *star3;
@property (weak, nonatomic) IBOutlet UIImageView *star4;
@property (weak, nonatomic) IBOutlet UIImageView *star5;
@property (weak, nonatomic) IBOutlet UILabel *recommend1;
@property (weak, nonatomic) IBOutlet UILabel *recommend2;
@property (weak, nonatomic) IBOutlet UILabel *priceRange;
@property (weak, nonatomic) IBOutlet UIButton *checkInBtn;
@property (weak, nonatomic) IBOutlet UIButton *reviewButton;
@property (weak, nonatomic) IBOutlet UIButton *shareButton;


@end
