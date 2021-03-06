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
<<<<<<< HEAD
#import "CountButton.h"
=======
#import "SharedStore.h"
#import "WordListModel.h"
>>>>>>> 5f45c5a8e3ca57f3834f73090348283ea23fc154

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
<<<<<<< HEAD
=======
    NSString *currentListTitle = [[NSUserDefaults standardUserDefaults] objectForKey:@"currentList"];
    if (!currentListTitle) {
        
    }
   // [self buildWordButtons];
    


//    [self createTouchUpForWordCount];
    // Do any additional setup after loading the view from its nib.
>>>>>>> 5f45c5a8e3ca57f3834f73090348283ea23fc154
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)showWordList:(id)sender {
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
    [self.slideBackButton setEnabled:NO];
    CGFloat windowWidth = self.view.frame.size.width;
    CGFloat windowHeight =self.view.frame.size.height;
    
    [UIView animateWithDuration:0.7 delay:0 options:UIViewAnimationCurveEaseInOut animations:^{
        self.view.frame = CGRectMake(0,0, windowWidth, windowHeight);
    } completion:nil];
}

- (void)setValues {
    NSString *currentListTitle = [[NSUserDefaults standardUserDefaults] objectForKey:@"currentList"];
    if (!currentListTitle) {
    }
}

-(void) buildWordButtons
{

    CountButton* button1 = [[CountButton alloc] initWithFrame:CGRectMake(165, 70, 147, 135)];
    [button1 addTarget:self action:@selector(countWord:) forControlEvents:UITouchPhaseEnded];
     [button1.buttonTrigger addTarget:self action:@selector(countWord:) forControlEvents:UITouchPhaseEnded];
    [self.view addSubview:button1];
    
    CountButton *button2 = [[CountButton alloc] initWithFrame:CGRectMake(7, 70, 147, 135)];
    [self.view addSubview:button2];
    
    CountButton *button3 = [[CountButton alloc] initWithFrame:CGRectMake(7, 235, 147, 135)];
    [self.view addSubview:button3];
    
    CountButton *button4 = [[CountButton alloc] initWithFrame:CGRectMake(165, 235, 147, 135)];
    [self.view addSubview:button4];
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
    // If the user clicked the whole button (we have to reference what to animate)
    if ([sender isKindOfClass:[CountButton class]])
    {
        NSLog(@"It is a button!");
        CountButton *sentButton = (CountButton *)sender;
        
        NSLog(@"yes");
        
        [UIView animateWithDuration:.3 animations:^
         {
             sentButton.buttonTrigger.frame = CGRectMake(45, 90, 64, 14.5);
         }completion:^(BOOL finished)
         {
             [UIView animateWithDuration:.3 animations:^
              {
                  sentButton.buttonTrigger.frame = CGRectMake(45, 72, 64, 32.5);
              }];
             
         }];

    }
    
    // If the user clicked just the orange trigger..
    else{
        UIButton *trigger = (UIButton *)sender;
        [UIView animateWithDuration:.3 animations:^
         {
             trigger.frame = CGRectMake(45, 90, 64, 14.5);
         }completion:^(BOOL finished)
         {
             [UIView animateWithDuration:.3 animations:^
              {
                  trigger.frame = CGRectMake(45, 72, 64, 32.5);
              }];
             
         }];

    }
      
}

@end
