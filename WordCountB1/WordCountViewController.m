//
//  WordCountViewController.m
//  WordCountB1
//
//  Created by Clayton Selby on 8/25/12.
//  Copyright (c) 2012 abc. All rights reserved.
//

#import "WordCountViewController.h"
#import "WordListViewController.h"

@interface WordCountViewController ()

@end

@implementation WordCountViewController

@synthesize wordListView = _wordListView;
@synthesize slideBackButton = _slideBackButton;

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
    self.wordListView = self.view.superview;
    [self.slideBackButton setEnabled:NO];
//    [self createTouchUpForWordCount];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)showWordList:(id)sender {
    
    NSLog(@"Hi");
    CGFloat windowWidth = self.view.frame.size.width;
    CGFloat windowHeight =self.view.frame.size.height;
//    [UIView beginAnimations:nil context:nil];
//    [UIView setAnimationDelay:0.0];
//    [UIView setAnimationDuration:1.0];

//    [UIView commitAnimations];
    
    [UIView animateWithDuration:0.7 delay:0 options:UIViewAnimationCurveEaseInOut animations:^{
            self.view.frame = CGRectMake(windowWidth-50,0, windowWidth, windowHeight);
        
        
        
    } completion:^ (BOOL completed) {
        UIButton *touchBackButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, windowHeight)];
        [self.view addSubview:touchBackButton];
        self.slideBackButton = touchBackButton;
        [touchBackButton addTarget:self action:@selector(slideViewBack) forControlEvents:UITouchPhaseEnded];
        
       
    }];
    
    
    
}

//-(void) createTouchUpForWordCount
//{
//    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleViewTap)];
//    [self.view addGestureRecognizer:tapGesture];
//}

-(void) slideViewBack
{ 
    NSLog(@"Slide back triggered");
    [self.slideBackButton setEnabled:NO];
    CGFloat windowWidth = self.view.frame.size.width;
    CGFloat windowHeight =self.view.frame.size.height;
    
    
    [UIView animateWithDuration:0.7 delay:0 options:UIViewAnimationCurveEaseInOut animations:^{
        self.view.frame = CGRectMake(0,0, windowWidth, windowHeight);
        
        
        
    } completion:nil];
}
//-(void) handleViewTap
//{
//    NSLog(@"Movin back");
//    CGFloat windowWidth = self.view.frame.size.width;
//    CGFloat windowHeight =self.view.frame.size.height;
//    [UIView beginAnimations:nil context:nil];
//    [UIView setAnimationDelay:0.0];
//    [UIView setAnimationDuration:1.0];
//    
//    self.view.frame = CGRectMake(0,0, windowWidth, windowHeight);
//    [UIView commitAnimations];
//}
@end
