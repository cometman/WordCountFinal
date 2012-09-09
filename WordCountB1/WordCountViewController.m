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
#import "CountButton.h"
#import "SharedStore.h"
#import "WordListModel.h"
#import "WCWord.h"
#import "HowToViewController.h"

@interface WordCountViewController ()

@end

@implementation WordCountViewController

@synthesize wordListView = _wordListView;
@synthesize slideBackButton = _slideBackButton;
@synthesize button1 = _button1;
@synthesize button2 = _button2;
@synthesize button3 = _button3;
@synthesize button4 = _button4;
@synthesize w1 = _w1;
@synthesize w2 = _w2;
@synthesize w3 = _w3;
@synthesize w4 = _w4;

ReportViewController* reportView ;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];


    if (self) {
        reportView = [[ReportViewController alloc] initWithNibName:@"ReportViewController" bundle:nil];
     
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.wordListView = self.view.superview;
    [self.slideBackButton setEnabled:NO];

    self.w1 = [[[[SharedStore sharedList] getCurrentWordListModel] words] objectAtIndex:0];
    self.w2 = [[[[SharedStore sharedList] getCurrentWordListModel] words] objectAtIndex:1];
    self.w3 = [[[[SharedStore sharedList] getCurrentWordListModel] words] objectAtIndex:2];
    self.w4 = [[[[SharedStore sharedList] getCurrentWordListModel] words] objectAtIndex:3];
    
    [self buildWordButtons];
    [self hideReportView];
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
    self.w1 = [[[[SharedStore sharedList] getCurrentWordListModel] words] objectAtIndex:0];
    self.w2 = [[[[SharedStore sharedList] getCurrentWordListModel] words] objectAtIndex:1];
    self.w3 = [[[[SharedStore sharedList] getCurrentWordListModel] words] objectAtIndex:2];
    self.w4 = [[[[SharedStore sharedList] getCurrentWordListModel] words] objectAtIndex:3];
    
    [self.button1 changeWords:self.w1];
    [self.button2 changeWords:self.w2];
    [self.button3 changeWords:self.w3];
    [self.button4 changeWords:self.w4];
    
    [self.button1.titleLabel  setText:self.button1.currentWord.word];
    [self.button2.titleLabel  setText:self.button2.currentWord.word];
    [self.button3.titleLabel  setText:self.button3.currentWord.word];
    [self.button4.titleLabel  setText:self.button4.currentWord.word];
    
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
    self.button1 = [[CountButton alloc] initWithFrame:CGRectMake(165, 70, 147, 135)];
    self.button1.currentWord = self.w1;
    [self.button1.buttonTrigger addTarget:self action:@selector(countWord:) forControlEvents:UITouchPhaseEnded];
    [self.button1 addTarget:self action:@selector(countWord:) forControlEvents:UITouchPhaseEnded];
    [self.button1.titleLabel setText:self.w1.word];
    [self.view addSubview:self.button1];
    
    self.button2 = [[CountButton alloc] initWithFrame:CGRectMake(7, 70, 147, 135)];
    self.button2.currentWord = self.w2;
    [self.button2.buttonTrigger addTarget:self action:@selector(countWord:) forControlEvents:UITouchPhaseEnded];
    [self.button2 addTarget:self action:@selector(countWord:) forControlEvents:UITouchPhaseEnded];
    [self.button2.titleLabel setText:self.w2.word];
    [self.view addSubview:self.button2];
    
    self.button3 = [[CountButton alloc] initWithFrame:CGRectMake(7, 235, 147, 135)];
    self.button3.currentWord = self.w3;
    [self.button3.buttonTrigger addTarget:self action:@selector(countWord:) forControlEvents:UITouchPhaseEnded];
    [self.button3 addTarget:self action:@selector(countWord:) forControlEvents:UITouchPhaseEnded];
    [self.button3.titleLabel setText:self.w3.word];
    [self.view addSubview:self.button3];
    
    self.button4 = [[CountButton alloc] initWithFrame:CGRectMake(165, 235, 147, 135)];
    self.button4.currentWord = self.w4;
    [self.button4.buttonTrigger addTarget:self action:@selector(countWord:) forControlEvents:UITouchPhaseEnded];
    [self.button4 addTarget:self action:@selector(countWord:) forControlEvents:UITouchPhaseEnded];
    [self.button4.titleLabel setText:self.w4.word];
    [self.view addSubview:self.button4];
}

