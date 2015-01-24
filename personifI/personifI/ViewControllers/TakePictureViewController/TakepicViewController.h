//
//  TakepicViewController.h
//  personifI
//
//  Created by Madhan Prakash on 24/01/15.
//  Copyright (c) 2015 personifIInc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface TakepicViewController : UIViewController<UIImagePickerControllerDelegate,UITextViewDelegate,UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate>{
    
    NSData *imageData;
    NSString *userEnteredText;
    NSString* fieldNameText;
    UIPickerView * pickerView;
    UIToolbar* toolBar;
    NSMutableArray* Typearray;
    NSString *Selectedtypetext;

    
    
}
@property (strong, nonatomic) IBOutlet UILabel *selecttypeLabal;
@property (strong, nonatomic) IBOutlet UIImageView *ImageView;
@property (strong, nonatomic) IBOutlet UIButton *takepicLabel;
@property (strong, nonatomic) AVCaptureSession * captureSession;
- (IBAction)TakPicAction:(id)sender;
@property UIView *overLayView;
@property (strong,nonatomic) UITextView * textview;
@property (strong,nonatomic) UILabel * overLayViewTextView;
@property (strong, nonatomic) IBOutlet UITextField *FieldName;
@property (strong, nonatomic) IBOutlet UILabel *aboutLabel;
@property (strong, nonatomic) IBOutlet UILabel *typeLabel;
@property (strong, nonatomic) IBOutlet UITextField *typetextField;

@end
