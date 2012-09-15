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
- (IBAction)cancelReportView:(id)sender {
    [UIView animateWithDuration:1.0 animations:^{
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
    FaceBookViewController* faceBookViewController = [[FaceBookViewController alloc] initWithNibName:@"FaceBookViewController" bundle:nil];

    [self presentModalViewController:faceBookViewController animated:YES];
    AppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
    
    if (FBSession.activeSession.state == FBSessionStateCreatedTokenLoaded) {
        // Yes, so just open the session (this won't display any UX).
        [appDelegate openSession];
    } else {
        // No, display the login page.
        [appDelegate showLoginView];
    }
}

- (void) buildCountButtons:(NSMutableArray* )words
{
    [self cleanView];
    // Grab the current words
    WordListModel* wordListModel = [[SharedStore sharedList] getCurrentWordListModel];
    WCWord* w1 = [words objectAtIndex:0];
    WCWord* w2 = [words objectAtIndex:1];
    WCWord* w3 = [words objectAtIndex:2];
    WCWord* w4 = [words objectAtIndex:3];
    
    CGFloat xStart = 10;
    CGFloat yStart = 50;
    CGFloat buttonheight = 68;
    CGFloat ySpacer = 78;
    
    self.button1 = [[ReportButton alloc] initWithFrame:CGRectMake(xStart, yStart, self.view.frame.size.width - 20, buttonheight)];
    self.button2 = [[ReportButton alloc] initWithFrame:CGRectMake(xStart, yStart+=ySpacer, self.view.frame.size.width - 20, buttonheight)];
    self.button3 = [[ReportButton alloc] initWithFrame:CGRectMake(xStart, yStart+=ySpacer, self.view.frame.size.width - 20, buttonheight)];
    self.button4 = [[ReportButton alloc] initWithFrame:CGRectMake(xStart, yStart+=ySpacer, self.view.frame.size.width - 20, buttonheight)];
    
    [self.view addSubview:self.button1];
    [self.view addSubview:self.button2];
    [self.view addSubview:self.button3];
    [self.view addSubview:self.button4];
    
    NSString* title1 = [NSString stringWithFormat:@"1.  %@", w1.word];
    NSString* title2 = [NSString stringWithFormat:@"2.  %@", w2.word];
    NSString* title3 = [NSString stringWithFormat:@"3.  %@", w3.word];
    NSString* title4 = [NSString stringWithFormat:@"4.  %@", w4.word];
    
    [self.button1 buildWordTitle: title1];
    [self.button2 buildWordTitle:title2];
    [self.button3 buildWordTitle:title3];
    [self.button4 buildWordTitle:title4];
    
    int sliderMax = [self computeSliderMax:words];
    
    self.button1.sliderMax = sliderMax;
    self.button1.sliderAmount = w1.count;
    
    self.button2.sliderMax = sliderMax;
    self.button2.sliderAmount = w2.count;
    
    self.button3.sliderMax = sliderMax;
    self.button3.sliderAmount = w3.count;
    
    self.button4.sliderMax = sliderMax;
    self.button4.sliderAmount = w4.count;
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
@end
