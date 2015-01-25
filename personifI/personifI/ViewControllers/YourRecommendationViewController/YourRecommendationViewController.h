//
//  YourRecommendationViewController.h
//  personifI
//
//  Created by Madhan Prakash on 25/01/15.
//  Copyright (c) 2015 personifIInc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface YourRecommendationViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *yourRecTableView;

@property (nonatomic) PFObject* recommendation;

@end
