//
//  ViewAnswerViewController.m
//  personifI
//
//  Created by Madhan Prakash on 25/01/15.
//  Copyright (c) 2015 personifIInc. All rights reserved.
//

#import "ViewAnswerViewController.h"
#import "ViewAnswerTableViewCell.h"

@interface ViewAnswerViewController ()

@end

@implementation ViewAnswerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
    return 1;
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ViewAnswerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Viewanswercwll" forIndexPath:indexPath];
    
   // cell.askedRecLabel.text=[_askedrecommendarray objectAtIndex:indexPath.row];
    
    return cell;
    
    
}


@end
