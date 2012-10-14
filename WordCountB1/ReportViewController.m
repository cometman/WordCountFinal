//
//  ReportViewController.m
//  WordCountB1
//
//  Created by Clayton Selby on 8/27/12.
//  Copyright (c) 2012 abc. All rights reserved.
//

#import "ReportViewController.h"
#import "ReportButton.h"
#import "WordListModel.h"
#import "SharedStore.h"
#import "WCWord.h"
#import "FaceBookViewController.h"
#import "AppDelegate.h"
#import "WordCountViewController.h"
#import "WordListViewController.h"
#import <QuartzCore/QuartzCore.h>


@interface ReportViewController ()

@end

@implementation ReportViewController

@synthesize button1 = _button1;
@synthesize button2 = _button2;
@synthesize button3 = _button3;
@synthesize button4 = _button4;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
       // [self buildCountButtons:[[SharedStore sharedList] getCurrentWordListModel]];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"reportBackground"]]];
    

    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
 
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

-(void) viewDidAppear:(BOOL)animated
{
   
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
- (IBAction)cancelReportView:(id)sender {
    [UIView animateWithDuration:.33 animations:^{
         self.view.frame = CGRectMake(320, 0, 320, 460);
    }];
   
}

-(void) cleanView
{
    [self.button1 removeFromSuperview];
    [self.button2 removeFromSuperview];
    [self.button3 removeFromSuperview];
    [self.button4 removeFromSuperview];
}
- (IBAction)shareOnFacebook:(id)sender {
    [self.view addSubview:[self testMethodForDrawing]];

//    FaceBookViewController* faceBookViewController = [[FaceBookViewController alloc] initWithNibName:@"FaceBookViewController" bundle:nil];
//    AppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
//    
//    if (FBSession.activeSession.state == FBSessionStateCreatedTokenLoaded)
//    {
//        // Yes, so just open the session (this won't display any UX).
//        [appDelegate openSession];
//       // [faceBookViewController createFriendController];
//        [faceBookViewController createFriendController];
//        NSLog(@"Token created and loaded");
//        [self presentModalViewController:faceBookViewController animated:YES];
//
//    }
//    
//    else if (FBSession.activeSession.state == FBSessionStateOpen)
//    {
//        NSLog(@" Token loaded!");
//      
//        [faceBookViewController createFriendController];
//        
//        [self presentModalViewController:faceBookViewController animated:YES];
//    }
//
//    else {
//        // No, display the login page
//      [appDelegate showLoginView];
//        
//    }
}

- (void) buildCountButtons:(NSMutableArray* )words
{
    [self cleanView];
    // Grab the current words
    WCWord* w1 = [words objectAtIndex:0];
    WCWord* w2 = [words objectAtIndex:1];
    WCWord* w3 = [words objectAtIndex:2];
    WCWord* w4 = [words objectAtIndex:3];
    
    CGFloat xStart = 10;
    CGFloat yStart = 50;
    CGFloat buttonheight = 78;
    CGFloat ySpacer = 85;
    
    self.button1 = [[ReportButton alloc] initWithFrame:CGRectMake(xStart, yStart, self.view.frame.size.width - 20, buttonheight)];
    self.button2 = [[ReportButton alloc] initWithFrame:CGRectMake(xStart, yStart+=ySpacer, self.view.frame.size.width - 20, buttonheight)];
    self.button3 = [[ReportButton alloc] initWithFrame:CGRectMake(xStart, yStart+=ySpacer, self.view.frame.size.width - 20, buttonheight)];
    self.button4 = [[ReportButton alloc] initWithFrame:CGRectMake(xStart, yStart+=ySpacer, self.view.frame.size.width - 20, buttonheight)];
    
    [self.view addSubview:self.button1];
    [self.view addSubview:self.button2];
    [self.view addSubview:self.button3];
    [self.view addSubview:self.button4];
    
    int sliderMax = [self computeSliderMax:words];
    
    self.button1.sliderMax = sliderMax;
    self.button1.sliderAmount = w1.count;
    
    self.button2.sliderMax = sliderMax;
    self.button2.sliderAmount = w2.count;
    
    self.button3.sliderMax = sliderMax;
    self.button3.sliderAmount = w3.count;
    
    self.button4.sliderMax = sliderMax;
    self.button4.sliderAmount = w4.count;
    
    NSString* title1 = [NSString stringWithFormat:@"1.  %@", w1.word];
    NSString* title2 = [NSString stringWithFormat:@"2.  %@", w2.word];
    NSString* title3 = [NSString stringWithFormat:@"3.  %@", w3.word];
    NSString* title4 = [NSString stringWithFormat:@"4.  %@", w4.word];
    
    [self.button1 buildWordTitle: title1];
    [self.button2 buildWordTitle:title2];
    [self.button3 buildWordTitle:title3];
    [self.button4 buildWordTitle:title4];
}

- (IBAction)postATweet:(id)sender {
    AppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
    [appDelegate postTweet:@"Stuff is magical" andImage:nil];
}

- (IBAction)pushFinishButton:(id)sender {
    [[[SharedStore sharedList] getCurrentWordListModel] resetWordCounts];
    AppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
    
    WordListViewController* wordList = appDelegate.viewController;
    [wordList.wordCountVC.button1 setLabelsAndCountToZero];
    [wordList.wordCountVC.button2 setLabelsAndCountToZero];
    [wordList.wordCountVC.button3 setLabelsAndCountToZero];
    [wordList.wordCountVC.button4 setLabelsAndCountToZero];
    
    [self cancelReportView:self];
}

-(int) computeSliderMax:(NSMutableArray *)words
{
    int max = 0;
    
    for (int i = 0; i < 4; i++)
    {
        WCWord* word = [words objectAtIndex:i];
        if (word.count > max)
        {
            max = word.count;
        }
    }
    
    return max;
}


-(UIScrollView*) testMethodForDrawing
{
    UIScrollView* testView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    UIImageView* testImageView = [[UIImageView alloc] initWithImage:[self createFaceBookPostImage]];
    [testView addSubview:testImageView];
 
    [testView setScrollEnabled:YES];
    return testView;
}
-(UIImage*) createFaceBookPostImage
{    
    // The base canvas image
    UIImage* baseImage = [UIImage imageNamed:@"facebookPost01"];
    UIGraphicsBeginImageContext(baseImage.size);
    

    // Set the full canvas context
    CGRect aRectangle = CGRectMake(0,0, baseImage.size.width, baseImage.size.height);
    [baseImage drawInRect:aRectangle];
   
    // Set the individual slider button contexts
    UIImageView* blankImage = [[UIImageView alloc] initWithFrame:CGRectMake(100, 50,self.button1.bounds.size.width , self.button1.bounds.size.height)];
    [blankImage addSubview:self.button1];
    [blankImage.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImageView* blankImage2 = [[UIImageView alloc] initWithFrame:CGRectMake(100, 150,self.button2.bounds.size.width , self.button2.bounds.size.height)];
    [blankImage2 addSubview:self.button2];
    [blankImage2.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImageView* blankImage3 = [[UIImageView alloc] initWithFrame:CGRectMake(100, 250,self.button3.bounds.size.width , self.button3.bounds.size.height)];
    [blankImage3 addSubview:self.button3];
    [blankImage3.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImageView* blankImage4 = [[UIImageView alloc] initWithFrame:CGRectMake(100, 350,self.button4.bounds.size.width , self.button4.bounds.size.height)];
    [blankImage4 addSubview:self.button4];
    [blankImage4.layer renderInContext:UIGraphicsGetCurrentContext()];

    UIImage *screenshot = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return screenshot;
}



@end
