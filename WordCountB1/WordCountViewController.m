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
@synthesize orange1 = _orange1;
@synthesize orange2 = _orange2;
@synthesize orange3 = _orange3;
@synthesize orange4 = _orange4;
@synthesize orangeImage = _orangeImage;
@synthesize wordListModel = _wordListModel;
@synthesize  button1 = _button1;
@synthesize w1 = _w1;
@synthesize w2 = _w2;
@synthesize w3 = _w3;
@synthesize w4 = _w4;

ReportViewController* reportView ;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    self.orangeImage = [UIImage imageNamed:@"orangeButton.png"];


    if (self) {
        // Custom initialization
        [self setWordModel];
        [self buildWordButtons];
     
    }
    return self;
}

- (void) setWordModel
{
    SharedStore *store = [[SharedStore alloc] init];
    self.wordListModel = [store getDefaultWordList];
    
    self.w1 = [self.wordListModel.words objectAtIndex:0];
    self.w2 = [self.wordListModel.words objectAtIndex:1];
    self.w3 = [self.wordListModel.words objectAtIndex:2];
    self.w4 = [self.wordListModel.words objectAtIndex:3];

}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.wordListView = self.view.superview;
    [self.slideBackButton setEnabled:NO];
    NSString *currentListTitle = [[NSUserDefaults standardUserDefaults] objectForKey:@"currentList"];
    if (!currentListTitle) {
        
    }
   // [self buildWordButtons];
    


//    [self createTouchUpForWordCount];
    // Do any additional setup after loading the view from its nib.
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

    self.button1 = [[CountButton alloc] initWithFrame:CGRectMake(165, 70, 147, 135)];
//    [button1 addTarget:self action:@selector(countWord1:) forControlEvents:UITouchPhaseEnded];
    [self.button1.buttonTrigger addTarget:self action:@selector(countWord:) forControlEvents:UITouchPhaseEnded];
     [self.button1 addTarget:self action:@selector(countWord:) forControlEvents:UITouchPhaseEnded];
    [self.button1 addTitleLabel:self.w1.word];
    [self.view addSubview:self.button1];
    
    CountButton *button2 = [[CountButton alloc] initWithFrame:CGRectMake(7, 70, 147, 135)];
//    [button2 addTarget:self action:@selector(countWord2:) forControlEvents:UITouchPhaseEnded];
    [button2.buttonTrigger addTarget:self action:@selector(countWord:) forControlEvents:UITouchPhaseEnded];
    [button2 addTitleLabel:self.w2.word];
    [self.view addSubview:button2];
    
    CountButton *button3 = [[CountButton alloc] initWithFrame:CGRectMake(7, 235, 147, 135)];
//    [button3 addTarget:self action:@selector(countWord3:) forControlEvents:UITouchPhaseEnded];
    [button3.buttonTrigger addTarget:self action:@selector(countWord:) forControlEvents:UITouchPhaseEnded];
    [button3 addTitleLabel:self.w3.word];
    [self.view addSubview:button3];
    
    CountButton *button4 = [[CountButton alloc] initWithFrame:CGRectMake(165, 235, 147, 135)];
//    [button4 addTarget:self action:@selector(countWord4:) forControlEvents:UITouchPhaseEnded];
    [button4.buttonTrigger addTarget:self action:@selector(countWord:) forControlEvents:UITouchPhaseEnded];
    [button4 addTitleLabel:self.w4.word];
    [self.view addSubview:button4];
}

-(void) createDefaultWordList
{
    
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

- (IBAction)showReportView:(id)sender
{
    [UIView animateWithDuration:1.0 animations:^{
        reportView.view.frame = CGRectMake(0, 0, 320, 460);
    }];
}


- (void) countWord:(id)sender
{
  //  if (sender == self.button1)
    //{
//        if (sender == self.button1.buttonTrigger)
//        {
//            UIButton* countButton = sender;
//            //[self animateOrangeButton: countButton];
//        }
    if (sender == self.button1 || sender == self.button1.buttonTrigger)
    {
        [self animateOrangeButton: self.button1.buttonTrigger];
        self.w1.count++;
        [self countHelperForButton:self.button1];
    }

  //  }
     
  
    

}

-(void) countHelperForButton:(UIButton *)button
{
    if (self.w1.count <= 9)
    {
        [self.button1.onesLabel setText:[NSString stringWithFormat:@("%d"), self.w1.count]];
    }
    else {
         [self.button1.tensLabel setText:[NSString stringWithFormat:@("%d"), self.w1.count%10]];
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
@end
