//
//  YourRecommendationViewController.m
//  personifI
//
//  Created by Madhan Prakash on 25/01/15.
//  Copyright (c) 2015 personifIInc. All rights reserved.
//

#import "YourRecommendationViewController.h"
#import "ECSlidingViewController.h"

@interface YourRecommendationViewController ()

@end

@implementation YourRecommendationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIButton *btnNext1 =[[UIButton alloc] init];
    [btnNext1 setBackgroundImage:[UIImage imageNamed:@"FeedSettings"] forState:UIControlStateNormal];
    
    btnNext1.frame = CGRectMake(100, 100, 26, 26);
    UIBarButtonItem *btnNext =[[UIBarButtonItem alloc] initWithCustomView:btnNext1];
    [btnNext1 addTarget:self action:@selector(showMenu) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = btnNext;
    
    
    UIImageView *titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Logo"]];
    [self.navigationController.navigationBar.topItem setTitleView:titleView];
    
    
    
}
- (void)showMenu
{
    //  if (![[NSUserDefaults standardUserDefaults]objectForKey:@"Selected_plan"]==0)
    
    [self.slidingViewController anchorTopViewTo:ECRight];
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
