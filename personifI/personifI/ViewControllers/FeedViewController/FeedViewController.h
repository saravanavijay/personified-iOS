//
//  FeedViewController.h
//  Personif-I
//
//  Created by Madhan Prakash on 24/01/15.
//  Copyright (c) 2015 Madhan Prakash. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FeedViewController : UIViewController

@property (weak, nonatomic) IBOutlet UICollectionView *cv;

@property (strong, nonatomic) IBOutlet UIButton *OwnProdAction;

@property (strong, nonatomic) IBOutlet UIButton *interesrProdAction;
@property (strong, nonatomic) IBOutlet UIButton *LinkPostAction;
- (IBAction)recommendClick:(id)sender;
@end
