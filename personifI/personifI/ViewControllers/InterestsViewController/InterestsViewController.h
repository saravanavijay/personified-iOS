//
//  InterestsViewController.h
//  Personif-I
//
//  Created by Madhan Prakash on 22/01/15.
//  Copyright (c) 2015 Madhan Prakash. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InterestTableViewCell.h"

@interface InterestsViewController : UIViewController<InterestTableViewCellDelegate,UITableViewDataSource,UITableViewDelegate,UIImagePickerControllerDelegate>

@property (strong, nonatomic) IBOutlet UITableView *InterestTableView;
@property (strong, nonatomic) NSMutableArray * interestArray;
@property (strong, nonatomic) NSMutableArray * interestImages;
@property (strong, nonatomic) NSMutableArray * selectedArray;
@property(nonatomic)  NSInteger  indexStored;

@property (strong, nonatomic) IBOutlet UIButton *nextAction;
@property (strong, nonatomic) IBOutlet UIButton *NextButtonAction;

- (IBAction)NextbuttonAction:(id)sender;


@end
