//
//  FeedViewController.m
//  Personif-I
//
//  Created by Madhan Prakash on 24/01/15.
//  Copyright (c) 2015 Madhan Prakash. All rights reserved.
//

#import "FeedViewController.h"
#import "ECSlidingViewController.h"
#import <Parse/Parse.h>
#import "ViewController.h"

@interface FeedViewController ()

@end

@implementation FeedViewController

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)viewDidAppear:(BOOL)animated
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
    [super viewDidAppear:animated];
    //---------------------------------------------------------------------------------------------------------------------------------------------
    if ([PFUser currentUser] != nil)
    {
        //[self refreshTable];
    }
    else{
        
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        ViewController *loginView = [sb instantiateViewControllerWithIdentifier:@"ViewController"];
        
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:loginView];
        [self presentViewController:navigationController animated:YES completion:nil];
    }
}

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