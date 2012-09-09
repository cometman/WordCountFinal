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


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupButtonFrame];
        [self buildSliderObject];
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
    [self setBackgroundColor:[UIColor grayColor]];
    
}
-(void) buildSliderObject
{
    self.countSlider = [[UISlider alloc] initWithFrame:CGRectMake(20, self.frame.size.height/2-10, self.frame.size.width - 30, 20)];
    [self addSubview:self.countSlider];
}


-(void) buildWordTitle:(NSString *)title
{
    UILabel* titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 400, 10)];
    [titleLabel setText:title];
    [titleLabel setTextColor:[UIColor blackColor]];
    [titleLabel setBackgroundColor:[UIColor clearColor]];
    [self addSubview:titleLabel];
}


@end
