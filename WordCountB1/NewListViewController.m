//
//  NewListViewController.m
//  WordCountB1
//
//  Created by Brandon Ashton on 9/1/12.
//  Copyright (c) 2012 abc. All rights reserved.
//

#import "NewListViewController.h"
#import "WordListModel.h"

@interface NewListViewController ()

@end

@implementation NewListViewController
@synthesize titleBox = _titleBox;
@synthesize word1Box = _word1Box;
@synthesize word2Box = _word2Box;
@synthesize word3Box = _word3Box;
@synthesize word4Box = _word4Box;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [self setTitleBox:nil];
    [self setWord1Box:nil];
    [self setWord2Box:nil];
    [self setWord3Box:nil];
    [self setWord4Box:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)saveList:(UIButton *)sender {
    
}

- (IBAction)cancelList:(UIButton *)sender {
    [self dismissModalViewControllerAnimated:YES];
}

- (WordListModel *)newListWords {
    return [[WordListModel alloc] initWithWords:[@[_word1Box.text, _word2Box.text, _word3Box.text, _word4Box.text] mutableCopy] andTitle:_titleBox.text];
}
@end
