//
//  ViewController.h
//  Checkin
//
//  Created by F1RSTst on 9/22/57 BE.
//  Copyright (c) 2557 ___FULLUSERNAME___. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ViewController2Delegate <NSObject>
@end
@interface DetailViewController : UIViewController <ViewController2Delegate>

@property (weak, nonatomic) IBOutlet UIView *UpperContainer;
@property (weak, nonatomic) IBOutlet UILabel *pykion;
@property (weak, nonatomic) IBOutlet UILabel *pykinite;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UIImageView *userImg;



@property (weak, nonatomic) IBOutlet UIButton *checkin;

@property (weak ,nonatomic) IBOutlet UIImageView *star1;
@property (weak ,nonatomic) IBOutlet UIImageView *star2;
@property (weak ,nonatomic) IBOutlet UIImageView *star3;
@property (weak ,nonatomic) IBOutlet UIImageView *star4;
@property (weak ,nonatomic) IBOutlet UIImageView *star5;


@property (weak, nonatomic) IBOutlet UILabel *shopTitle;

@property (weak, nonatomic) IBOutlet UILabel *recommend;
@property (weak, nonatomic) IBOutlet UILabel *list;
@property (weak, nonatomic) IBOutlet UILabel *list2;

@property (weak, nonatomic) IBOutlet UILabel *priceTitle;
@property (weak, nonatomic) IBOutlet UILabel *priceDetail;
@property (nonatomic, weak) id<ViewController2Delegate>delegate;
@end
