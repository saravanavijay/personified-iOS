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

- (IBAction)ownedAction:(id)sender;
- (IBAction)InterestedProdList:(id)sender;

@property (strong, nonatomic) IBOutlet UIButton *interesrProdAction;
@property (strong, nonatomic) IBOutlet UIButton *LinkPostAction;
- (IBAction)recommendClick:(id)sender;
@end
