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
    
    
    
//    _interestArray=[[NSMutableArray alloc]initWithObjects:@"Technology",@"Travel",@"Gadgets",@"Recipes",@"Photography",@"LuxuryCars",@"MotorCycles",@"Animals",@"Cartoons",@"Music",@"Sports",@"Entertainment" ,nil];
  
//    
//    _interestImages=[[NSMutableArray alloc]initWithObjects:@"Follow",@"Follow",@"Follow",@"Follow",@"Follow",@"Follow",@"Follow",@"Follow",@"Follow",@"Follow",@"Follow",@"Follow",nil];
    

    
    
  //  self.view.backgroundColor=[UIColor blackColor];
//    PFObject *testObject = [PFObject objectWithClassName:@"TestObject"];
//    testObject[@"InterestList"] = _interestArray;
//       testObject[@"foo"] = @"Madhan";
//    [testObject saveInBackground];
//    
//    
//
    _brandArray =[NSMutableArray array];
    _interestArray = [NSMutableArray array];
     _brandSelectedArray = [NSMutableArray array];
    _selectedArray = [NSMutableArray array];
    
    PFQuery *query = [PFQuery queryWithClassName:@"Interest"];
   [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
       NSLog(@"Objects = %@",objects);
       for (NSDictionary* dict in objects) {
           if ([dict[@"type"] isEqualToString:@"Brand"]) {
               [_brandArray addObject:dict];
           }
           else
           {
               [_interestArray addObject:dict];
           }
       }
       
       NSLog(@"_brandArray %@",_brandArray);
       NSLog(@"_interestArray %@",_interestArray);
       
      // _interestArray = [NSMutableArray arrayWithObject:objects];
       [self.InterestTableView reloadData];
       
   }];
    
//               getObjectInBackgroundWithId:@"HRjn068Dam" block:^(PFObject *gameScore, NSError *error) {
//       // Do something with the returned PFObject in the gameScore variable.
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

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return [_interestArray count];
    }
    else
    {
        return [_brandArray count];
    }
   
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
     InterestTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"InterestCell" forIndexPath:indexPath];
    
   
    if (indexPath.section==0)
    {
        cell.interestLabel.text=[_interestArray objectAtIndex:indexPath.row][@"name"];
        cell.backgroundColor=[UIColor clearColor];
        
        
        if ([_selectedArray containsObject:[_interestArray objectAtIndex:indexPath.row][@"name"]])
        {
            cell.rightButton.selected = YES;
        }
        else{
            cell.rightButton.selected = NO;
        }
    }
    else
    {
        cell.interestLabel.text=[_brandArray objectAtIndex:indexPath.row][@"name"];
        cell.backgroundColor=[UIColor clearColor];
        
        if ([_brandSelectedArray containsObject:[_brandArray objectAtIndex:indexPath.row][@"name"]])
        {
            cell.rightButton.selected = YES;
        }
        else{
            cell.rightButton.selected = NO;
        }
        


        
    }
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
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    NSString *headerTitle = @"";
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 30)];
        
        if (section == 0)
        {
            headerTitle = @"Topic";
            
        }
   
    else
        if (section ==1 )
        {
            headerTitle = @"Brand";
            
        }
     [headerView setBackgroundColor:[UIColor darkGrayColor]];
    return headerTitle;
}
- (void)userDidSelectedInterestForCell:(InterestTableViewCell*)cell{
    
    
    NSIndexPath* indexPath = [self.InterestTableView indexPathForCell:cell];
    
    
    if (indexPath.section==0){
    
        if (![_selectedArray containsObject:[_interestArray objectAtIndex:indexPath.item][@"name"]]){
            
            cell.rightButton.selected=YES;
            [_selectedArray addObject:[_interestArray objectAtIndex:indexPath.item][@"name"]];
        }
        else{
            
            cell.rightButton.selected=NO;
            [_selectedArray removeObject:[_interestArray objectAtIndex:indexPath.item][@"name"]];
        }
    }
    else{
    
        if (![_brandSelectedArray containsObject:[_brandArray objectAtIndex:indexPath.item][@"name"]]){
            cell.rightButton.selected=YES;
            [_brandSelectedArray addObject:[_brandArray objectAtIndex:indexPath.item][@"name"]];
            
        }
        else{
            cell.rightButton.selected=NO;
             [_brandSelectedArray removeObject:[_brandArray objectAtIndex:indexPath.item][@"name"]];
        }
    
    }
        
   
        
        
    }

- (IBAction)NextbuttonAction:(id)sender {
    
//    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
//    picker.delegate = self;
//    picker.allowsEditing = YES;
//    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
//    
//    [self presentViewController:picker animated:YES completion:NULL];
    
    
    
   
    NSLog(@"_selectedArray %@",_selectedArray);
    PFUser* user=[PFUser currentUser];
    user[@"brandFollowing"]=[NSArray arrayWithArray:_brandSelectedArray];
    user[@"topicFollowing"]=[NSArray arrayWithArray:_selectedArray];
        [user saveInBackground];
    
    
    
    
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
