//
//  FeedViewController.m
//  Personif-I
//
//  Created by Madhan Prakash on 24/01/15.
//  Copyright (c) 2015 Madhan Prakash. All rights reserved.
//

#import "FeedViewController.h"
#import "ECSlidingViewController.h"
#import <Parse/Parse.h>
#import "ViewController.h"
#import "FRGWaterfallCollectionViewCell.h"
#import "FRGWaterfallCollectionViewLayout.h"
#import "TakepicViewController.h"

static NSString* const WaterfallCellIdentifier = @"WaterfallCell";
static NSString* const WaterfallHeaderIdentifier = @"WaterfallHeader";


@interface FeedViewController ()<FRGWaterfallCollectionViewDelegate, UICollectionViewDelegate>
@property (nonatomic, strong) NSMutableArray *cellHeights;

@property (nonatomic) NSMutableArray *feeds;
@end

@implementation FeedViewController

//-------------------------------------------------------------------------------------------------------------------------------------------------
- (void)viewDidAppear:(BOOL)animated
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
    [super viewDidAppear:animated];
    
    //---------------------------------------------------------------------------------------------------------------------------------------------
    if ([PFUser currentUser] != nil)
    {
        
        [PFCloud callFunctionInBackground:@"getFeed"
                           withParameters:[NSDictionary dictionaryWithObjectsAndKeys:@"tAQ4QzF6wp",@"userId", nil]
                                    block:^(id results, NSError *error) {
                                        if (!error) {
                                            // this is where you handle the results and change the UI.
                                            NSLog(@"results = %@",results);
                                            
                                            //Go inside App
                                            
                                            self.feeds = [NSMutableArray arrayWithArray:results];
                                            [self refreshTable];
                                            
                                        }
                                    }];
        
        
    }
    else{
        
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        ViewController *loginView = [sb instantiateViewControllerWithIdentifier:@"ViewController"];
        
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:loginView];
        [self presentViewController:navigationController animated:YES completion:nil];
    }
}

-(void)refreshTable{
    self.cv.delegate = self;
    
    FRGWaterfallCollectionViewLayout *cvLayout = [[FRGWaterfallCollectionViewLayout alloc] init];
    cvLayout.delegate = self;
    cvLayout.itemWidth = 140.0f;
    cvLayout.topInset = 10.0f;
    cvLayout.bottomInset = 10.0f;
    cvLayout.stickyHeader = YES;
    
    [self.cv setCollectionViewLayout:cvLayout];
    [self.cv reloadData];
    [self performSelector:@selector(scrollNow:) withObject:nil afterDelay:0.5];
}


