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
@property (weak, nonatomic) IBOutlet UIView *howToScrollView;
@property (strong, nonatomic) IBOutlet UIView *clearViewBG;

@property (nonatomic, weak) UIImage* howToImage;
@property (nonatomic, weak) UIImageView* howToImageView;

-(void) createHowToWithStep1;

@end
