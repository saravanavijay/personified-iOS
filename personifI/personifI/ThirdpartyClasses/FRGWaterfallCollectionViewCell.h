//
//  FRGWaterfallCollectionViewCell.h
//  WaterfallCollectionView
//
//  Created by Miroslaw Stanek on 12.07.2013.
//  Copyright (c) 2013 Event Info Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface FRGWaterfallCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *labelTitle;
@property (weak, nonatomic) IBOutlet PFImageView *feedImage;
@property (weak, nonatomic) IBOutlet UIButton *btnLike;

- (IBAction)likeClick:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnShare;
@property (weak, nonatomic) IBOutlet UIImageView *linkImage1;

@property (weak, nonatomic) IBOutlet UIView *labelBg;
- (IBAction)shareClick:(id)sender;
@end
