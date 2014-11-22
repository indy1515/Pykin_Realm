//
//  ViewController.m
//  Ranking
//
//  Created by F1RSTst on 9/22/57 BE.
//  Copyright (c) 2557 ___FULLUSERNAME___. All rights reserved.
//

#import "RankViewController.h"

@interface RankViewController ()

@end

@implementation RankViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    //first
    self.first.layer.cornerRadius = self.first.frame.size.width / 2;
    self.first.clipsToBounds = YES;
    self.first.layer.borderWidth = 3.0f;
    self.first.layer.borderColor = [UIColor whiteColor].CGColor;
    
    //2nd
    self.second.layer.cornerRadius = self.first.frame.size.width / 2;
    self.second.clipsToBounds = YES;
    self.second.layer.borderWidth = 3.0f;
    self.second.layer.borderColor = [UIColor whiteColor].CGColor;
    
    //3rd
    self.third.layer.cornerRadius = self.first.frame.size.width / 2;
    self.third.clipsToBounds = YES;
    self.third.layer.borderWidth = 3.0f;
    self.third.layer.borderColor = [UIColor whiteColor].CGColor;
    
    //fourth
    self.fourth.layer.cornerRadius = self.first.frame.size.width / 2;
    self.fourth.clipsToBounds = YES;
    self.fourth.layer.borderWidth = 3.0f;
    self.fourth.layer.borderColor = [UIColor whiteColor].CGColor;
    
    //fifth
    self.fifth.layer.cornerRadius = self.first.frame.size.width / 2;
    self.fifth.clipsToBounds = YES;
    self.fifth.layer.borderWidth = 3.0f;
    self.fifth.layer.borderColor = [UIColor whiteColor].CGColor;
}

- (BOOL)shouldAutorotate
{
    return NO;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
