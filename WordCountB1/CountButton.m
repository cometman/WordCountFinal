//
//  CountButton.m
//  WordCountB1
//
//  Created by Clayton Selby on 9/2/12.
//  Copyright (c) 2012 abc. All rights reserved.
//

#import "CountButton.h"
#import "WCWord.h"
#import "SharedStore.h"
#import "WordListModel.h"

@implementation CountButton

@synthesize hundredsLabel = _hundredsLabel;
@synthesize onesLabel = _onesLabel;
@synthesize tensLabel = _tensLabel;
@synthesize countLabelX = _countLabelX;
@synthesize buttonTrigger = _buttonTrigger;
@synthesize currentWord = _currentWord;
@synthesize titleLabel = _titleLabel;

#define COUNT_LABEL_Y 35
#define COUNT_LABEL_HEIGHT 25
#define COUNT_LABEL_WIDTH 25

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundImage:[UIImage imageNamed:@"Word-Counter-Element-without-button"] forState:UIControlStateNormal];
        [self addButtonTrigger];
        [self addCountingLabels];
        [self addTitleLabel];
        

    }
    return self;
}

-(void) addTitleLabel
{
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 107, 50, 25)];
    [self.titleLabel setText:self.currentWord.word ];
    [self.titleLabel setTextColor:[UIColor whiteColor]];
    [self.titleLabel setBackgroundColor:[UIColor clearColor]];
    [self addSubview: self.titleLabel];
}

-(void) addButtonTrigger
{
     self.buttonTrigger = [[UIButton alloc] initWithFrame:CGRectMake(45, 72, 64, 32.5)];
    [self.buttonTrigger setImage:[UIImage imageNamed:@"orangeButton.png"] forState:UIControlStateNormal];
    //[buttonTrigger addTarget:self action:@selector(countWord:) forControlEvents:UIControlEventTouchUpInside];

    [self addSubview:self.buttonTrigger];
}

-(void) addCountingLabels
{
    self.currentWord.count = 0;
    self.countLabelX = 100;
    
    self.onesLabel = [[UILabel alloc] initWithFrame: CGRectMake(self.countLabelX, COUNT_LABEL_Y, COUNT_LABEL_WIDTH, COUNT_LABEL_HEIGHT)];
    [self.onesLabel setBackgroundColor:[UIColor clearColor]];
    [self.onesLabel setText:@"0"];
    [self.onesLabel setTextColor:[UIColor whiteColor]];
    [self.onesLabel setFont:[self createLabelFont]];
    
    self.countLabelX -= 35;
    
    self.tensLabel = [[UILabel alloc] initWithFrame: CGRectMake(self.countLabelX, COUNT_LABEL_Y, COUNT_LABEL_WIDTH, COUNT_LABEL_HEIGHT)];
    [self.tensLabel setBackgroundColor:[UIColor clearColor]];
    [self.tensLabel setText:@"0"];
    [self.tensLabel setTextColor:[UIColor whiteColor]];
    [self.tensLabel setFont:[self createLabelFont]];
    
    self.countLabelX -= 35;
    
    self.hundredsLabel = [[UILabel alloc] initWithFrame: CGRectMake(self.countLabelX, COUNT_LABEL_Y, COUNT_LABEL_WIDTH, COUNT_LABEL_HEIGHT)];
    [self.hundredsLabel setBackgroundColor:[UIColor clearColor]];
    [self.hundredsLabel setText:@"0"];
    [self.hundredsLabel setTextColor:[UIColor whiteColor]];
    [self.hundredsLabel setFont:[self createLabelFont]];
    
    [self addSubview:self.onesLabel];
    [self addSubview:self.tensLabel];
    [self addSubview:self.hundredsLabel];
}

-(UIFont*) createLabelFont
{
    UIFont* labelFont = [[UIFont alloc] init];
    labelFont= [UIFont boldSystemFontOfSize:32];
    return labelFont;
}

-(void) incrementCounterLabel
{
    [self.onesLabel setText:[NSString stringWithFormat:@"%d", self.currentWord.count]];
}

-(void)changeWords:(WCWord *)newWord
{
    // Remove all the old components
    [self.onesLabel removeFromSuperview];
    [self.tensLabel removeFromSuperview];
    [self.hundredsLabel removeFromSuperview];
    //[self.titleLabel removeFromSuperview];
    
    // Set the new word
    self.currentWord = newWord;
    
    // Add the new count labels
    [self addCountingLabels];    
 
    
    // Add the new label
 //   [self addTitleLabel:newWord.word];
    
}
@end
