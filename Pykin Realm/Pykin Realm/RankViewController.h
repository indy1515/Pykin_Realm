//
//  ViewController.h
//  Ranking
//
//  Created by F1RSTst on 9/22/57 BE.
//  Copyright (c) 2557 ___FULLUSERNAME___. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ViewController2Delegate <NSObject>
@end
@interface RankViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *fifth;
@property (weak, nonatomic) IBOutlet UIImageView *fourth;
@property (weak, nonatomic) IBOutlet UIImageView *third;
@property (weak, nonatomic) IBOutlet UIImageView *second;

@property (weak, nonatomic) IBOutlet UIImageView *first;
@property (nonatomic, weak) id<ViewController2Delegate>delegate;
@end
