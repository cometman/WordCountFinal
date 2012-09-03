//
//  WordCountViewController.h
//  WordCountB1
//
//  Created by Clayton Selby on 8/25/12.
//  Copyright (c) 2012 abc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WordListModel.h"


@interface WordCountViewController : UIViewController

@property (nonatomic, weak) UIView* wordListView;
@property (nonatomic) UIButton* slideBackButton;

@property (nonatomic, strong) UIButton* orange1;
@property (nonatomic, strong) UIButton* orange2;
@property (nonatomic, strong) UIButton* orange3;
@property (nonatomic, strong) UIButton* orange4;
@property (nonatomic, strong) UIImage* orangeImage;

@property (nonatomic, strong) WordListModel* wordListModel;

- (IBAction)showReportView:(id)sender;
-(void) countWord:(id) sender;
- (void)slideViewBack;
@end
