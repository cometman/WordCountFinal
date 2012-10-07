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
@synthesize howToImage = _howToImage;
@synthesize howToImageView = _howToImageView;
@synthesize howToImageView2 = _howToImageView2;
@synthesize howToImageView3 = _howToImageView3;
@synthesize howToImage1 = _howToImage1;
@synthesize howToImage2 = _howToImage2;
@synthesize howToImage3 = _howToImage3;
@synthesize pageIndicator = _pageIndicator;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
         
        // Custom initialization
    }
    return self;
}

/*
 * Important Note:  In order to get this method to work we had to add touch events to the both UIView siblings.  If wee added to just one, the event would register on the backgorund touch as well as the how-to content area touch
 *
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.howToImage1 = [UIImage imageNamed:@"howToStep1"];
    self.howToImage2 = [UIImage imageNamed:@"howToStep2"];
    self.howToImage3 = [UIImage imageNamed:@"howToStep3"];
    
    [self createHowToWithStep1];
    UITapGestureRecognizer *touchHowToScrollView = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(userTappedScrollView:)];
    
    UITapGestureRecognizer *touchBackground = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(userTappedBackground:)];
    self.coverView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame];
    _coverView.backgroundColor = [UIColor blackColor];
    [self.howToScrollView addGestureRecognizer:touchHowToScrollView];
    [self.clearViewBG addGestureRecognizer:touchBackground];
    self.howToScrollView.userInteractionEnabled = YES;
    
    self.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.coverView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    UISwipeGestureRecognizer* slideLeftGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(slideHowToLeft:)];
    [slideLeftGesture setDirection:UISwipeGestureRecognizerDirectionLeft];
    
    UISwipeGestureRecognizer* slideRightGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(slideHowToRight:)];
    [slideRightGesture setDirection:UISwipeGestureRecognizerDirectionRight];
    
    
    

    [self.howToScrollView addGestureRecognizer:slideRightGesture];
    [self.howToScrollView addGestureRecognizer:slideLeftGesture];
    
 
}

-(void) slideHowToLeft:(id) sender
{
    NSLog(@"Weee!");
    
    // Allow a slide to the left as long as we arent on the 3rd how to slide
    if (self.howToImageView.frame.origin.x > -640)
    {
        [UIView animateWithDuration:1.0 animations:^{
            self.howToImageView.frame = CGRectMake(self.howToImageView.frame.origin.x-320, 5, self.view.frame.size.width-35, 283);
        }];
        
        [UIView animateWithDuration:1.0 animations:^{
            self.howToImageView2.frame = CGRectMake(self.howToImageView2.frame.origin.x-320, 5, self.view.frame.size.width-35, 283);
        }];
        [UIView animateWithDuration:1.0 animations:^{
            self.howToImageView3.frame = CGRectMake(self.howToImageView3.frame.origin.x-320, 5, self.view.frame.size.width-35, 283);
        }];
    }
    [self indicatePage];
}


-(void) slideHowToRight:(id) sender
{
    // Allow a slide to the right as long as we arent on the 1st how to slide
    if (self.howToImageView.frame.origin.x < 0)
        {
            NSLog(@"Size %f", self.howToImageView.frame.origin.x);
        [UIView animateWithDuration:1.0 animations:^{
            self.howToImageView.frame = CGRectMake(self.howToImageView.frame.origin.x+320, 5, self.view.frame.size.width-35, 283);
        }];
        
        [UIView animateWithDuration:1.0 animations:^{
            self.howToImageView2.frame = CGRectMake(self.howToImageView2.frame.origin.x+320, 5, self.view.frame.size.width-35, 283);
        }];
        [UIView animateWithDuration:1.0 animations:^{
            self.howToImageView3.frame = CGRectMake(self.howToImageView3.frame.origin.x+320, 5, self.view.frame.size.width-35, 283);
        }];
    }
    [self indicatePage];
}

-(void) indicatePage
{
    if (self.howToImageView.frame.origin.x == 0)
        [self.pageIndicator setCurrentPage:0];
    else if (self.howToImageView.frame.origin.x == -320)
        [self.pageIndicator setCurrentPage:1];
    else
        [self.pageIndicator setCurrentPage:2];
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
    [self setPageIndicator:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void)createHowToWithStep1
{
    self.howToImageView  = [[UIImageView alloc] initWithFrame:CGRectMake(0, 5, self.view.frame.size.width-35, 283)];
    self.howToImageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(320, 5, self.view.frame.size.width-35, 283)];
    self.howToImageView3 = [[UIImageView alloc] initWithFrame:CGRectMake(640, 5, self.view.frame.size.width-35, 283)];
    
    [self.howToImageView setImage:self.howToImage1];
    [self.howToImageView2 setImage:self.howToImage2];
    [self.howToImageView3 setImage:self.howToImage3];
    
    [self.howToScrollView addSubview:self.howToImageView];
    [self.howToScrollView addSubview:self.howToImageView2];
    [self.howToScrollView addSubview:self.howToImageView3];
}



@end
