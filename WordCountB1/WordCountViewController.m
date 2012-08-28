//
//  WordCountViewController.m
//  WordCountB1
//
//  Created by Clayton Selby on 8/25/12.
//  Copyright (c) 2012 abc. All rights reserved.
//

#import "WordCountViewController.h"
#import "WordListViewController.h"
#import "ReportViewController.h"

@interface WordCountViewController ()

@end

@implementation WordCountViewController

@synthesize wordListView = _wordListView;
@synthesize slideBackButton = _slideBackButton;
@synthesize orange1 = _orange1;
@synthesize orange2 = _orange2;
@synthesize orange3 = _orange3;
@synthesize orange4 = _orange4;
@synthesize orangeImage = _orangeImage;

ReportViewController* reportView ;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    self.orangeImage = [UIImage imageNamed:@"orangeButton.png"];


    if (self) {
        // Custom initialization
        [self buildWordButtons];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.wordListView = self.view.superview;
    [self.slideBackButton setEnabled:NO];
   // [self buildWordButtons];
    


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

    [UIView animateWithDuration:0.7 delay:0 options:UIViewAnimationCurveEaseInOut animations:^{
            self.view.frame = CGRectMake(windowWidth-50,0, windowWidth, windowHeight);
        
        
        
    } completion:^ (BOOL completed) {
        UIButton *touchBackButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, windowHeight)];
        [self.view addSubview:touchBackButton];
        self.slideBackButton = touchBackButton;
        [touchBackButton addTarget:self action:@selector(slideViewBack) forControlEvents:UITouchPhaseEnded];
 
       
    }];
    
    
    
}

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

-(void) buildWordButtons
{
    // TODO Extract the hard coded button positions into variables
    // Should this be computed (Retina vs standard screen)
    
    CGFloat yStartPosition = 60;
    
    UIButton *button1 = [[UIButton alloc] initWithFrame:CGRectMake(165, 70, 147, 135)];
    [button1 setImage:[UIImage imageNamed:@"Word-Counter-Element-without-button"] forState:UIControlStateNormal];
    [button1 addTarget:self action:nil forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button1];
    
    UIButton *button2 = [[UIButton alloc] initWithFrame:CGRectMake(7, 70, 147, 135)];
    [button2 setImage:[UIImage imageNamed:@"Word-Counter-Element-without-button"] forState:UIControlStateNormal];
    [button2 addTarget:self action:nil forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button2];
    
    UIButton *button3 = [[UIButton alloc] initWithFrame:CGRectMake(7, 235, 147, 135)];
    [button3 setImage:[UIImage imageNamed:@"Word-Counter-Element-without-button"] forState:UIControlStateNormal];
    [button3 addTarget:self action:nil forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button3];
    
    
    UIButton *button4 = [[UIButton alloc] initWithFrame:CGRectMake(165, 235, 147, 135)];
    [button4 setImage:[UIImage imageNamed:@"Word-Counter-Element-without-button"] forState:UIControlStateNormal];
    [button4 addTarget:self action:nil forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button4];
    
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(60, 107, 50, 25)];
    [label1 setText:@"Like"];
    [label1 setTextColor:[UIColor whiteColor]];
    [label1 setBackgroundColor:[UIColor clearColor]];
    [button1 addSubview: label1];
    
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(60, 107, 50, 25)];
    [label2 setText:@"You Know"];
    [label2 setTextColor:[UIColor whiteColor]];
    [label2 setBackgroundColor:[UIColor clearColor]];
    [button2 addSubview: label2];
    
    UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(60, 107, 50, 25)];
    [label3 setText:@"Umm.."];
    [label3 setTextColor:[UIColor whiteColor]];
    [label3 setBackgroundColor:[UIColor clearColor]];
    [button3 addSubview: label3];
    
    UILabel *label4 = [[UILabel alloc] initWithFrame:CGRectMake(60, 107, 50, 25)];
    [label4 setText:@"So"];
    [label4 setTextColor:[UIColor whiteColor]];
    [label4 setBackgroundColor:[UIColor clearColor]];
    [button4 addSubview: label4];
    
    self.orange1 = [[UIButton alloc] initWithFrame:CGRectMake(45, 72, 64, 32.5)];
    [self.orange1 setImage:self.orangeImage forState:UIControlStateNormal];
    [self.orange1 addTarget:self action:@selector(countWord:) forControlEvents:UIControlEventTouchUpInside];
    [button1 addSubview:self.orange1];
    
    self.orange2 = [[UIButton alloc] initWithFrame:CGRectMake(45, 72, 64, 32.5)];
    [self.orange2 setImage:self.orangeImage forState:UIControlStateNormal];
    [self.orange2 addTarget:self action:@selector(countWord:) forControlEvents:UIControlEventTouchUpInside];
    [button2 addSubview:self.orange2];
    
    self.orange3 = [[UIButton alloc] initWithFrame:CGRectMake(45, 72, 64, 32.5)];
    [self.orange3 setImage:self.orangeImage forState:UIControlStateNormal];
    [self.orange3 addTarget:self action:@selector(countWord:) forControlEvents:UIControlEventTouchUpInside];
    [button3 addSubview:self.orange3];
    
    self.orange4 = [[UIButton alloc] initWithFrame:CGRectMake(45, 72, 64, 32.5)];
    [self.orange4 setImage:self.orangeImage forState:UIControlStateNormal];
    [self.orange4 addTarget:self action:@selector(countWord:) forControlEvents:UIControlEventTouchUpInside];
    [button4 addSubview:self.orange4];
     reportView = [[ReportViewController alloc] initWithNibName:@"ReportViewController" bundle:nil];
    [self hideReportView];
    

}

-(void) hideReportView
{   
    reportView.view.frame = CGRectMake(320, 0, 320, 460);
    [self addChildViewController:reportView];
    [self.view addSubview:reportView.view];
}

- (IBAction)showReportView:(id)sender
{
    [UIView animateWithDuration:1.0 animations:^{
        reportView.view.frame = CGRectMake(0, 0, 320, 460);
    }];


}

-(void) countWord:(id)sender
{
    UIButton *sentButton = (UIButton *)sender;
    
    // Show the numbers for the word count
    if (sentButton == self.orange1)
    {
        NSLog(@"yes");
    }
    [UIView animateWithDuration:.3 animations:^
     {
         sentButton.frame = CGRectMake(45, 90, 64, 14.5);
     }completion:^(BOOL finished)
     {
         [UIView animateWithDuration:.3 animations:^
          {
                sentButton.frame = CGRectMake(45, 72, 64, 32.5);
          }];
       
     }];
   
}

@end
