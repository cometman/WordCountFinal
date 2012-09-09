//
//  WordListViewController.h
//  WordCountB1
//
//  Created by Clayton Selby on 8/25/12.
//  Copyright (c) 2012 abc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TDSemiModal.h"
#import "NewListViewController.h"

@interface WordListViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, TDNewListControllerDelegate>

@property (nonatomic, strong) UIView* wordCountView;
@property (nonatomic, strong) UITableView *tableView;

- (void)presentSemiModalViewController:(NewListViewController *)vc;
- (void)dismissSemiModalViewController:(NewListViewController *)vc;
- (void)dismissSemiModalViewControllerEnded:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context;

@end
