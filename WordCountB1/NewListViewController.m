//
//  NewListViewController.m
//  WordCountB1
//
//  Created by Brandon Ashton on 9/1/12.
//  Copyright (c) 2012 abc. All rights reserved.
//

#import "NewListViewController.h"
#import "WordListModel.h"
#import "SharedStore.h"

@interface NewListViewController ()

@end

@implementation NewListViewController

@synthesize delegate;

@synthesize coverView = _coverView; // What is this?

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
    
    // Need to set the subview dimensions or it will not always render correctly
    // http://stackoverflow.com/questions/1088163
    // Trying this commented out due to a warning that's produced. If things get hairy with sizes
    // for the text fields or buttons, then add this in.
//    for (UIView *subview in self.view) {
//        subview.frame = self.view.bounds;
//    }
    self.coverView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame];
    _coverView.backgroundColor = [UIColor blackColor];
    
    self.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.coverView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
}

- (void)viewDidUnload
{
    [self setTitleBox:nil];
    [self setWord1Box:nil];
    [self setWord2Box:nil];
    [self setWord3Box:nil];
    [self setWord4Box:nil];
    self.delegate = nil;
    self.coverView = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)stubSave:(id)sender {
    NSLog(@"Save List");
}

- (IBAction)saveList:(id)sender {
    NSLog(@"Save List");
    WordListModel *newFromUser = [[WordListModel alloc] initWithWords:[NSMutableArray arrayWithObjects:
                                                                       _word1Box.text,
                                                                       _word2Box.text,
                                                                       _word3Box.text,
                                                                       _word4Box.text, nil]
                                                             andTitle:_titleBox.text];
    [[SharedStore sharedList] createListWithList:newFromUser];
    if ([self.delegate respondsToSelector:@selector(listCommit:)]) {
        [self.delegate listCommit:self];
    }
    
    
}

- (IBAction)cancelList:(id)sender {
    if ([self.delegate respondsToSelector:@selector(listCancel:)]) {
        [self.delegate listCancel:self];
    }
}

- (WordListModel *)newListWords {
    return [[WordListModel alloc] initWithWords:[@[_word1Box.text, _word2Box.text, _word3Box.text, _word4Box.text] mutableCopy] andTitle:_titleBox.text];
}

@end
