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
@property (nonatomic, strong) UIButton* orange1;
@property (nonatomic, strong) UIButton* orange2;
@property (nonatomic, strong) UIButton* orange3;
@property (nonatomic, strong) UIButton* orange4;
@property (nonatomic, strong) UIImage* orangeImage;


@property (nonatomic, strong) WCWord *w1;
@property (nonatomic, strong) WCWord *w2;
@property (nonatomic, strong) WCWord *w3;
@property (nonatomic, strong) WCWord *w4;

@property (nonatomic, strong) WordListModel* wordListModel;
- (IBAction)showHowTo:(UIButton *)sender;

- (IBAction)showReportView:(id)sender;
-(void) animateOrangeButton:(UIButton *)buttonToAnimate;

-(void) countWord1:(id) sender;
-(void) countWord2:(id) sender;
-(void) countWord3:(id) sender;
-(void) countWord4:(id) sender;

- (void)slideViewBack;
@end
