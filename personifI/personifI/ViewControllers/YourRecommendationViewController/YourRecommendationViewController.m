//
//  YourRecommendationViewController.m
//  personifI
//
//  Created by Madhan Prakash on 25/01/15.
//  Copyright (c) 2015 personifIInc. All rights reserved.
//

#import "YourRecommendationViewController.h"
#import "ECSlidingViewController.h"
#import "yourAnswerTableViewCell.h"
#import "NSString+Utils.h"

@interface YourRecommendationViewController ()<yourCellDelegate>
{
    NSMutableArray* answers;
}
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
    
    answers = [NSMutableArray array];
    [self loadAnswers];
}

-(void)loadAnswers{
    
    PFQuery *query = [PFQuery queryWithClassName:@"RecommendationAnswers"];
    [query whereKey:@"recommenderUserId" equalTo:[PFUser currentUser]];
    [query includeKey:@"recommendationQuestionId"];
    [query includeKey:@"recommendationQuestionId.userId"];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        NSLog(@"My Questions : %@",objects);
        answers = [NSMutableArray arrayWithArray:objects];
        [self.yourRecTableView reloadData];
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
- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    return answers.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120;
}
- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
     yourAnswerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"yourcell" forIndexPath:indexPath];
    ;
    PFObject* recommendationAnswer = [answers objectAtIndex:indexPath.item];
    PFObject* recommendation = recommendationAnswer[@"recommendationQuestionId"];
    PFUser*user = recommendation[@"userId"];
    
    cell.delegate = self;
    if ([NSString isNullOrEmpty:recommendationAnswer[@"recommenderDescription"]]) {
        cell.lblHeader.text =[NSString stringWithFormat:@"%@ wants recommendation for %@",user[@"fullname"], recommendation[@"recommendationFor"]];
        cell.textView.hidden = NO;
        //[cell.textView setPlaceholder:@"Give your Recommendation"];
        cell.labelRecommendation.hidden = YES;
        cell.sendButton.hidden = NO;
        cell.sendButton.tag = indexPath.item;
    }
    else
    {
        cell.lblHeader.text =[NSString stringWithFormat:@"%@'s recommendation for %@ is",user[@"fullname"], recommendation[@"recommendationFor"]];
        cell.textView.hidden = YES;
        cell.labelRecommendation.hidden = NO;
        cell.labelRecommendation.text = recommendationAnswer[@"recommenderDescription"];
        cell.sendButton.hidden = YES;
    }
    return cell;
}


-(void)didSendButtonTap:(yourAnswerTableViewCell *)cell{
    [cell.textView resignFirstResponder];
    
    
    
    if ([NSString isNullOrEmpty:cell.textView.text])
    {
        
    }else
    {
        NSLog(@"Text entered = %@",cell.textView.text);
        
        PFObject* recommendationAnswer = [answers objectAtIndex:cell.sendButton.tag];
        PFObject* recommendation = recommendationAnswer[@"recommendationQuestionId"];
        PFUser*user = recommendation[@"userId"];
        cell.lblHeader.text =[NSString stringWithFormat:@"%@'s recommendation for %@ is",user[@"fullname"], recommendation[@"recommendationFor"]];
        cell.textView.hidden = YES;
        cell.labelRecommendation.hidden = NO;
        cell.labelRecommendation.text = cell.textView.text;
        cell.sendButton.hidden = YES;
        
        recommendationAnswer[@"recommenderDescription"]  = cell.textView.text;
        [recommendationAnswer saveInBackground];
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
//    yourAnswerTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
//    [ce]
}


@end
