//
//  AskedRecommendViewController.h
//  personifI
//
//  Created by Madhan Prakash on 25/01/15.
//  Copyright (c) 2015 personifIInc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AskedRecommendViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *askedRecommendTableView;
@property(strong,nonatomic) NSMutableArray* askedrecommendarray;

@end
