//
//  RecommendViewController.m
//  personifI
//
//  Created by Madhan Prakash on 25/01/15.
//  Copyright (c) 2015 personifIInc. All rights reserved.
//

#import "RecommendViewController.h"
#import "NSString+Utils.h"

@interface RecommendViewController (){
    NSMutableArray *mContentList;
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
        
        [mTextDropDownListView show];
        [mTextDropDownListView reloadListData];
    }
    
}

- (void)createLisDatatByStr:(NSString *)str
{
    [mContentList removeAllObjects];
    if ([NSString isNullOrEmpty:str]) {
        str = @"Fck";
    }
    for (int i = 0; i < 50; i++) {
        [mContentList addObject:[NSString stringWithFormat:@"%@_%d", str, i]];
    }
}


- (IBAction)CloseAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
