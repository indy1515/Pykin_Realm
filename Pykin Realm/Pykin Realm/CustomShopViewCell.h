//
//  CustomShopViewCell.h
//  Pykin Realms
//
//  Created by IndyZa on 11/24/2557 BE.
//  Copyright (c) 2557 IndyZa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomShopViewCell : UITableViewCell


@property (nonatomic, weak) IBOutlet UILabel *nameLabel;
@property (nonatomic, weak) IBOutlet UIImageView *star1;
@property (nonatomic, weak) IBOutlet UIImageView *star2;
@property (nonatomic, weak) IBOutlet UIImageView *star3;
@property (nonatomic, weak) IBOutlet UIImageView *star4;
@property (nonatomic, weak) IBOutlet UIImageView *star5;
@property (nonatomic, weak) IBOutlet UIImageView *background;
@property (weak, nonatomic) IBOutlet UIButton *nextBtn;
@property (weak, nonatomic) NSString *objectId;


@end
