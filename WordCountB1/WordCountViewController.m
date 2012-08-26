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
           [self buildWordButtons];
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
    
    UIButton *orange1 = [[UIButton alloc] initWithFrame:CGRectMake(45, 72, 64, 32.5)];
    [orange1 setImage:[UIImage imageNamed:@"orangeButton.png"] forState:UIControlStateNormal];
    [orange1 addTarget:self action:@selector(clickOrangeButton:orange1:) forControlEvents:UIControlEventTouchUpInside];
    [button1 addSubview:orange1];
    
    UIButton *orange2 = [[UIButton alloc] initWithFrame:CGRectMake(45, 72, 64, 32.5)];
    [orange2 setImage:[UIImage imageNamed:@"orangeButton.png"] forState:UIControlStateNormal];
    [orange2 addTarget:self action:nil forControlEvents:UIControlEventTouchUpInside];
    [button2 addSubview:orange2];
    
    UIButton *orange3 = [[UIButton alloc] initWithFrame:CGRectMake(45, 72, 64, 32.5)];
    [orange3 setImage:[UIImage imageNamed:@"orangeButton.png"] forState:UIControlStateNormal];
    [orange3 addTarget:self action:nil forControlEvents:UIControlEventTouchUpInside];
    [button3 addSubview:orange3];
    
    UIButton *orange4 = [[UIButton alloc] initWithFrame:CGRectMake(45, 72, 64, 32.5)];
    [orange4 setImage:[UIImage imageNamed:@"orangeButton.png"] forState:UIControlStateNormal];
    [orange4 addTarget:self action:nil forControlEvents:UIControlEventTouchUpInside];
    [button4 addSubview:orange4];
}
@end
