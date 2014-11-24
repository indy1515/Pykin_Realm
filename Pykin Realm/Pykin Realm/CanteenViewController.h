//
//  CanteenViewController.h
//  Pykin Realms
//
//  Created by IndyZa on 11/24/2557 BE.
//  Copyright (c) 2557 IndyZa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CanteenViewController : UIViewController <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *canteenField;
@property (weak, nonatomic) IBOutlet UITextField *latField;
@property (weak, nonatomic) IBOutlet UITextField *lngField;
@property (weak, nonatomic) IBOutlet UIButton *submitBtn;
@property (weak, nonatomic) IBOutlet UITextField *canteenshortField;

@end
