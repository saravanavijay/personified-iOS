//
//  LeftMenuViewController.h
//  Personif-I
//
//  Created by Madhan Prakash on 24/01/15.
//  Copyright (c) 2015 Madhan Prakash. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LeftMenuViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *leftMenuTableView;
@property (strong, nonatomic) NSMutableArray * itemsArray;
@end
