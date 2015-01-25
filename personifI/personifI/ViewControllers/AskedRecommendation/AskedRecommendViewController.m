//
//  AskedRecommendViewController.m
//  personifI
//
//  Created by Madhan Prakash on 25/01/15.
//  Copyright (c) 2015 personifIInc. All rights reserved.
//

#import "AskedRecommendViewController.h"
#import "AskedRecommendTableViewCell.h"
#import "ECSlidingViewController.h"
#import <Parse/Parse.h>
#import "ViewAnswerViewController.h"

@interface AskedRecommendViewController ()

@end

@implementation AskedRecommendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _askedrecommendarray=[[NSMutableArray alloc]init];
    
    UIButton *btnNext1 =[[UIButton alloc] init];
    [btnNext1 setBackgroundImage:[UIImage imageNamed:@"FeedSettings"] forState:UIControlStateNormal];
    
    btnNext1.frame = CGRectMake(100, 100, 26, 26);
    UIBarButtonItem *btnNext =[[UIBarButtonItem alloc] initWithCustomView:btnNext1];
    [btnNext1 addTarget:self action:@selector(showMenu) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = btnNext;
    
    
    UIImageView *titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Logo"]];
    [self.navigationController.navigationBar.topItem setTitleView:titleView];
    
    
    
    PFQuery *askedRecommend = [PFQuery queryWithClassName:@"Recommendation"];
    
    PFQuery * query = [PFUser query];
    //[query whereKey:@"objectId" equalTo:@"fnlBpPtjQt"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        [askedRecommend whereKey:@"userId" equalTo:objects[0]];    //fnlBpPtjQt
        //  [askedRecommend whereKey:@"userId" equalTo:[PFUser currentUser].objectId];
        //[askedRecommend includeKey:@"recommendationAnswers"];
        [askedRecommend setLimit:1000];
        [askedRecommend findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            NSLog(@"Objects: %@",objects);
            
            for (NSDictionary* dict in objects) {
            
                [_askedrecommendarray addObject:[dict objectForKey:@"recommendationFor"]];
                
                 NSLog(@"_askedarray %@",_askedrecommendarray);
                
                
                
            
            }
            [self getanswers];
            
            _askedRecommendTableView.delegate=self;
            _askedRecommendTableView.dataSource=self;
            [_askedRecommendTableView reloadData];
            
        }];
    }];
    
    
    NSLog(@"_askedarray %@",_askedrecommendarray);
    
    
}
-(void) getanswers{
    
    PFQuery *query = [PFQuery queryWithClassName:@"RecommendationAnswers"];
   // [query whereKey:@"objectId" equalTo:[PFUser currentUser].objectId];
    [query includeKey:@"recommendationQuestionId"];
    [query setLimit:1000];
    
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        NSLog(@"query = %@",objects);
    }];
    
    
    
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
- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    return _askedrecommendarray.count;
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AskedRecommendTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AskRecCell" forIndexPath:indexPath];
    
    cell.askedRecLabel.text=[_askedrecommendarray objectAtIndex:indexPath.row];
    
    return cell;
    

}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    ViewAnswerViewController *answerView = [sb instantiateViewControllerWithIdentifier:@"ViewAnswerViewController"];
    
        [self.navigationController pushViewController:answerView animated:YES];
    
}
@end
