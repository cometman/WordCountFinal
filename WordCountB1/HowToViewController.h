//
//  HowToViewController.h
//  WordCountB1
//
//  Created by Brandon Ashton on 8/29/12.
//  Copyright (c) 2012 abc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WordCountViewController.h"

@interface HowToViewController : UIViewController

@property (nonatomic, strong) WordCountViewController *wordCountVCReference;
@property (nonatomic, strong) UIView *coverView;
@property (strong, nonatomic) IBOutlet UIView *howToScrollView;
@property (strong, nonatomic) IBOutlet UIView *clearViewBG;

@property (nonatomic, strong) UIImage* howToImage;
@property (nonatomic, strong) UIImageView* howToImageView;
@property (nonatomic, strong) UIImageView* howToImageView2;
@property (nonatomic, strong) UIImageView* howToImageView3;

@property (nonatomic, strong) UIImage* howToImage1;
@property (nonatomic, strong) UIImage* howToImage2;
@property (nonatomic, strong) UIImage* howToImage3;

@property (weak, nonatomic) IBOutlet UIPageControl *pageIndicator;

-(void) createHowToWithStep1;
-(void) slideHowToLeft;
-(void) slideHowToRight;
@end
