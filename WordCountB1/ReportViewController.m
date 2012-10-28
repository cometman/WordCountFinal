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
#import <QuartzCore/CoreAnimation.h>
#import <QuartzCore/QuartzCore.h>


@interface ReportViewController ()

@end

@implementation ReportViewController

@synthesize button1 = _button1;
@synthesize button2 = _button2;
@synthesize button3 = _button3;
@synthesize button4 = _button4;
@synthesize faceBookViewController = _faceBookViewController;

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
    
    if ([self isInternetConnected])
    {
        self.faceBookViewController = [[FaceBookViewController alloc] initWithNibName:@"FaceBookViewController" bundle:nil];
        AppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
        
        if (FBSession.activeSession.state == FBSessionStateCreatedTokenLoaded)
        {
            [self createFaceBookPostImage];
            // Yes, so just open the session (this won't display any UX).
            [appDelegate openSession];
           // [faceBookViewController createFriendController];
            [self.faceBookViewController createFriendController];
            NSLog(@"Token created and loaded");
            [self presentModalViewController:self.faceBookViewController animated:YES];

        }
        
        else if (FBSession.activeSession.state == FBSessionStateOpen)
        {
            NSLog(@" Token loaded!");
            [self createFaceBookPostImage];
            [self.faceBookViewController createFriendController];
            [self presentModalViewController:self.faceBookViewController animated:YES];
        }

        else {
            // No, display the login page
            [self createFaceBookPostImage];
            [appDelegate showLoginView];
            
        }
    }
    else {
        UIAlertView* noInternetAlert = [[UIAlertView alloc] initWithTitle:@"Internet Connection Problem" message:@"We were unable to detect a valid internet connection.  You must have a connection to the internet in order to post to Facebook." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [noInternetAlert show];
    }
    
}

-(BOOL) isInternetConnected
{
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [reachability currentReachabilityStatus];
    return !(networkStatus == NotReachable);
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



-(void) createFaceBookPostImage
{    
    // The base canvas image
    UIImage* baseImage = [UIImage imageNamed:@"facebookPost01"];
    UIGraphicsBeginImageContext(baseImage.size);
    

    // Set the full canvas context
    CGRect aRectangle = CGRectMake(0,0, baseImage.size.width, baseImage.size.height);
    [baseImage drawInRect:aRectangle];
    
    int xPosition = 175;
    int yStartPosition = 220;
    int ySpacer = 100;

    CGContextDrawImage(UIGraphicsGetCurrentContext(), CGRectMake(xPosition, yStartPosition, self.button1.bounds.size.width, self.button1.bounds.size.height), [self convertLayer:self.button1.layer].CGImage);
    
     CGContextDrawImage(UIGraphicsGetCurrentContext(), CGRectMake(xPosition, yStartPosition += ySpacer, self.button1.bounds.size.width, self.button1.bounds.size.height), [self convertLayer:self.button2.layer].CGImage);
    
     CGContextDrawImage(UIGraphicsGetCurrentContext(), CGRectMake(xPosition, yStartPosition += ySpacer, self.button1.bounds.size.width, self.button1.bounds.size.height), [self convertLayer:self.button3.layer].CGImage);
    
     CGContextDrawImage(UIGraphicsGetCurrentContext(), CGRectMake(xPosition, yStartPosition += ySpacer, self.button1.bounds.size.width, self.button1.bounds.size.height), [self convertLayer:self.button4.layer].CGImage);

    UIImage *screenshot = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    // Save the PNG to user document directory
    NSData* facebookPostPNG = UIImagePNGRepresentation(screenshot);
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docDir = [paths objectAtIndex: 0];
    NSString *docFile = [docDir stringByAppendingPathComponent: @"facebook.png"];
    
    // Delete any old files
    if ([[NSFileManager defaultManager] fileExistsAtPath:docFile])
    {
        [[NSFileManager defaultManager] removeItemAtPath:docFile error:nil];
    }
    [facebookPostPNG writeToFile: docFile atomically: YES];
    
}

/*
    We need to convert the CALayer objects (The report buttons) into UIImages so that we can extract the CGImageRef, which is how we draw using CGContextDrawImage
 */
-(UIImage*) convertLayer:(CALayer*)layer 
{
    UIGraphicsBeginImageContext(layer.bounds.size);
    
    // These two lines of code flip the image, as it is rendered upside down (Quartz 2d uses a diff coordiante system)
    CGContextTranslateCTM(UIGraphicsGetCurrentContext(), 0, layer.bounds.size.height);
    CGContextScaleCTM(UIGraphicsGetCurrentContext(), 1.0, -1.0);
    
    [layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *returnImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return returnImage;
}


@end
