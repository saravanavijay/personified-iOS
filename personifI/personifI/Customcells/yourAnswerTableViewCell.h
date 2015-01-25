//
//  yourAnswerTableViewCell.h
//  personifI
//
//  Created by Madhan Prakash on 25/01/15.
//  Copyright (c) 2015 personifIInc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SZTextView.h"

@protocol yourCellDelegate;

@interface yourAnswerTableViewCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UILabel *lblHeader;
@property (weak, nonatomic) IBOutlet UILabel *labelRecommendation;
@property (weak, nonatomic) IBOutlet SZTextView *textView;
@property (weak, nonatomic) IBOutlet UIButton *sendButton;
- (IBAction)sendButtonClick:(id)sender;

@property(weak) id<yourCellDelegate> delegate;

@end
@protocol yourCellDelegate <NSObject>

-(void)didSendButtonTap:(yourAnswerTableViewCell *)cell;

@end