-(void) hideReportView
{   
    reportView.view.frame = CGRectMake(320, 0, 320, 460);
    [self addChildViewController:reportView];
    [self.view addSubview:reportView.view];
}

- (IBAction)showHowTo:(UIButton *)sender {
    HowToViewController *htc = [[HowToViewController alloc] initWithNibName:@"HowToViewController" bundle:[NSBundle mainBundle]];
    UIView *howToView = htc.view;
    [howToView setFrame:CGRectMake(20, 50, howToView.frame.size.width, howToView.frame.size.height)];
    [self.view addSubview:howToView];
}


- (void) countWord:(id)sender
{
    if (sender == self.button1 || sender == self.button1.buttonTrigger)
    {
        [self animateOrangeButton: self.button1.buttonTrigger];
        self.w1.count++;
        [self countHelperForButton:self.button1];
    }
    if (sender == self.button2 || sender == self.button2.buttonTrigger)
    {
        [self animateOrangeButton: self.button2.buttonTrigger];
        self.w2.count++;
        [self countHelperForButton:self.button2];
    }
    if (sender == self.button3 || sender == self.button3.buttonTrigger)
    {
        [self animateOrangeButton: self.button3.buttonTrigger];
        self.w3.count++;
        [self countHelperForButton:self.button3];
    }
    if (sender == self.button4 || sender == self.button4.buttonTrigger)
    {
        [self animateOrangeButton: self.button4.buttonTrigger];
        self.w4.count++;
        [self countHelperForButton:self.button4];
    }
   
}

-(void) countHelperForButton:(CountButton *)button
{
    // Increment ones
    if (button.currentWord.count % 10 != 0)
    {
        [button.onesLabel setText:[NSString stringWithFormat:@("%d"), button.currentWord.count % 10]];
    }
    // Increment tens
    else if (button.currentWord.count % 100 != 0)
    {
        [button.onesLabel setText:[NSString stringWithFormat:@("%d"), 0]];        
        int tenLabelValue = (button.currentWord.count % 100) / 10;
        [button.tensLabel setText:[NSString stringWithFormat:@("%d"), tenLabelValue]];

    }
    // Increment hundreds
    else
    {
        [button.onesLabel setText:[NSString stringWithFormat:@("%d"), 0]];
        [button.tensLabel setText:[NSString stringWithFormat:@("%d"), 0]];
        int hundresValueLabel = button.currentWord.count / 100;
        [button.hundredsLabel setText:[NSString stringWithFormat:@("%d"), hundresValueLabel]];
    }
}

-(void) animateOrangeButton:(UIButton *)buttonToAnimate
{
    [UIView animateWithDuration:.3 animations:^
     {
         buttonToAnimate.frame = CGRectMake(45, 90, 64, 14.5);
     }completion:^(BOOL finished)
     {
         [UIView animateWithDuration:.3 animations:^
          {
              buttonToAnimate.frame = CGRectMake(45, 72, 64, 32.5);
          }];
         
     }];
}

- (IBAction)slideReportView:(id)sender {
    NSMutableArray* words = [[NSMutableArray alloc] initWithObjects:self.w1, self.w2, self.w3, self.w4, nil];
    [reportView buildCountButtons:words];
    
    [UIView animateWithDuration:1.0 animations:^{
        reportView.view.frame = CGRectMake(0, 0, 320, 460);
    }];
}
@end
