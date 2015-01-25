//
//  yourAnswerTableViewCell.m
//  personifI
//
//  Created by Madhan Prakash on 25/01/15.
//  Copyright (c) 2015 personifIInc. All rights reserved.
//

#import "yourAnswerTableViewCell.h"
#import <QuartzCore/QuartzCore.h>

@implementation yourAnswerTableViewCell

- (void)awakeFromNib {
    // Initialization code
    
    [self.textView.layer setBorderColor:[[[UIColor grayColor] colorWithAlphaComponent:0.5] CGColor]];
    [self.textView.layer setBorderWidth:2.0];
    
    //The rounded corner part, where you specify your view's corner radius:
    self.textView.layer.cornerRadius = 5;
    self.textView.clipsToBounds = YES;
    //self.textView.placeholder =@"That";
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)sendButtonClick:(id)sender {
    
    [self.delegate didSendButtonTap:self];
}
@end
