//
//  NewListViewController.h
//  WordCountB1
//
//  Created by Brandon Ashton on 9/1/12.
//  Copyright (c) 2012 abc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WordListModel;

@interface NewListViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *titleBox;
@property (weak, nonatomic) IBOutlet UITextField *word1Box;
@property (weak, nonatomic) IBOutlet UITextField *word2Box;
@property (weak, nonatomic) IBOutlet UITextField *word3Box;
@property (weak, nonatomic) IBOutlet UITextField *word4Box;
@property (strong, nonatomic) WordListModel *inputList;

- (IBAction)saveList:(UIButton *)sender;
- (IBAction)cancelList:(UIButton *)sender;
- (WordListModel *)newListWords;
@end
