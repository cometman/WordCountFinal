//
//  ReportButton.h
//  WordCountB1
//
//  Created by Clayton Selby on 9/8/12.
//  Copyright (c) 2012 abc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReportButton : UIButton

@property (nonatomic) NSString* wordTitle;
@property (nonatomic) NSString* wordCount;
@property (nonatomic) UISlider* countSlider;

-(void) buildWordTitle:(NSString *)title;

@end
