//
//  InterestsViewController.m
//  Personif-I
//
//  Created by Madhan Prakash on 22/01/15.
//  Copyright (c) 2015 Madhan Prakash. All rights reserved.
//

#import "InterestsViewController.h"
#import <Parse/Parse.h>
#import "ECSlidingViewController.h"
#import "FeedViewController.h"
#import "LeftMenuViewController.h"

@interface InterestsViewController ()

@end

@implementation InterestsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
//    PFObject *testObject = [PFObject objectWithClassName:@"TestObject"];
//    testObject[@"foo"] = @"bar";
//    [testObject saveInBackground];
    
   // _InterestTableView.backgroundColor=[UIColor blackColor];
    
    
    
    _interestArray=[[NSMutableArray alloc]initWithObjects:@"Technology",@"Travel",@"Gadgets",@"Recipes",@"Photography",@"LuxuryCars",@"MotorCycles",@"Animals",@"Cartoons",@"Music",@"Sports",@"Entertainment" ,nil];
    _selectedArray =[[NSMutableArray alloc]init];
    
    _interestImages=[[NSMutableArray alloc]initWithObjects:@"Follow",@"Follow",@"Follow",@"Follow",@"Follow",@"Follow",@"Follow",@"Follow",@"Follow",@"Follow",@"Follow",@"Follow",nil];
    

    
    
  //  self.view.backgroundColor=[UIColor blackColor];
//    PFObject *testObject = [PFObject objectWithClassName:@"TestObject"];
//    testObject[@"InterestList"] = _interestArray;
//       testObject[@"foo"] = @"Madhan";
//    [testObject saveInBackground];
//    
//    
//    
//    PFQuery *query = [PFQuery queryWithClassName:@"TestObject"];
//    [query getObjectInBackgroundWithId:@"HRjn068Dam" block:^(PFObject *gameScore, NSError *error) {
//        // Do something with the returned PFObject in the gameScore variable.
//        NSLog(@"gameScore %@", gameScore);
//    }];
    
   // _ImageView.image=
    
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
    return [_interestArray count];
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
     InterestTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"InterestCell" forIndexPath:indexPath];
    
    NSLog(@"%@",[_interestImages objectAtIndex:indexPath.row]);
 //   cell.interestLabel=[[UILabel alloc]init];
    cell.interestLabel.text=[_interestArray objectAtIndex:indexPath.row];
    [cell.rightButton setImage:[UIImage imageNamed:[_interestImages objectAtIndex:indexPath.row]] forState:UIControlStateNormal];
    cell.backgroundColor=[UIColor clearColor];
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    InterestTableViewCell * cells = (InterestTableViewCell*)[_InterestTableView cellForRowAtIndexPath:indexPath];
    
    
    NSLog(@"indexpath is %ld",(long)indexPath.row);
    _indexStored=indexPath.row;
    [self userDidSelectedInterestForCell:cells];
    
}
- (void)userDidSelectedInterestForCell:(InterestTableViewCell*)cell{
    
    
    
    if (![_selectedArray containsObject:[_interestArray objectAtIndex:_indexStored]]){
        
        cell.rightButton.selected=YES;
        [_selectedArray addObject:[_interestArray objectAtIndex:_indexStored]];
    }
    else{
        
        cell.rightButton.selected=NO;
        [_selectedArray removeObject:[_interestArray objectAtIndex:_indexStored]];
        
        
    }
    
        
    NSLog(@"_SelectedArray %@",_selectedArray);
    
        
        
    }
    
    
    
    
    


- (IBAction)NextbuttonAction:(id)sender {
    
//    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
//    picker.delegate = self;
//    picker.allowsEditing = YES;
//    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
//    
//    [self presentViewController:picker animated:YES completion:NULL];
    
      UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    UINavigationController *feedNavVC = (UINavigationController*)[sb instantiateViewControllerWithIdentifier:@"FeedNav"];
    
    FeedViewController *feedView = [feedNavVC.viewControllers objectAtIndex:0];
    LeftMenuViewController *leftView = [sb instantiateViewControllerWithIdentifier:@"LeftMenuNavVC"];
    ECSlidingViewController *slidingViewController = [[ECSlidingViewController alloc] init];
    slidingViewController.topViewController = feedNavVC;
    slidingViewController.underLeftViewController =leftView;
    
    // [self dismissViewControllerAnimated:YES completion:nil];
    [self presentViewController:slidingViewController animated:YES completion:nil];
    
    
}
#pragma mark - Image Picker Controller delegate methods

//- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
//    
//    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
//   // self.imageView.image = chosenImage;
//    NSData *imageData = UIImagePNGRepresentation(chosenImage);
//    
//    NSLog(@"chosenimage %@",imageData);
//    
//  //  NSData *imageData = UIImagePNGRepresentation(image);
//    PFFile *imageFile = [PFFile fileWithName:@"image.png" data:imageData];
//    
//    PFObject *userPhoto = [PFObject objectWithClassName:@"TestObject"];
//    userPhoto[@"foo"] = @"My trip to Hawaii!";
//    userPhoto[@"Image"] = imageFile;
//    [userPhoto saveInBackground];
//    
//    
//    
//    [picker dismissViewControllerAnimated:YES completion:NULL];
//    
//}
//
//- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
//    
//    [picker dismissViewControllerAnimated:YES completion:NULL];
//    
//}


@end
