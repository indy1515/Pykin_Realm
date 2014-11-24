//
//  ShopRegistrationViewController.h
//  Pykin Realms
//
//  Created by IndyZa on 11/24/2557 BE.
//  Copyright (c) 2557 IndyZa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShopRegistrationViewController : UIViewController<UINavigationControllerDelegate, UIImagePickerControllerDelegate,UIPickerViewDataSource, UIPickerViewDelegate,UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *canteenField;
@property (weak, nonatomic) IBOutlet UITextField *shopnameField;
@property (weak, nonatomic) IBOutlet UITextField *latField;
@property (weak, nonatomic) IBOutlet UITextField *lngField;
@property (weak, nonatomic) IBOutlet UITextField *recFoodField1;
@property (weak, nonatomic) IBOutlet UITextField *recFoodField2;
@property (weak, nonatomic) IBOutlet UITextField *priceMinField;
@property (weak, nonatomic) IBOutlet UITextField *priceMaxField;
@property (weak, nonatomic) IBOutlet UIButton *submitBtn;
@property (weak, nonatomic) IBOutlet UIButton *uploadBtn;
@property (weak, nonatomic) IBOutlet UIButton *camera;

@property (weak, nonatomic) IBOutlet UIPickerView *pickerType;
@end
