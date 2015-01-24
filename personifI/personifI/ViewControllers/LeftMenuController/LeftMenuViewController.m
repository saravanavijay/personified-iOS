//
//  LeftMenuViewController.m
//  Personif-I
//
//  Created by Madhan Prakash on 24/01/15.
//  Copyright (c) 2015 Madhan Prakash. All rights reserved.
//

#import "LeftMenuViewController.h"
#import "ECSlidingViewController.h"

@interface LeftMenuViewController ()

@end

@implementation LeftMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     [self.slidingViewController setAnchorRightRevealAmount:240.0f];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