-(void)scrollNow:(id)sender{
    [self.cv scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] atScrollPosition:UICollectionViewScrollPositionTop animated:NO];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIButton *btnNext1 =[[UIButton alloc] init];
    [btnNext1 setBackgroundImage:[UIImage imageNamed:@"FeedSettings"] forState:UIControlStateNormal];
    
    btnNext1.frame = CGRectMake(100, 100, 26, 26);
    UIBarButtonItem *btnNext =[[UIBarButtonItem alloc] initWithCustomView:btnNext1];
    [btnNext1 addTarget:self action:@selector(showMenu) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = btnNext;
    
    
    UIImageView *titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Logo"]];
    [self.navigationController.navigationBar.topItem setTitleView:titleView];

}
- (void)showMenu
{
    //  if (![[NSUserDefaults standardUserDefaults]objectForKey:@"Selected_plan"]==0)
    
    [self.slidingViewController anchorTopViewTo:ECRight];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
    return self.feeds.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    FRGWaterfallCollectionViewCell *waterfallCell = [collectionView dequeueReusableCellWithReuseIdentifier:WaterfallCellIdentifier
                                                                                              forIndexPath:indexPath];
    
    NSDictionary* feedDict = [self.feeds objectAtIndex:indexPath.item];
    
    if ([[feedDict objectForKey:@"type"] isEqualToString:@"product"]) {
        PFObject* feed = [feedDict objectForKey:@"data"];
        
        PFUser* feedUser = [feed objectForKey:@"userId"];
//        waterfallCell.labelTitle.text =
        
        NSString* titleStr;
        
        if ([feed[@"feedType"] isEqualToString:@"Own"]) {
            titleStr = [NSString stringWithFormat:@"%@ owns %@",feedUser[@"fullname"],feed[@"feedName"]];
        }
        else if ([feed[@"feedType"] isEqualToString:@"Interest"])
        {
             titleStr = [NSString stringWithFormat:@"%@ is interested in %@",feedUser[@"fullname"],feed[@"feedName"]];
        }
        
        waterfallCell.labelTitle.text = titleStr;
        
        
        [waterfallCell.feedImage setFile:feed[@"feedImage"]];
        [waterfallCell.feedImage loadInBackground:^(UIImage *image, NSError *error) {
            if (image) {
                NSLog(@"Got Image");
            }
        }];
        
        waterfallCell.btnLike.hidden = NO;
        waterfallCell.btnShare.hidden = YES;
        waterfallCell.linkImage1.hidden = YES;
        waterfallCell.feedImage.hidden = NO;
    }
    else
    {
        NSString* titleStr;
        if ([[feedDict objectForKey:@"type"] isEqualToString:@"link"]) {
            
            PFObject* feed = [feedDict objectForKey:@"data"];
            PFUser* feedUser = [feed objectForKey:@"userId"];
            titleStr = [NSString stringWithFormat:@"%@ shared about %@",feedUser[@"fullname"],feed[@"feedName"]];
        }
        else
        {
            titleStr = [NSString stringWithFormat:@"%@",feedDict[@"d"]];
        }
        
        waterfallCell.labelTitle.text = titleStr;
        waterfallCell.feedImage.image = [UIImage imageNamed:@"likeImg"];
        
        waterfallCell.btnLike.hidden = YES;
        waterfallCell.btnShare.hidden = NO;
        waterfallCell.linkImage1.hidden = NO;
        waterfallCell.feedImage.hidden = YES;
    }
    return waterfallCell;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(FRGWaterfallCollectionViewLayout *)collectionViewLayout
 heightForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary* feedDict = [self.feeds objectAtIndex:indexPath.item];
    if ([[feedDict objectForKey:@"type"] isEqualToString:@"product"]) {
        return 200;
    }
    else
    {
        return 120;
    }
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    FRGWaterfallCollectionViewCell *waterfallCell = (FRGWaterfallCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    
    NSDictionary* feedDict = [self.feeds objectAtIndex:indexPath.item];
    
    if ([[feedDict objectForKey:@"type"] isEqualToString:@"product"]) {
        PFObject* feed = [feedDict objectForKey:@"data"];
        
        PFUser* feedUser = [feed objectForKey:@"userId"];
        
       
        
   
        if (waterfallCell.labelTitle.frame.size.height==33) {
            [UIView animateWithDuration:1.0 animations:^{
                // Scale down 50%
                waterfallCell.labelTitle.frame = CGRectMake(waterfallCell.labelTitle.frame.origin.x, waterfallCell.labelTitle.frame.origin.y, waterfallCell.labelTitle.frame.size.width, 120);
                
                 waterfallCell.labelBg.frame = CGRectMake(waterfallCell.labelBg.frame.origin.x, waterfallCell.labelBg.frame.origin.y, waterfallCell.labelBg.frame.size.width, 120);
                
            } completion:^(BOOL finished) {
                NSString* titleStr;
                
                if ([feed[@"feedType"] isEqualToString:@"Own"]) {
                    titleStr = [NSString stringWithFormat:@"%@ owns %@",feedUser[@"fullname"],feed[@"feedName"]];
                }
                else if ([feed[@"feedType"] isEqualToString:@"Interest"])
                {
                    titleStr = [NSString stringWithFormat:@"%@ is interested in %@",feedUser[@"fullname"],feed[@"feedName"]];
                }
                titleStr = [titleStr stringByAppendingString:[NSString stringWithFormat:@"\n\n %@",feed[@"feedDescription"]]];
                waterfallCell.labelTitle.text = titleStr;
            }];
        }
        else
        {
            [UIView animateWithDuration:1.0 animations:^{
                waterfallCell.labelTitle.frame = CGRectMake(waterfallCell.labelTitle.frame.origin.x, waterfallCell.labelTitle.frame.origin.y, waterfallCell.labelTitle.frame.size.width, 33);
                waterfallCell.labelBg.frame = CGRectMake(waterfallCell.labelBg.frame.origin.x, waterfallCell.labelBg.frame.origin.y, waterfallCell.labelBg.frame.size.width, 33);
            } completion:^(BOOL finished) {
                NSString* titleStr;
                if ([feed[@"feedType"] isEqualToString:@"Own"]) {
                    titleStr = [NSString stringWithFormat:@"%@ owns %@",feedUser[@"fullname"],feed[@"feedName"]];
                }
                else if ([feed[@"feedType"] isEqualToString:@"Interest"])
                {
                    titleStr = [NSString stringWithFormat:@"%@ is interested in %@",feedUser[@"fullname"],feed[@"feedName"]];
                }
                
                waterfallCell.labelTitle.text = titleStr;
            }];
        }
     }
}

//- (NSMutableArray *)cellHeights {
//    if (!_cellHeights) {
//        _cellHeights = [NSMutableArray arrayWithCapacity:900];
//        for (NSInteger i = 0; i < 900; i++) {
//            _cellHeights[i] =@(arc4random()%100*2+100);
//        }
//    }
//    return _cellHeights;
//}




- (IBAction)ownedAction:(id)sender {
    
    UIStoryboard *sb=[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle  mainBundle]];

  TakepicViewController * takePic=[sb instantiateViewControllerWithIdentifier:@"TakepicViewController"];
    
    takePic.Selectedtypetext=@"Own";
    
      [self presentViewController:takePic animated:YES completion:nil];
    


}

- (IBAction)InterestedProdList:(id)sender {
    
    UIStoryboard *sb=[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle  mainBundle]];
    
    TakepicViewController * takePic=[sb instantiateViewControllerWithIdentifier:@"TakepicViewController"];
    
    takePic.Selectedtypetext=@"Interest";
    
    [self presentViewController:takePic animated:YES completion:nil];
    
    
}

@end
