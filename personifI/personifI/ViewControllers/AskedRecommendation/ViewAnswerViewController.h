//
//  ViewAnswerViewController.h
//  personifI
//
//  Created by Madhan Prakash on 25/01/15.
//  Copyright (c) 2015 personifIInc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewAnswerViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *_viewanswerTableView;

@end
