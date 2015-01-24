//
//  InterestTableViewCell.h
//  Personif-I
//
//  Created by Madhan Prakash on 23/01/15.
//  Copyright (c) 2015 Madhan Prakash. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol InterestTableViewCellDelegate <NSObject>

- (void)userDidSelectedInterestForCell:(id)cell;

@end

@interface InterestTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *interestLabel;
@property (strong, nonatomic) IBOutlet UIButton *rightButton;
@property (nonatomic, weak) id<InterestTableViewCellDelegate> delegate;
- (IBAction)rightActionButton:(id)sender;

@end
