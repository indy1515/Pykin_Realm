//
//  ShopListViewController.h
//  Pykin Realms
//
//  Created by IndyZa on 11/24/2557 BE.
//  Copyright (c) 2557 IndyZa. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ViewController2Delegate <NSObject>
@end
@interface ShopListViewController : UIViewController <UITableViewDelegate, UITableViewDataSource,ViewController2Delegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UIImageView *loadingImg;
@property (weak, nonatomic) IBOutlet UIView *loadViewBG;

@property (nonatomic, weak) id<ViewController2Delegate>delegate;

@end
