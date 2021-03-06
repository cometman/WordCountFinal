//
//  ReportViewController.h
//  WordCountB1
//
//  Created by Clayton Selby on 8/27/12.
//  Copyright (c) 2012 abc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReportButton.h"
#import "WordListModel.h"
#import "FaceBookViewController.h"
#import "Reachability.h"

@interface ReportViewController : UIViewController
@property (nonatomic) ReportButton* button1;
@property (nonatomic) ReportButton* button2;
@property (nonatomic) ReportButton* button3;
@property (nonatomic) ReportButton* button4;
@property (nonatomic, strong) FaceBookViewController* faceBookViewController;


-(BOOL) isInternetConnected;

- (IBAction)shareOnFacebook:(id)sender;

- (void) buildCountButtons:(NSMutableArray *)words;
- (void) takeViewScreenShot;
- (IBAction)postATweet:(id)sender;
- (IBAction)pushFinishButton:(id)sender;

@end
