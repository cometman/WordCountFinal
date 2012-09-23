//
//  HowToViewController.m
//  WordCountB1
//
//  Created by Brandon Ashton on 8/29/12.
//  Copyright (c) 2012 abc. All rights reserved.
//

#import "HowToViewController.h"

// Step 1 text: Find a repetitive friend
// Step 2 text: Pull out the app and count
// Step 3 text: Let everyone know about it

@interface HowToViewController ()

@end

@implementation HowToViewController

@synthesize coverView = _coverView;
@synthesize wordCountVCReference = _wordCountVCReference;
@synthesize clearViewBG = _clearViewBG;
@synthesize howToScrollView = _howToScrollView;

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
    
    
    
    UITapGestureRecognizer *touchHowToScrollView = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(userTappedScrollView:)];
    
    UITapGestureRecognizer *touchBackground = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(userTappedBackground:)];
//    self.delegate = self.parentViewController;
    self.coverView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame];
    _coverView.backgroundColor = [UIColor blackColor];
    [self.howToScrollView addGestureRecognizer:touchHowToScrollView];
    [self.clearViewBG addGestureRecognizer:touchBackground];
    self.howToScrollView.userInteractionEnabled = YES;
    
    self.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.coverView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
}

-(void) userTappedScrollView:(UITapGestureRecognizer *)gestureRecognizer
{
    NSLog(@"Test");
}

-(void) userTappedBackground:(UITapGestureRecognizer *)gestureRecognizer
{
    NSLog(@"Background");
     [self.wordCountVCReference dismissSemiModalViewController:self];
}
- (void)viewDidUnload
{
    [self setHowToScrollView:nil];
    [self setClearViewBG:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
