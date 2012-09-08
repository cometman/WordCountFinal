//
//  WordCountViewController.h
//  WordCountB1
//
//  Created by Clayton Selby on 8/25/12.
//  Copyright (c) 2012 abc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WordListModel.h"
#import "CountButton.h"


@interface WordCountViewController : UIViewController

@property (nonatomic, weak) UIView* wordListView;
@property (nonatomic) UIButton* slideBackButton;

@property (nonatomic, strong) CountButton* button1;
@property (nonatomic, strong) CountButton* button2;
@property (nonatomic, strong) CountButton* button3;
@property (nonatomic, strong) CountButton* button4;

@property (nonatomic, strong) WCWord *w1;
@property (nonatomic, strong) WCWord *w2;
@property (nonatomic, strong) WCWord *w3;
@property (nonatomic, strong) WCWord *w4;

- (IBAction)showHowTo:(UIButton *)sender;

- (IBAction)showReportView:(id)sender;
-(void) animateOrangeButton:(UIButton *)buttonToAnimate;

- (void)slideViewBack;

@end
