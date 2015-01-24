//
//  ViewController.m
//  personifI
//
//  Created by Vijay on 24/01/15.
//  Copyright (c) 2015 personifIInc. All rights reserved.
//

#import "ViewController.h"
#import <ParseFacebookUtils/PFFacebookUtils.h>
#import "FacebookSDK/FacebookSDK.h"
#import "AppConstant.h"
#import "AFNetworking.h"
#import <Parse/Parse.h>
#import "Utilities.h"
#import "AppDelegate.h"
#import "InterestsViewController.h"
#import "FeedViewController.h"
#import "LeftMenuViewController.h"
#import "ECSlidingViewController.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
//    [PFUser logOut];
    
//    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)LoginButtonAction:(id)sender
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
    
    [PFFacebookUtils logInWithPermissions:@[@"public_profile", @"email", @"user_friends",@"user_likes"] block:^(PFUser *user, NSError *error)
     {
         if (user != nil)
         {
           //  if (user[PF_USER_FACEBOOKID] == nil)
             {
                 [self requestFacebook:user];
             }
//             else {
//    
//                 
//             }
         }
         
     }];
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)requestFacebook:(PFUser *)user
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
    FBRequest *request = [FBRequest requestForMe];
    [request startWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error)
     {
         if (error == nil)
         {
             NSDictionary *userData = (NSDictionary *)result;
             [self processFacebook:user UserData:userData];
         }
         else
         {
             [PFUser logOut];
         }
     }];
}

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)processFacebook:(PFUser *)user UserData:(NSDictionary *)userData
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
    NSString *link = [NSString stringWithFormat:@"http://graph.facebook.com/%@/picture?type=large", userData[@"id"]];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:link]];
    //---------------------------------------------------------------------------------------------------------------------------------------------
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFImageResponseSerializer serializer];
    //---------------------------------------------------------------------------------------------------------------------------------------------
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         UIImage *image = (UIImage *)responseObject;
         //-----------------------------------------------------------------------------------------------------------------------------------------
         if (image.size.width > 140) image = ResizeImage(image, 140, 140);
         //-----------------------------------------------------------------------------------------------------------------------------------------
         PFFile *filePicture = [PFFile fileWithName:@"picture.jpg" data:UIImageJPEGRepresentation(image, 0.6)];
         [filePicture saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error)
          {
          //    if (error != nil) [ProgressHUD showError:error.userInfo[@"error"]];
          }];
         //-----------------------------------------------------------------------------------------------------------------------------------------
         if (image.size.width > 30) image = ResizeImage(image, 30, 30);
         //-----------------------------------------------------------------------------------------------------------------------------------------
         PFFile *fileThumbnail = [PFFile fileWithName:@"thumbnail.jpg" data:UIImageJPEGRepresentation(image, 0.6)];
         [fileThumbnail saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error)
          {
         //     if (error != nil) [ProgressHUD showError:error.userInfo[@"error"]];
          }];
         //-----------------------------------------------------------------------------------------------------------------------------------------
         user[PF_USER_EMAIL] = userData[@"email"];
         user[PF_USER_FULLNAME] = userData[@"name"];
         user[PF_USER_FULLNAME_LOWER] = [userData[@"name"] lowercaseString];
         user[PF_USER_FACEBOOKID] = userData[@"id"];
         user[PF_USER_PICTURE] = filePicture;
         user[PF_USER_THUMBNAIL] = fileThumbnail;
         [user saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error)
          {
              if (error == nil)
              {
                  [FBRequestConnection startWithGraphPath:@"/me/friends"
                                               parameters:nil
                                               HTTPMethod:@"GET"
                                        completionHandler:^(
                                                            FBRequestConnection *connection,
                                                            id result,
                                                            NSError *error
                                                            ) {
                                            /* handle the result */
                                            NSLog(@"response = %@",result);
                                            
                                            
                                            if (error==nil) {
                                                [PFCloud callFunctionInBackground:@"updateFriends"
                                                                   withParameters:[NSDictionary dictionaryWithObjectsAndKeys:result[@"data"], @"user_friends",[PFUser currentUser].objectId,@"user_id", nil]
                                                                            block:^(id results, NSError *error) {
                                                                                if (!error) {
                                                                                    // this is where you handle the results and change the UI.
                                                                                    NSLog(@"results = %@",result);
                                                                                    
                                                                                    //Go inside App
                                                                                    
                                                                                    
                                                                                    [self loginSuccess];
                                                                                    
                                                                                }
                                                                            }];
                                            }
                                            
                                            
                                        }];
                  
                  
             //     [self userLoggedIn:user];
              }
              else
              {
                  [PFUser logOut];
              }
          }];
     }
    failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         [PFUser logOut];
        // [ProgressHUD showError:@"Failed to fetch Facebook profile picture."];
     }];
    //---------------------------------------------------------------------------------------------------------------------------------------------
    [[NSOperationQueue mainQueue] addOperation:operation];
}
-(void)loginSuccess{
    
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    InterestsViewController *IVVC = [storyBoard instantiateViewControllerWithIdentifier:@"InterestsViewController"];
    
    [self.navigationController pushViewController:IVVC animated:YES];
}

@end
