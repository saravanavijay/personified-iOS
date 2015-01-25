//
//  RecommendViewController.m
//  personifI
//
//  Created by Madhan Prakash on 25/01/15.
//  Copyright (c) 2015 personifIInc. All rights reserved.
//

#import "RecommendViewController.h"
#import "NSString+Utils.h"
#import "ASAPIClient.h"
#import <Parse/Parse.h>

@interface RecommendViewController ()<UIAlertViewDelegate>
{
    NSMutableArray *mContentList;
    ASAPIClient *apiClient;
}

@end

@implementation RecommendViewController
@synthesize mTextDropDownListView,mTextField;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    mTextDropDownListView = [[XDPopupListView alloc] initWithBoundView:mTextField dataSource:self delegate:self popupType:XDPopupListViewDropDown];
    
    [mTextField addTarget:self action:@selector(textDidChanged:) forControlEvents:UIControlEventEditingChanged];
    mContentList = [[NSMutableArray alloc] initWithCapacity:0];
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
    
    apiClient = [ASAPIClient apiClientWithApplicationID:@"1PDXU6Z52T" apiKey:@"3f3fc520881c2c34364fdf208a2c82fb"];

    [mTextField becomeFirstResponder];
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

#pragma mark - XDPopupListViewDataSource & XDPopupListViewDelegate


- (NSInteger)numberOfRowsInSection:(NSInteger)section
{
    return mContentList.count;
}
- (CGFloat)itemCellHeight:(NSIndexPath *)indexPath
{
    return 44.0f;
}
- (void)clickedListViewAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%d: %@", indexPath.row, mContentList[indexPath.row]);
    
    mTextField.text =mContentList[indexPath.row];
    
}
- (UITableViewCell *)itemCell:(NSIndexPath *)indexPath
{
    if (mContentList.count == 0) {
        return nil;
    }
    static NSString *identifier = @"ddd";
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    cell.textLabel.text = mContentList[indexPath.row];
    return cell;
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
- (void)textDidChanged:(id)sender
{
    UITextField *textField = (UITextField *)sender;
    if (![NSString isNullOrEmpty:textField.text]) {
        [self createLisDatatByStr:textField.text];
    }
    
}

- (void)createLisDatatByStr:(NSString *)str
{
    ASRemoteIndex *index = [apiClient getIndex:@"userFeed"];
    
    if ([NSString isNullOrEmpty:str]) {
        str = @"iPhone";
    }
    else
    {
        
    }
    
    [index search:[ASQuery queryWithFullTextQuery:str] success:^(ASRemoteIndex *index, ASQuery *query, NSDictionary *answer) {
        NSLog(@"answer = %@", answer);
        if (answer.count>0) {
            [mContentList removeAllObjects];
            for (NSDictionary* hit  in answer[@"hits"]) {
                [mContentList addObject:hit[@"feedName"]];
            }
            [mTextDropDownListView show];
            [mTextDropDownListView reloadListData];
        }
    }
    failure:nil];
}


- (IBAction)CloseAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)askClick:(id)sender {
    
    if (![NSString isNullOrEmpty:mTextField.text]) {
        PFObject* recommendation = [PFObject objectWithClassName:@"Recommendation"];
        recommendation[@"userId"] = [PFUser currentUser];
        recommendation[@"recommendationFor"] = mTextField.text;
//        [recommendation addObject:[PFUser currentUser] forKey:@"userId"];
//        [recommendation addObject:mTextField.text forKey:@"recommendationFor"];
        [recommendation saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (succeeded) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"We have asked for recommendation. Please wait for reply from our Users."  message:nil delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                [alert show];
            }
        }];
    }
}

-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end

