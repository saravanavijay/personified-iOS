//
//  InterestTableViewCell.m
//  Personif-I
//
//  Created by Madhan Prakash on 23/01/15.
//  Copyright (c) 2015 Madhan Prakash. All rights reserved.
//

#import "InterestTableViewCell.h"


@implementation InterestTableViewCell

- (void)awakeFromNib {
    // Initialization code
    
    [self.rightButton setImage:[UIImage imageNamed:@"Follow"] forState:UIControlStateNormal];
    [self.rightButton setImage:[UIImage imageNamed:@"Following"] forState:UIControlStateSelected];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)rightActionButton:(id)sender {
    if([self.delegate respondsToSelector:@selector(userDidSelectedInterestForCell:)])
    {
        
        [self.delegate userDidSelectedInterestForCell:self];
        NSLog(@"from cell %@",sender);
    }
    
    
}
@end
