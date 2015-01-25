//
//  TakepicViewController.m
//  personifI
//
//  Created by Madhan Prakash on 24/01/15.
//  Copyright (c) 2015 personifIInc. All rights reserved.
//

#import "TakepicViewController.h"
#import "ECSlidingViewController.h"
#import <Parse/Parse.h>


@interface TakepicViewController ()

@end

@implementation TakepicViewController

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
    
//    Typearray=[[NSMutableArray alloc]initWithObjects:@"Interest",@"Own",@"Link", nil];
    
    
    
   // _typetextField.enabled=NO;
    UITapGestureRecognizer *tapGestureRecognizer2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(typetextFieldTapped)];
    tapGestureRecognizer2.numberOfTapsRequired = 1;
    [_selecttypeLabal addGestureRecognizer:tapGestureRecognizer2];
    _selecttypeLabal.userInteractionEnabled = YES;
    
    
    
    
    _FieldName.delegate=self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


    
    
    

- (void)showMenu
{
    //  if (![[NSUserDefaults standardUserDefaults]objectForKey:@"Selected_plan"]==0)
    
    [self.slidingViewController anchorTopViewTo:ECRight];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark - Image Picker Controller delegate methods

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    
    _overLayView = [[UIView alloc] init];
    _overLayView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
    _overLayView.frame = self.view.bounds;
   
    
    [self.view addSubview:_overLayView];
    
    
    _overLayViewTextView=[[UILabel alloc]init];
    _overLayViewTextView.frame=CGRectMake(10, 80, 300, 30);
    _overLayViewTextView.textAlignment=NSTextAlignmentCenter;
    _overLayViewTextView.text=@"Tell SomeThing About the pic";
    _overLayViewTextView.font=[UIFont fontWithName:@"Courier-Bold" size:16];
    _overLayViewTextView.textColor=[UIColor blackColor];
    [_overLayView addSubview:_overLayViewTextView];
    
    
    
    _textview=[[UITextView alloc]init];
    _textview.frame=CGRectMake(20, 150, 320, 200);
    [_textview setFont:[UIFont systemFontOfSize:20]];
    [_textview setFont:[UIFont fontWithName:@"AvenirNext-BoldItalic" size:18]];
    _textview.backgroundColor=[UIColor clearColor];
    [[UITextView appearance] setTintColor:[UIColor whiteColor]];
    
    _textview.delegate=self;
   
    _textview.userInteractionEnabled = YES;
    [_textview becomeFirstResponder];
    
    [_overLayView addSubview:_textview];
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    self.ImageView.image = chosenImage;
    imageData = UIImagePNGRepresentation(chosenImage);

   // NSLog(@"chosenimage %@",imageData);

  //  NSData *imageData = UIImagePNGRepresentation(image);
//    PFFile *imageFile = [PFFile fileWithName:@"image.png" data:imageData];

//    PFObject *userPhoto = [PFObject objectWithClassName:@"TestObject"];
//    userPhoto[@"foo"] = @"My trip to Hawaii!";
//    userPhoto[@"Image"] = imageFile;
//    [userPhoto saveInBackground];



    [picker dismissViewControllerAnimated:YES completion:NULL];

}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {

    [picker dismissViewControllerAnimated:YES completion:NULL];

}

- (IBAction)TakPicAction:(id)sender {
    
    if (!fieldNameText.length == 0 || !fieldNameText==nil){
    
    _FieldName.hidden=YES;
    _aboutLabel.hidden=YES;
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    [self presentViewController:picker animated:YES completion:NULL];
    
    
    }
    
    
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    
    if([text isEqualToString:@"\n"]) {
        NSLog(@"userEnteredText %@",textView.text);
         userEnteredText  =  textView.text;
        [textView resignFirstResponder];
        
        [_overLayView removeFromSuperview];
      
        
        PFObject *userPhoto = [PFObject objectWithClassName:@"Feed"];
      PFFile *imageFile = [PFFile fileWithName:@"image.png" data:imageData];
        
            userPhoto[@"feedDescription"] = userEnteredText;
            userPhoto[@"feedDescription"] = userEnteredText;
        
             userPhoto[@"feedName"]=fieldNameText;
        userPhoto[@"feedType"]=_Selectedtypetext;
            userPhoto[@"feedImage"] = imageFile;
        PFUser * User=[PFUser currentUser];
        userPhoto[@"userId"]=User;
        
        
            [userPhoto saveInBackground];
        
        _FieldName.hidden=NO;
        _aboutLabel.hidden=NO;
        
        
        
        
        return NO;
    }
    
    return YES;
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    

    
    if ([textField canResignFirstResponder]) {
        [textField resignFirstResponder];
    }
    
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    fieldNameText=textField.text;
     NSLog(@"textfield %@",textField.text);
    
}

- (BOOL) textViewShouldBeginEditing:(UITextView *)textView
{
    
    
    
    
    
    textView.textColor=[UIColor whiteColor];
    
    
    return YES;
    
}

//-(void) textViewDidChange:(UITextView *)textView
//{
//    if(userinputtext.text.length == 0)
//    {
//        userinputtext.textColor = [UIColor lightGrayColor];
//        userinputtext.textColor = [UIColor blackColor];
//        [userinputtext resignFirstResponder];
//    }
//}






@end
