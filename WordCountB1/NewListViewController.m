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
#import "WCWord.h"

@interface NewListViewController ()
@property (weak, nonatomic) IBOutlet UIButton *saveButton;

@end

@implementation NewListViewController

@synthesize delegate;

@synthesize coverView = _coverView;

@synthesize titleBox = _titleBox;
@synthesize word1Box = _word1Box;
@synthesize word2Box = _word2Box;
@synthesize word3Box = _word3Box;
@synthesize word4Box = _word4Box;
@synthesize tableView = _tableView;
@synthesize saveButton = _saveButton;

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
    
    [self.view respondsToSelector:UITouchPhaseBegan];
    
    // Need to set the subview dimensions or it will not always render correctly
    // http://stackoverflow.com/questions/1088163
    // Trying this commented out due to a warning that's produced. If things get hairy with sizes
    // for the text fields or buttons, then add this in.
//    for (UIView *subview in self.view) {
//        subview.frame = self.view.bounds;
//    }
    self.delegate = self.parentViewController;
    self.coverView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame];
    _coverView.backgroundColor = [UIColor blackColor];
    
    [self.titleBox addTarget:self action:@selector(hitReturnButton:) forControlEvents:UIControlEventEditingDidEndOnExit];
    [self.word1Box addTarget:self action:@selector(hitReturnButton:) forControlEvents:UIControlEventEditingDidEndOnExit];
    [self.word2Box addTarget:self action:@selector(hitReturnButton:) forControlEvents:UIControlEventEditingDidEndOnExit];
    [self.word3Box addTarget:self action:@selector(hitReturnButton:) forControlEvents:UIControlEventEditingDidEndOnExit];
    [self.word4Box addTarget:self action:@selector(hitReturnButton:) forControlEvents:UIControlEventEditingDidEndOnExit];
    
    self.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.coverView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    // Disable save button if there is no title
}

- (void)hitReturnButton:(id)sender {
    [sender resignFirstResponder];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.titleBox.text = nil;
    self.titleBox.placeholder = @"Word List Title";
    self.word1Box.text = nil;
    self.word2Box.text = nil;
    self.word3Box.text = nil;
    self.word4Box.text = nil;
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
    [self setSaveButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)saveList:(id)sender {
    if (self.titleBox.text == nil) {
        self.titleBox.placeholder = @"You have to enter a title to save";
    } else {
        if (self.word1Box.text == nil) {
            self.word1Box.text = @"Like";
        }
        if (self.word2Box.text == nil) {
            self.word2Box.text = @"Umm";
        }
        if (self.word3Box.text == nil) {
            self.word3Box.text = @"Basically";
        }
        if (self.word4Box.text == nil) {
            self.word4Box.text = @"You Know";
        }
        NSLog(@"Save List");
        WCWord *word1 = [[WCWord alloc] initWithWord:_word1Box.text andCount:0];
        WCWord *word2 = [[WCWord alloc] initWithWord:_word2Box.text andCount:0];
        WCWord *word3 = [[WCWord alloc] initWithWord:_word3Box.text andCount:0];
        WCWord *word4 = [[WCWord alloc] initWithWord:_word4Box.text andCount:0];
        WordListModel *newFromUser = [[WordListModel alloc] initWithWords:[NSMutableArray arrayWithObjects:
                                                                           word1,
                                                                           word2,
                                                                           word3,
                                                                           word4, nil]
                                                                 andTitle:_titleBox.text];
        [[SharedStore sharedList] createListWithList:newFromUser];
        
        [self dismissSemiModalViewController:self];
        [self.tableView reloadData];
        NSLog(@"Testing %d", [[self.tableView indexPathsForVisibleRows] count]);
    }
    
}

- (IBAction)cancelList:(id)sender {
//    if ([self.delegate respondsToSelector:@selector(listCancel:)]) {
//        [self.delegate listCancel:self];
//    }
    [self dismissSemiModalViewController:self];
}
- (WordListModel *)newListWords {
    return [[WordListModel alloc] initWithWords:[@[_word1Box.text, _word2Box.text, _word3Box.text, _word4Box.text] mutableCopy] andTitle:_titleBox.text];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.titleBox resignFirstResponder];
    [self.word1Box resignFirstResponder];
    [self.word2Box resignFirstResponder];
    [self.word3Box resignFirstResponder];
    [self.word4Box resignFirstResponder];
}

- (void) dismissSemiModalViewController:(NewListViewController *)vc {
    double animationDelay = 0.7;
    UIView *modalView = vc.view;
    UIView *coverView = vc.coverView;
    
    CGSize offSize = [UIScreen mainScreen].bounds.size;
    
    CGPoint offScreenCenter = CGPointZero;
    
    offScreenCenter = CGPointMake(offSize.width / 2.0, offSize.height * 1.5);
    
    [UIView beginAnimations:nil context:(__bridge void *)(modalView)];
    [UIView setAnimationDuration:animationDelay];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(dismissSemiModalViewControllerEnded:finished:context:)];
    modalView.center = offScreenCenter;
    coverView.alpha = 0.0f;
    [UIView commitAnimations];
    
    [coverView performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:animationDelay];
}


@end
