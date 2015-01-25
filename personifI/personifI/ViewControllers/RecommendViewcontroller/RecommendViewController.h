//
//  RecommendViewController.h
//  personifI
//
//  Created by Madhan Prakash on 25/01/15.
//  Copyright (c) 2015 personifIInc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XDPopupListView.h"

@interface RecommendViewController : UIViewController<UITextFieldDelegate, XDPopupListViewDataSource, XDPopupListViewDelegate>
- (IBAction)CloseAction:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *mTextField;

@property (nonatomic) XDPopupListView *mTextDropDownListView;

@end
