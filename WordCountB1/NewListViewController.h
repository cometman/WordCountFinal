//
//  NewListViewController.h
//  WordCountB1
//
//  Created by Brandon Ashton on 9/1/12.
//  Copyright (c) 2012 abc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TDSemiModal.h"

@class WordListModel;

@interface NewListViewController : UIViewController {
    id delegate;
}

@property (nonatomic, strong) IBOutlet id delegate;

@property (nonatomic, strong) UIView *coverView;

@property (weak, nonatomic) IBOutlet UITextField *titleBox;
@property (weak, nonatomic) IBOutlet UITextField *word1Box;
@property (weak, nonatomic) IBOutlet UITextField *word2Box;
@property (weak, nonatomic) IBOutlet UITextField *word3Box;
@property (weak, nonatomic) IBOutlet UITextField *word4Box;
@property (strong, nonatomic) WordListModel *inputList;

- (IBAction)stubSave:(id)sender;

- (IBAction)saveList:(id)sender;
- (IBAction)cancelList:(id)sender;
- (WordListModel *)newListWords;

@end

@protocol TDNewListControllerDelegate <NSObject>

- (void)listCommit:(id)viewController;
- (void)listCancel:(id)viewController;

@end