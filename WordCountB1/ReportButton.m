//
//  ReportButton.m
//  WordCountB1
//
//  Created by Clayton Selby on 9/8/12.
//  Copyright (c) 2012 abc. All rights reserved.
//

#import "ReportButton.h"

@interface ReportButton()

- (UIImage *)burnText:(NSString *)text intoImage:(UIImage *)img;

@end

@implementation ReportButton

@synthesize wordTitle = _wordTitle;
@synthesize wordCount = _wordCount;
@synthesize countSlider = _countSlider;
@synthesize sliderMax = _sliderMax;
@synthesize sliderAmount = _sliderAmount;
@synthesize thumbImage = _thumbImage;


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
    self.thumbImage = [UIImage imageNamed:@"reportSliderThumb"];
    
}
-(void) buildSliderObject
{
    self.countSlider = [[UISlider alloc] initWithFrame:CGRectMake(20, self.frame.size.height/2-5, self.frame.size.width - 30, 20)];
    [self.countSlider setMinimumValue:0];
    UIImage *minImage = [[UIImage imageNamed:@"reportSliderMin"]
                         resizableImageWithCapInsets:UIEdgeInsetsMake(0, 6, 0, 0)];
    UIImage *maxImage = [[UIImage imageNamed:@"reportSliderMax"]
                         resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 6)];
    

    
    
    [[UISlider appearance] setMaximumTrackImage:maxImage forState:UIControlStateNormal];
    [[UISlider appearance] setMinimumTrackImage:minImage forState:UIControlStateNormal];
    

    
    [self.countSlider setMaximumValue:self.sliderMax];
    [self.countSlider setValue:self.sliderAmount];
    [self.countSlider setUserInteractionEnabled:false];
    [self.countSlider setBackgroundColor:[UIColor clearColor]];
    [[UISlider appearance] setThumbImage:[self burnText:[NSString stringWithFormat:@"%i", (int)self.countSlider.value] intoImage:self.thumbImage] forState:UIControlStateNormal];
    [self addSubview:self.countSlider];
    
    //UIImage* temp = [self burnText:@"4" intoImage:self.thumbImage];
    
    //    [[UISlider appearance] setThumbImage:[self burnText:@"5" intoImage:thumbImage]  forState:UIControlStateNormal];
}

- (UIImage *)burnText:(NSString *)text intoImage:(UIImage *)img {
    UIGraphicsBeginImageContext(img.size);

    CGRect aRectangle = CGRectMake(0,0, img.size.width, img.size.height);
    [img drawInRect:aRectangle];
    
    [[UIColor whiteColor] set];           // set text color
    NSInteger fontSize = 18;
    if ( [text length] > 2 ) {
        fontSize = 10;
        aRectangle.origin.y += 6;
        aRectangle.origin.x += 1;
    } else if ([text length] == 2) {
        fontSize = 15;
        aRectangle.origin.y += 3;
        aRectangle.origin.x += 1;
    } else {
        fontSize = 18;
        aRectangle.origin.y += 2;
        aRectangle.origin.x += 1;
    }
    UIFont *font = [UIFont boldSystemFontOfSize: fontSize];     // set text font
    
    [text drawInRect : aRectangle                      // render the text
             withFont : font
        lineBreakMode : UILineBreakModeClip  // clip overflow from end of last line
            alignment : UITextAlignmentCenter ];
    
    UIImage *theImage=UIGraphicsGetImageFromCurrentImageContext();   // extract the image
 
    UIGraphicsEndImageContext();     // clean  up the context.
    return theImage;
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
    //[self.countSlider setMaximumValueImage:[UIImage imageNamed:@"orangeButton"]];
    //[self.countSlider
    [self buildSliderObject];
}

@end
