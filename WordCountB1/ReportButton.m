//
//  ReportButton.m
//  WordCountB1
//
//  Created by Clayton Selby on 9/8/12.
//  Copyright (c) 2012 abc. All rights reserved.
//

#import "ReportButton.h"

@implementation ReportButton

@synthesize wordTitle = _wordTitle;
@synthesize wordCount = _wordCount;
@synthesize countSlider = _countSlider;
@synthesize sliderMax = _sliderMax;
@synthesize sliderAmount = _sliderAmount;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupButtonFrame];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

-(void) setupButtonFrame
{
    //[self setBackgroundColor:[UIColor grayColor]];
    UIImage* reportImageBackground = [UIImage imageNamed:@"reportElementBackground.png"];
    [self setImage:reportImageBackground forState:UIControlStateNormal];
    [self setUserInteractionEnabled:NO];
    
}
-(void) buildSliderObject
{
    self.countSlider = [[UISlider alloc] initWithFrame:CGRectMake(20, self.frame.size.height/2-5, self.frame.size.width - 30, 20)];
    [self.countSlider setMinimumValue:0];
    UIImage *minImage = [[UIImage imageNamed:@"reportSliderMin"]
                         resizableImageWithCapInsets:UIEdgeInsetsMake(0, 6, 0, 0)];
    UIImage *maxImage = [[UIImage imageNamed:@"reportSliderMax"]
                         resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 6)];
    UIImage *thumbImage = [UIImage imageNamed:@"reportSliderThumb"];
    
    [[UISlider appearance] setMaximumTrackImage:maxImage forState:UIControlStateNormal];
    [[UISlider appearance] setMinimumTrackImage:minImage forState:UIControlStateNormal];
    [[UISlider appearance] setThumbImage:thumbImage forState:UIControlStateNormal];
    
    [self.countSlider setMaximumValue:self.sliderMax];
    [self.countSlider setValue:self.sliderAmount];
    [self.countSlider setUserInteractionEnabled:false];
    [self.countSlider setBackgroundColor:[UIColor clearColor]];
    [self addSubview:self.countSlider];
}


-(void) buildWordTitle:(NSString *)title
{
    UILabel* titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 400, 10)];
    [titleLabel setText:title];
    [titleLabel setTextColor:[UIColor grayColor]];
    [titleLabel setFont:[UIFont boldSystemFontOfSize:13]];
    [titleLabel setBackgroundColor:[UIColor clearColor]];
    [self insertSubview:titleLabel aboveSubview:self.countSlider];
    //[self bringSubviewToFront:titleLabel];
}

-(void)setSliderAmount:(int)sliderAmount
{
    _sliderAmount = sliderAmount;
    [self.countSlider setMaximumValueImage:[UIImage imageNamed:@"orangeButton"]];
    //[self.countSlider
    [self buildSliderObject];
}

@end
