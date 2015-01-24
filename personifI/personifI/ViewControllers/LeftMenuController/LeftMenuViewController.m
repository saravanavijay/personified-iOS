//
//  LeftMenuViewController.m
//  Personif-I
//
//  Created by Madhan Prakash on 24/01/15.
//  Copyright (c) 2015 Madhan Prakash. All rights reserved.
//

#import "LeftMenuViewController.h"
#import "ECSlidingViewController.h"
#import "FeedViewController.h"
#import "TakepicViewController.h"

@interface LeftMenuViewController ()

@end

@implementation LeftMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     [self.slidingViewController setAnchorRightRevealAmount:240.0f];
    
    
    UIButton *btnNext1 =[[UIButton alloc] init];
    
    
    btnNext1.frame = CGRectMake(100, 100, 90, 26);
    [btnNext1 setTitle:@"Categories" forState:UIControlStateNormal];
    UIBarButtonItem *btnNext =[[UIBarButtonItem alloc] initWithCustomView:btnNext1];
    
    self.navigationItem.leftBarButtonItem = btnNext;
    
    
     _itemsArray = [[NSMutableArray alloc]initWithObjects:@"Feed",@"Share",@"Settings",@"Notifications",nil];
    
    _leftMenuTableView.delegate=self;
    _leftMenuTableView.dataSource=self;
    
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
- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
   
    return 3;
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.contentView.backgroundColor = [UIColor clearColor];
    
    cell.textLabel.text=[_itemsArray objectAtIndex:indexPath.row];
    cell.textLabel.textColor=[UIColor blackColor];
    cell.backgroundColor=[UIColor clearColor];
    
    
    UIColor *customColor =[UIColor grayColor];
    
    cell.selectedBackgroundView = [[UIView alloc] initWithFrame:CGRectZero];
    cell.selectedBackgroundView.backgroundColor = customColor;
    _leftMenuTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row==0)
    {
        
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        FeedViewController *feedVC = [sb instantiateViewControllerWithIdentifier:@"FeedNav"];
        [self.slidingViewController anchorTopViewOffScreenTo:ECRight animations:nil onComplete:^{
            CGRect frame = self.slidingViewController.topViewController.view.frame;
            self.slidingViewController.topViewController = feedVC;
            self.slidingViewController.topViewController.view.frame = frame;
            [self.slidingViewController resetTopView];
            
            
            
        }];
    }
    if (indexPath.row==1){
        
        UIStoryboard *sb=[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle  mainBundle]];
        
        TakepicViewController * takePic=[sb instantiateViewControllerWithIdentifier:@"TakeapicNav" ];
        
    
        
        
        [self.slidingViewController anchorTopViewOffScreenTo:ECRight animations:nil onComplete:^{
            CGRect frame = self.slidingViewController.topViewController.view.frame;
            self.slidingViewController.topViewController = takePic;
            self.slidingViewController.topViewController.view.frame = frame;
            [self.slidingViewController resetTopView];
            
            
        }];
        
    }
   
        
        
  
}


@end
